//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/ /*Command*/	 	                            /*Update Interval*/	/*Update Signal*/
    //{" 🐧 ", "~/.config/suckless/dwmblocks/scripts/kernel",	 360,		          2},
	{" 💻 ", "~/.config/suckless/dwmblocks/scripts/memory",	     3, 	              1},

	{"  ", "~/.config/suckless/dwmblocks/scripts/upt",		     60,		          2},

	//{" 📦 ", "~/.config/suckless/dwmblocks/scripts/pacupdate",  360,		          9},

	//{" 🔊 ", "~/.config/suckless/dwmblocks/scripts/volume",      1,		              1},

    {"   ", "~/.config/suckless/dwmblocks/scripts/battery",     1,                       1},

	{"  ", "~/.config/suckless/dwmblocks/scripts/clock",	     60,	              0},

};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = '|';
