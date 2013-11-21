#!/usr/bin/env python

import os
import sys
import time

colors = {
  'red': 1,
  'green': 22,
  'pathBG': 25,
  'pathFG': 255,
  'cmdBG': 22,
}
symbols = {
  'thinSep': u'\u2b81',
  'sep': u'\u2b80'
}

class Painter:
  __slots__ = ['sep', 'colorTemplate', 'endColorTemplate']
  def __init__(self):
    self.sep = u' ' + symbols['thinSep'] + u' '
    #self.colorTemplate = unicode('\\[\\e[{0};5;{1}m\\]{2}')
    self.colorTemplate = '%{{[{0};5;{1}m%}}{2}'
    #self.endColorTemplate = unicode('\\[\\e[0m\\]')
    self.endColorTemplate = '%{[0m%}'
  def resetColor(self):
    return self.endColorTemplate;
  def drawBG(self, text = u'', color = colors['pathBG']):
    return self.colorTemplate.format(
        48, color, text);
  def drawFG(self, text = u'', color = colors['pathFG']):
    return self.colorTemplate.format(
        38, color, text);

def main(promptColor):
  painter = Painter()
  home = os.getenv('HOME')
  cwd = os.getcwd() + ' '
  promptString = ''
  if cwd.find(home) == 0:
    cwd = cwd.replace(home, ' ~', 1)
  cwd = cwd.replace('/', painter.sep)
  promptString += painter.drawBG()
  promptString += painter.drawFG(cwd)
  promptString += painter.resetColor()
  promptString += painter.drawFG(symbols['sep'], colors['pathBG'])
  promptString += painter.drawBG(color=colors[promptColor])
  promptString += painter.drawFG(u'\n $ ')
  promptString += painter.resetColor()
  promptString += painter.drawFG(symbols['sep'], colors[promptColor])
  promptString += painter.resetColor()
  sys.stdout.write(promptString)

if __name__ == '__main__':
  main(sys.argv[1])
