'''
Display average CPU temperature

Configuration parameters:
    cache_timeout: refresh interval for this module (default 300)
    format: display format for this module (default ''CPU: {temperature:02d}℃'')
    temperature_warning: minimum temperature to display as warning
    temperature_critical: minimum temperature to dispay as critical

Format placeholders:
    {temperature}   temperature as a floating-point number

Requires:
    lm_sensors: a tool to read temperature/voltage/fan sensors
'''

from typing import Any, List, Dict, Tuple
import json


class Py3status:
    # available configuration parameters
    cache_timeout = 300
    format = 'CPU: {temperature:02d}℃'
    temperature_warning = 60
    temperature_critical = 70

    sensor_name: str
    input_key_pairs: List[Tuple[str, str]]
    py3: Any

    def post_config_hook(self):
        if not self.py3.check_commands('sensors'):
            raise Exception('Failed to find \'sensors\' command')

        self.sensor_name, self.input_key_pairs = self._find_sensor_params(
            self._get_lm_sensors_json())

    def _get_lm_sensors_json(self) -> Dict:
        return json.loads(self.py3.command_output('sensors -j -A'))

    def _find_sensor_params(
            self, sensors_output: Dict) -> Tuple[str, List[Tuple[str, str]]]:
        '''
        Returns the sensor name and pairs of input and key strings
        for accessing the cores temperature
        '''
        for sensor_name, sensor_data in sensors_output.items():
            input_key_pairs: List[Tuple[str, str]] = []
            for input_name, input_data in sensor_data.items():
                if input_name.startswith('Core '):
                    for key in input_data.keys():
                        if key.endswith('_input'):
                            input_key_pairs.append((input_name, key))
            if input_key_pairs:
                return sensor_name, input_key_pairs

        raise Exception('Failed to find cores temperature')

    def avg_cpu_temp(self):
        sensors_output = self._get_lm_sensors_json()

        temperature = 0
        for input_name, input_key in self.input_key_pairs:
            temperature += sensors_output[
                self.sensor_name][input_name][input_key]
        temperature = temperature / len(self.input_key_pairs)
        if temperature < self.temperature_warning:
            color = self.py3.COLOR_GOOD
        elif temperature < self.temperature_critical:
            color = self.py3.COLOR_DEGRADED
        else:
            color = self.py3.COLOR_BAD

        return {
            'full_text':
            self.py3.safe_format(self.format, {"temperature": temperature}),
            'color':
            color,
            'cached_until':
            self.py3.time_in(self.cache_timeout),
        }

    def on_click(self, event):
        self.py3.update()


if __name__ == "__main__":
    from py3status.module_test import module_test

    module_test(Py3status)
