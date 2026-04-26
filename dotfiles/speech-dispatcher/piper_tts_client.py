#!/usr/bin/env python3

import argparse
import json
import math
import subprocess
import syslog
import traceback
import urllib.request
from pathlib import Path


def available_voices() -> list[str]:
    voices_dir = Path.home() / ".config/speech-dispatcher/voices"
    return [f.stem for f in voices_dir.iterdir() if f.suffix.endswith("onnx")]


def send_tts_request(url: str, voice: str, text: str, speed: float):
    # Remove surrgate characters
    text = text.encode(errors="ignore").decode()

    length_scale = math.exp(math.log(4) * (-speed / 100))
    payload = {"text": text, "length_scale": length_scale, "voice": voice}
    data = json.dumps(payload).encode()

    req = urllib.request.Request(url, data=data, method="POST")
    req.add_header("Content-Type", "application/json")

    with urllib.request.urlopen(req) as response:
        data = response.read()
        if response.getcode() != 200:
            raise ValueError(f"Request failed with status code: {response.getcode()}\n{data}")

        p = subprocess.Popen(
            ["pw-play", "--media-role", "Speech", "-P", "media.name=Text-to-Speech", "-"],
            stdin=subprocess.PIPE,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        p.communicate(data)


def main():
    parser = argparse.ArgumentParser(description="Send text to TTS server")
    parser.add_argument("text", type=str, help="Text to synthesize")
    parser.add_argument(
        "-s",
        "--speed",
        type=float,
        default=0,
        help="speech speed between -100 (fast) and 100 (slow), defaults to 0 (normal)",
    )
    parser.add_argument(
        "-v",
        "--voice",
        type=str,
        help="Voice",
        default="default",
        choices=available_voices(),
    )
    parser.add_argument(
        "--server",
        type=str,
        help="Piper TTS server URL",
        default="http://localhost:9010",
    )
    args = parser.parse_args()

    try:
        send_tts_request(args.server, args.voice, args.text, args.speed)
    except Exception as e:
        subprocess.check_call(
            [
                "notify-send",
                "-a",
                "TTS",
                "-i",
                "preferences-desktop-text-to-speech",
                "-c",
                "normal",
                "Piper TTS Error",
                str(e),
            ]
        )
        syslog.syslog(syslog.LOG_ERR, traceback.format_exc())


if __name__ == "__main__":
    main()
