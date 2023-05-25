'''
Display default PulseAudio device name

Configuration parameters:
    cache_timeout: refresh interval for this module (default 600)
    format: display format for this module (default ''{name}'')

Format placeholders:
    {name}   default audio device name
'''

import re
import subprocess
from typing import Any, Dict


class Py3status:
    __PACTL_DESCRIPTION_PATTERN = re.compile(b'device.description = "(.*)"')

    # available configuration parameters
    cache_timeout = 600
    format = '{name}'

    py3: Any

    def default_audio_device(self) -> Dict:
        raw_description = subprocess.check_output(
            'DEF_SINK="$(pactl get-default-sink)"; pacmd list-sinks | grep -e "$DEF_SINK" -e "device.description" | grep "$DEF_SINK" -A 1 | tail -n 1',
            shell=True)

        match = self.__PACTL_DESCRIPTION_PATTERN.search(raw_description)
        if not match:
            raise ValueError('Failed finding default audio device name')

        device_name = match.group(1).decode()
        if device_name.startswith('Built-in Audio Analog'):
            device_name = 'Line Out'

        return {
            'full_text': self.py3.safe_format(self.format, {"name": device_name}),
            'cached_until': self.py3.time_in(self.cache_timeout),
        }

    def on_click(self, _):
        self.py3.update()


if __name__ == "__main__":
    from py3status.module_test import module_test

    module_test(Py3status)
