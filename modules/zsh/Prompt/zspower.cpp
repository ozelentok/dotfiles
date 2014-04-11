// Filename: zspower.cpp
// Author: Oz Elentok
// Description: Color prompt for zsh

#include <string>
#include <iostream>
#include <sstream>
#include <cstdlib>
#include <unistd.h>
#include <algorithm>

using std::string;
using std::stringstream;

static const string orgSeperator("/");
static const string seperator("⮀");
static const string thinSep(" ⮁ ");
static const string homeStart(" ~");
static const string promptStart("\n $ ");
static const string colorTemplateBG("%{[48;5;m%}");
static const string colorTemplateFG("%{[38;5;m%}");
static const string resetColors("%{[0m%}");
static const char * const homeEnvironment = "HOME";
static const size_t colorInsertionIndex = 9;
static const size_t averagePromptSize = 150;

namespace colors {
	static const string pathFG("255");
	static const string pathBG("25");
	static const string promptBG("22");
}

string startColorFG(const string & fgColor) {
	string fgText(colorTemplateFG);
	fgText.insert(colorInsertionIndex,fgColor);
	return fgText;
}

string startColorBG(const string & bgColor) {
	string bgText(colorTemplateBG);
	bgText.insert(colorInsertionIndex, bgColor);
	return bgText;
}

void replaceSeperators(string & cwd) {
	size_t index = 0;
	bool is_root = false;
	is_root = (orgSeperator.length() == cwd.length());
	while (true) {
		 index = cwd.find(orgSeperator, index);
		 if (index == std::string::npos) {
			 break;
		 }
		 cwd.replace(index, orgSeperator.length(), thinSep);
		 index += thinSep.length();
	}
	if (!is_root) {
		cwd.append(" ");
	}
}

void replaceHomePath(string & cwd) {
	char * homeCString = getenv(homeEnvironment);
	string home;
	size_t index = 0;
	if (homeCString == NULL) {
		return;
	}
	home = homeCString;
	index = cwd.find(home, index);
	if (index == 0) {
		cwd.replace(index, home.length(), homeStart);
	}
}

void addCurrentWorkingDirectory(string & shellPrompt) {
	char * cwdCString = getcwd(NULL, 0);
	string cwd;
	if (cwdCString == NULL) {
		return;
	}
	cwd = cwdCString;
	replaceHomePath(cwd);
	replaceSeperators(cwd);
	shellPrompt += startColorFG(colors::pathFG);
	shellPrompt += startColorBG(colors::pathBG);
	shellPrompt += cwd;
	shellPrompt += resetColors;
	shellPrompt += startColorFG(colors::pathBG);
	shellPrompt += seperator;
	shellPrompt += resetColors;
	free(cwdCString);
}

void addPrompt(string & shellPrompt) {
	shellPrompt += startColorBG(colors::promptBG);
	shellPrompt += promptStart;
	shellPrompt += resetColors;
	shellPrompt += startColorFG(colors::promptBG);
	shellPrompt += seperator;
	shellPrompt += resetColors;
}

int main()
{
	string shellPrompt;
	shellPrompt.reserve(averagePromptSize);
	addCurrentWorkingDirectory(shellPrompt);
	addPrompt(shellPrompt);
	std::cout << shellPrompt;
	return 0;
}
