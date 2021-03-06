Red/System [
	Title:	"INPUT win32 API imported functions and structures definitions"
	Author: "Nenad Rakocevic, Xie Qingtian"
	File: 	%win32.reds
	Tabs: 	4
	Rights: "Copyright (C) 2014-2015 Nenad Rakocevic. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
	Notes: {
		Freely inspired by linenoise fork from msteveb:
		https://github.com/msteveb/linenoise/blob/master/linenoise.c
	}
]

#define VK_BACK 				 	08h
#define VK_TAB 					 	09h
#define VK_CLEAR 				 	0Ch
#define VK_RETURN 				 	0Dh
#define VK_SHIFT 				 	10h
#define VK_CONTROL 				 	11h
#define VK_PRIOR 				 	21h
#define VK_NEXT 				 	22h
#define VK_END 					 	23h
#define VK_HOME 				 	24h
#define VK_LEFT 				 	25h
#define VK_UP 					 	26h
#define VK_RIGHT 				 	27h
#define VK_DOWN 				 	28h
#define VK_SELECT 				 	29h
#define VK_INSERT 				 	2Dh
#define VK_DELETE 				 	2Eh
#define KEY_EVENT 				 	01h
#define MOUSE_EVENT 			 	02h
#define WINDOW_BUFFER_SIZE_EVENT 	04h
#define MENU_EVENT 				 	08h
#define FOCUS_EVENT 			 	10h
#define ENHANCED_KEY 			 	0100h
#define FOREGROUND_BLUE 		 	01h
#define FOREGROUND_GREEN 		 	02h
#define FOREGROUND_RED 			 	04h
#define ENABLE_PROCESSED_INPUT		01h
#define ENABLE_LINE_INPUT 			02h
#define ENABLE_ECHO_INPUT 			04h
#define ENABLE_QUICK_EDIT_MODE		40h

mouse-event!: alias struct! [
	Position  [integer!]			;-- high 16-bit: Y	low 16-bit: X
	BtnState  [integer!]
	KeyState  [integer!]
	Flags	  [integer!]
]

key-event!: alias struct! [		   ;typedef struct _KEY_EVENT_RECORD {
	KeyDown   			[integer!] ;  WINBOOL bKeyDown;  	offset: 0
	RepeatCnt-KeyCode	[integer!] ;  WORD wRepeatCount;            4
	ScanCode-Char		[integer!] ;  WORD wVirtualKeyCode;    		6
	KeyState  			[integer!] ;  WORD wVirtualScanCode;  		8
]                          		   ;  union {
                                   ;    WCHAR UnicodeChar;
                                   ;    CHAR AsciiChar;
                                   ;  } uChar;						10
                                   ;  DWORD dwControlKeyState;		12
                                   ;} KEY_EVENT_RECORD,*PKEY_EVENT_RECORD;
input-record!: alias struct! [
	EventType [integer!]
	Event	  [integer!]
	pad2	  [integer!]
	pad3	  [integer!]
	pad4	  [integer!]
]

screenbuf-info!: alias struct! [	;-- size? screenbuf-info! = 22
	Size	  [integer!]        	;typedef struct _CONSOLE_SCREEN_BUFFER_INFO {
	Position  [integer!]        	;  COORD dwSize;		offset: 0
	pad1	  [integer!]        	;  COORD dwCursorPosition;		4
	pad2	  [integer!]        	;  WORD wAttributes;			8
	pad3	  [integer!]        	;  SMALL_RECT srWindow;			10
	pad4 	  [byte!]           	;  COORD dwMaximumWindowSize;	18
	pad5 	  [byte!]           	;} CONSOLE_SCREEN_BUFFER_INFO,*PCONSOLE_SCREEN_BUFFER_INFO;
]									;-- sizeof(CONSOLE_SCREEN_BUFFER_INFO) = 22

#import [
	"kernel32.dll" stdcall [
		ReadConsoleInput: "ReadConsoleInputW" [
			handle			[integer!]
			arrayOfRecs		[integer!]
			length			[integer!]
			numberOfRecs	[int-ptr!]
			return:			[integer!]
		]
		SetConsoleMode: "SetConsoleMode" [
			handle			[integer!]
			mode			[integer!]
			return:			[integer!]
		]
		GetConsoleMode:	"GetConsoleMode" [
			handle			[integer!]
			mode			[int-ptr!]
			return:			[integer!]
		]
		WriteConsole: 	 "WriteConsoleW" [
			consoleOutput	[integer!]
			buffer			[byte-ptr!]
			charsToWrite	[integer!]
			numberOfChars	[int-ptr!]
			_reserved		[int-ptr!]
			return:			[integer!]
		]
		FillConsoleOutputAttribute: "FillConsoleOutputAttribute" [
			handle			[integer!]
			attributs		[integer!]
			length			[integer!]
			coord			[integer!]
			numberOfAttrs	[int-ptr!]
		]
		FillConsoleOutputCharacter: "FillConsoleOutputCharacterW" [
			handle			[integer!]
			attributs		[integer!]
			length			[integer!]
			coord			[integer!]
			numberOfChars	[int-ptr!]
		]
		SetConsoleCursorPosition: "SetConsoleCursorPosition" [
			handle 			[integer!]
			coord 			[integer!]
		]
		GetConsoleScreenBufferInfo: "GetConsoleScreenBufferInfo" [
			handle 			[integer!]
			info 			[integer!]
			return: 		[integer!]
		]
	]
]

input-rec: declare input-record!
base-y:	 	 0
saved-con:	 0

#define FIRST_WORD(int) (int and FFFFh)
#define SECOND_WORD(int) (int >>> 16)

fd-read: func [
	return: 	[integer!]
	/local
		key 	[key-event!]
		n	 	[integer!]
		keycode [integer!]
][
	n: 0
	while [true] [
		if zero? ReadConsoleInput stdin as-integer input-rec 1 :n [return -1]
		key: as key-event! (as-integer input-rec) + (size? integer!)

		if all [
			input-rec/EventType and FFFFh = KEY_EVENT
			key/KeyDown <> 0
		][
			keycode: SECOND_WORD(key/RepeatCnt-KeyCode)  ;-- 1st RepeatCnt 2 KeyCode
			case [
				key/KeyState and ENHANCED_KEY > 0 [
					switch keycode [
						VK_LEFT		[return KEY_LEFT]
						VK_RIGHT	[return KEY_RIGHT]
						VK_UP		[return KEY_UP]
						VK_DOWN		[return KEY_DOWN]
						VK_INSERT	[return KEY_INSERT]
						VK_DELETE	[return KEY_DELETE]
						VK_HOME		[return KEY_HOME]
						VK_END		[return KEY_END]
						VK_PRIOR	[return KEY_PAGE_UP]
						VK_NEXT		[return KEY_PAGE_DOWN]
						VK_RETURN	[return KEY_ENTER]
						default		[return KEY_NONE]
					]
				]
				keycode = VK_CONTROL []
				true [return SECOND_WORD(key/ScanCode-Char)] ;-- return Char
			]
		]
	]
	-1
]

get-window-size: func [
	return: 	[integer!]
	/local
		info 	[screenbuf-info!]
		x-y 	[integer!]
][
	info: declare screenbuf-info!
	if zero? GetConsoleScreenBufferInfo stdout as-integer info [return -1]
	x-y: info/Size
	columns: FIRST_WORD(x-y)
	rows: SECOND_WORD(x-y)
	if columns <= 0 [columns: 80 return -1]
	x-y: info/Position
	base-y: SECOND_WORD(x-y)
	0
]

emit-red-char: func [cp [integer!] /local b][
	b: as byte-ptr! :cp
	pbuffer/1: b/1
	pbuffer/2: b/2
	pbuffer: pbuffer + 2
]

reset-cursor-pos: does [
	SetConsoleCursorPosition stdout base-y << 16
]

erase-to-bottom: func [
	/local
		n	 [integer!]
		info [screenbuf-info!]
		x-y  [integer!]
][
	n: 0
	info: declare screenbuf-info!
	GetConsoleScreenBufferInfo stdout as-integer info
	x-y: info/Position
	FillConsoleOutputCharacter							;-- clear screen
		stdout
		20h												;-- #" " = 20h
		rows - SECOND_WORD(x-y) * columns				;-- (rows - y) * columns
		x-y
		:n
]

set-cursor-pos: func [
	line	[red-string!]
	offset	[integer!]
	size	[integer!]
	/local
		x	[integer!]
		y	[integer!]
][
	y: offset / columns
	x: offset // columns
	if all [
		widechar? line
		columns - x = 1
	][
		y: y + 1
		x: 0
	]
	SetConsoleCursorPosition stdout base-y + y << 16 or x
]

output-to-screen: func [/local n][
	n: 0
	WriteConsole stdout buffer (as-integer pbuffer - buffer) / 2 :n null
]

init: func [
	line 		[red-string!]
	hist-blk	[red-block!]
	/local
		mode	[integer!]
][
	copy-cell as red-value! line as red-value! input-line
	copy-cell as red-value! hist-blk as red-value! history

	GetConsoleMode stdin :saved-con
	mode: saved-con and (not ENABLE_PROCESSED_INPUT)	;-- turn off PROCESSED_INPUT, so we can handle control-c
	mode: mode or ENABLE_QUICK_EDIT_MODE				;-- use the mouse to select and edit text
	SetConsoleMode stdin mode
	buffer: allocate buf-size
]

restore: does [SetConsoleMode stdin saved-con free buffer]
