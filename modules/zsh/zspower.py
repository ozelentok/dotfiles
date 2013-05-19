#!/usr/bin/env python

import os
import sys

colors = {
	'pathBG': 25,
	'pathFG': 255,
	'cmdBG': 22,
}
symbols = {
	'thinSep': u'\u2b81',
	'sep': u'\u2b80'
}

class Painter:
	def __init__(self):
		self.sep = ' ' + symbols['thinSep'] + ' '
		#self.colorTemplate = unicode('\\[\\e[{0};5;{1}m\\]{2}')
		self.colorTemplate = unicode('%{{[{0};5;{1}m%}}{2}')
		#self.endColorTemplate = unicode('\\[\\e[0m\\]')
		self.endColorTemplate = unicode('%{[0m%}')
	def resetColor(self):
		return self.endColorTemplate;
	def drawBG(self, text = '', color = colors['pathBG']):
		return self.colorTemplate.format(
				48, color, text);
	def drawFG(self, text = '', color = colors['pathFG']):
		return self.colorTemplate.format(
				38, color, text);

def main():
	painter = Painter()
	home = os.getenv('HOME')
	cwd = os.getcwd() + ' '

	if cwd.find(home) == 0:
		cwd = cwd.replace(home, ' ~', 1)
	cwd = cwd.replace('/', painter.sep);
	sys.stdout.write(painter.drawBG());
	sys.stdout.write(painter.drawFG(cwd).encode('utf-8'));
	sys.stdout.write(painter.resetColor());
	sys.stdout.write(painter.drawFG(symbols['sep'], colors['pathBG']).encode('utf-8'));
	sys.stdout.write(painter.drawBG(color=colors['cmdBG']));
	sys.stdout.write(painter.drawFG('\n $ ').encode('utf-8'));
	sys.stdout.write(painter.resetColor());
	sys.stdout.write(painter.drawFG(symbols['sep'], colors['cmdBG']).encode('utf-8'));
	sys.stdout.write(painter.resetColor());

if __name__ == '__main__':
	main()
