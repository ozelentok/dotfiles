'''
Display default PulseAudio device name

Configuration parameters:
    cache_timeout: refresh interval for this module (default 600)
    format: display format for this module (default ''{name}'')
    reconnection_interval: reconnection to pulseaudio interval after disconnection

Format placeholders:
    {name}   default audio device name
'''

import time
import traceback
from threading import Thread
from typing import Any, Dict

import pulsectl


class Py3status:
    # available configuration parameters
    cache_timeout = 600
    format = '{name}'
    reconnection_interval = 10

    py3: Any

    def post_config_hook(self):
        self._pulse_callback_thread = Thread(target=self._listen_for_sink_changes, daemon=True)
        self._pulse_callback_thread.start()

    def _listen_for_sink_changes(self):
        while True:
            try:
                with pulsectl.Pulse() as pulse:

                    def event_callback(e: pulsectl.PulseEventInfo):
                        if (
                            e.facility == pulsectl.PulseEventFacilityEnum.sink  # type: ignore
                            and e.t == pulsectl.PulseEventTypeEnum.change  # type: ignore
                        ):
                            self.py3.update()

                    pulse.event_mask_set('sink')
                    pulse.event_callback_set(event_callback)
                    pulse.event_listen()

            except pulsectl.PulseDisconnected:
                pass
            except Exception:
                self.py3.error(f'Error registring to pulseaudio changes\n{traceback.format_exc()}')
            time.sleep(self.reconnection_interval)

    def default_audio_device(self) -> Dict:
        with pulsectl.Pulse() as p:
            default_sink = p.server_info().default_sink_name  # type: ignore
            name = p.get_sink_by_name(default_sink).description  # type: ignore

        if not name:
            name = 'No Audio Out'
        elif name.startswith('Built-in Audio Analog'):
            name = 'Line Out'
        elif 'Digital Stereo (HDMI)' in name:
            name = 'HDMI Out'

        return {
            'full_text': self.py3.safe_format(self.format, {'name': name}),
            'cached_until': self.py3.time_in(self.cache_timeout),
        }

    def on_click(self, _):
        self.py3.update()


if __name__ == '__main__':
    from py3status.module_test import module_test

    module_test(Py3status)
