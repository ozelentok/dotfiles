#!/usr/bin/env python3

import argparse
import mimetypes
import re
import subprocess
import syslog
import traceback
import urllib.request
from pathlib import Path


def send_tts_request(
    url: str,
    text: str,
    output: Path | None,
    sink: str | None,
    voice: str,
    voice_file: Path | None,
) -> None:
    boundary = "----pocket-tts-boundary"
    data = bytearray()
    data.extend(
        f'--{boundary}\r\nContent-Disposition: form-data; name="text"\r\n\r\n{text}\r\n'.encode()
    )
    if voice_file:
        content_type = mimetypes.guess_type(voice_file.name)[0] or "application/octet-stream"
        filename = re.sub(r'[\x00-\x1f\x7f"\\]', "_", voice_file.name)
        data.extend(
            f'--{boundary}\r\nContent-Disposition: form-data; name="voice_wav"; filename="{filename}"\r\nContent-Type: {content_type}\r\n\r\n'.encode()
        )
        data.extend(voice_file.read_bytes())
        data.extend(b"\r\n")
    else:
        data.extend(
            f'--{boundary}\r\nContent-Disposition: form-data; name="voice_url"\r\n\r\n{voice}\r\n'.encode()
        )
    data.extend(f"--{boundary}--\r\n".encode())
    req = urllib.request.Request(url, data=bytes(data), method="POST")
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
    parser.add_argument("-v", "--voice", default="alba", help="Pocket TTS built-in voice")
    parser.add_argument("-c", "--voice-file", type=Path, help="Voice cloning reference audio")
    parser.add_argument("-s", "--sink", help="PipeWire sink name or serial for playback")
    parser.add_argument("--server", default="http://localhost:9010/tts")
    args = parser.parse_args()
    try:
        send_tts_request(
            args.server, args.text, args.output, args.sink, args.voice, args.voice_file
        )
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
