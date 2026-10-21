#!/usr/bin/env python3

import argparse
import subprocess
import syslog
import traceback
import urllib.request
from pathlib import Path


def send_tts_request(
    url: str, voice: str, text: str, output: Path | None, sink: str | None
) -> None:
    boundary = "----pocket-tts-boundary"
    fields = [("text", text), ("voice_url", voice)]
    body_parts = [
        f'--{boundary}\r\nContent-Disposition: form-data; name="{name}"\r\n\r\n{value}\r\n'
        for name, value in fields
    ]
    body_parts.append(f"--{boundary}--\r\n")
    data = "".join(body_parts).encode()
    req = urllib.request.Request(url, data=data, method="POST")
    req.add_header("Content-Type", f"multipart/form-data; boundary={boundary}")
    with urllib.request.urlopen(req) as response:
        audio = response.read()
    if output:
        output.write_bytes(audio)
    else:
        subprocess.run(
            [
                "pw-play",
                "--media-role",
                "Speech",
                "-P",
                "media.name=Text-to-Speech",
                *(["--target", sink] if sink else []),
                "-",
            ],
            input=audio,
            check=True,
        )


def main() -> None:
    parser = argparse.ArgumentParser(description="Send text to Pocket TTS server")
    parser.add_argument("text")
    parser.add_argument(
        "-o", "--output", type=Path, help="Save audio to WAV file instead of playing it"
    )
    parser.add_argument("-v", "--voice", default="alba")
    parser.add_argument("-s", "--sink", help="PipeWire sink name or serial for playback")
    parser.add_argument("--server", default="http://localhost:9010/tts")
    args = parser.parse_args()
    try:
        send_tts_request(args.server, args.voice, args.text, args.output, args.sink)
    except Exception as e:  # noqa: BLE001 speech-dispatcher will disconnect from the module if the error propagates
        subprocess.check_call(
            [
                "notify-send",
                "-a",
                "TTS",
                "-i",
                "preferences-desktop-text-to-speech",
                "-c",
                "normal",
                "Pocket TTS Error",
                str(e),
            ]
        )
        syslog.syslog(syslog.LOG_ERR, traceback.format_exc())


if __name__ == "__main__":
    main()
