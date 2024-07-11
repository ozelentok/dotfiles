'''
Display default PulseAudio device name

Configuration parameters:
    cache_timeout: refresh interval for this module (default 600)
    format: display format for this module (default ''{name}'')

Format placeholders:
    {name}   default audio device name
'''

import syslog
from typing import Any, Dict

import pulsectl


class Py3status:
    # available configuration parameters
    cache_timeout = 600
    format = '{name}'

    py3: Any

    def default_audio_device(self) -> Dict:
        try:
            with pulsectl.Pulse() as pulse:
                default_sink = pulse.server_info().default_sink_name  # type: ignore
                name: str = pulse.get_sink_by_name(default_sink).description  # type: ignore

            if name.startswith('Built-in Audio Analog'):
                name = 'Line Out'
            elif 'Digital Stereo (HDMI)' in name:
                name = 'HDMI Out'

            return {
                'full_text': self.py3.safe_format(self.format, {"name": name}),
                'cached_until': self.py3.time_in(self.cache_timeout),
            }

        except:
            import traceback
            syslog.syslog(traceback.format_exc())
            raise

    def on_click(self, _):
        self.py3.update()


if __name__ == "__main__":
    from py3status.module_test import module_test

    module_test(Py3status)
