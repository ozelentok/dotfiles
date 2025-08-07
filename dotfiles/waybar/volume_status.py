#!/usr/bin/env python3

import json
import time
from argparse import ArgumentParser
from typing import cast

from pulsectl import (Pulse, PulseDisconnected, PulseEventInfo,
                      PulseEventTypeEnum, PulseLoopStop, PulseSinkInfo,
                      PulseSourceInfo)

PULSE_RECONNECTION_INTERVAL_SECS = 10


def get_device_info(
    pulse: Pulse, device_name: str, is_sink: bool
) -> PulseSinkInfo | PulseSourceInfo:
    if is_sink:
        return cast(PulseSinkInfo, pulse.get_sink_by_name(device_name))
    else:
        return cast(PulseSourceInfo, pulse.get_source_by_name(device_name))


def output_device_info(
    info: PulseSinkInfo | PulseSourceInfo,
    display_name: str,
    critical_volume: int,
    warning_volume: int,
) -> None:
    muted = info.mute  # type: ignore
    volume = round(info.volume.value_flat * 100)
    text = f"{display_name} {volume}%"
    alt = ""

    if muted:
        alt = "muted"
    elif volume <= critical_volume:
        alt = "critical"
    elif volume <= warning_volume:
        alt = "warning"

    print(
        json.dumps(
            {
                "text": text,
                "alt": alt,
                "class": alt,
                "percentage": volume,
            }
        ),
        flush=True,
    )


def main() -> None:
    parser = ArgumentParser()
    parser.add_argument("device_name", help="Device name")
    parser.add_argument("device_type", choices=("sink", "source"), help="Type of audio device")
    parser.add_argument("critical_volume", type=int, help="Critical volume threshold")
    parser.add_argument("warning_volume", type=int, help="Warning volume threshold")
    parser.add_argument("display_name", nargs="?", help="Optional alternative display name")

    args = parser.parse_args()
    is_sink = args.device_type == "sink"
    display_name = args.display_name or args.device_name

    while True:
        try:
            with Pulse() as pulse:
                dev_info = get_device_info(pulse, args.device_name, is_sink)
                output_device_info(
                    dev_info, display_name, args.critical_volume, args.warning_volume
                )

                def on_event(e: PulseEventInfo):
                    if e.t == PulseEventTypeEnum.change and e.index == dev_info.index:  # type: ignore
                        raise PulseLoopStop

                pulse.event_mask_set(args.device_type)
                pulse.event_callback_set(on_event)
                while True:
                    pulse.event_listen()
                    dev_info = get_device_info(pulse, args.device_name, is_sink)
                    output_device_info(
                        dev_info, display_name, args.critical_volume, args.warning_volume
                    )

        except PulseDisconnected:
            time.sleep(PULSE_RECONNECTION_INTERVAL_SECS)


if __name__ == "__main__":
    main()
