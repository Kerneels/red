Red [
	Title:   "Red series test script"
	Author:  "Nenad Rakocevic & Peter W A Wood"
	File: 	 %series-test.red
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2015 Nenad Rakocevic & Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/red/red/blob/origin/BSD-3-License.txt"
]

#include  %../../../quick-test/quick-test.red

~~~start-file~~~ "series"

===start-group=== "first, second, third, fourth, fifth"

	--test-- "series-fstff-1"
	  sf1-ser:  [1 2 3 4 5]
	--assert 1 = first sf1-ser
	--assert 2 = second sf1-ser
	--assert 3 = third sf1-ser
	--assert 4 = fourth sf1-ser
	--assert 5 = fifth sf1-ser
	--assert 5 = last sf1-ser

	--test-- "series-fstff-2"
	  sf2-ser:  [1 2 3 4 5]
	--assert 2 = first next sf2-ser
	
	--test-- "series-fstff-3"
	  sf3-ser:  "12345"
	--assert 49 = first sf3-ser
	--assert 53 = last sf3-ser
	
	--test-- "series-fstff-4"
	  sf4-ser:  [1 2 3 4 5]
	--assert none = fifth next sf4-ser
	
	--test-- "series-fstff-5"
	  sf5-ser:  "12345"
	--assert 53 = fifth sf5-ser
	
	--test-- "series-fstff-6"
	;;  stf6-ser: #{000102}
	;;--assert 0 = first stf6-ser
	
	--test-- "series-fstff-7"
	--assert 'a = first [a b c d]
	
	--test-- "series-fstff-8"
	--assert 'a = first first first first first first first first first [[[[[[[[[a]]]]]]]]]
	
	--test-- "series-fstff-9"
	--assert #"^(00)" = first "^(00)"
	
	--test-- "series-fstff-10"
	--assert #"^(00)" = first "^(00)a" 
	  
	--test-- "series-fstff-11"
	--assert #"^(00)" = second "a^(00)"
	
	--test-- "series-fstff-12"
	--assert #"^(00)" = second "a^(00)b"

	--test-- "series-fstff-13"
	sf6-ser: make hash! [a b]
	--assert 'a = first sf6-ser
	--assert 'b = last sf6-ser

	--test-- "series-fstff-14"
	sf7-ser: make hash! [1 2 3]
	--assert 2 = first next sf7-ser
	--assert none = fifth next sf7-ser
	
===end-group===

===start-group=== "next"
  --test-- "series-next-1"
  --assert 2 = first next [1 2 3 4 5]
  --test-- "series-next-2"
  --assert 3 = first next next [1 2 3 4 5]
  --test-- "series-next-3"
  --assert 4 = first next next next [1 2 3 4 5]
  --test-- "series-next-4"
  --assert 5 = first next next next next [1 2 3 4 5]
  --test-- "series-next-5"
  --assert none = first next next next next next [1 2 3 4 5]
  --test-- "series-next-6"
  --assert 50 = first next "12345"
  --test-- "series-next-7"
  --assert 51 = first next next "12345"
  --test-- "series-next-8"
  --assert 52 = first next next next "12345"
  --test-- "series-next-9"
  --assert 53 = first next next next next "12345"
  --test-- "series-next-10"
  --assert none = first next next next next next "12345"
  --test-- "series-next-11"
  --assert #"^(00)" = first next "a^(00)"
  --test-- "series-next-12"
  --assert #"^(00)" = first next "a^(00)b" 
===end-group===

===start-group=== "back"
  --test-- "series-back-1"
  --assert 1 = first back next [1 2 3 4 5]
  --test-- "series-back-2"
  --assert 1 = first back back next next [1 2 3 4 5]
  --test-- "series-back-3"
  --assert 1 = first back back back next next next [1 2 3 4 5]
  --test-- "series-back-4"
  --assert 1 = first back back back back next next next next [1 2 3 4 5]
  --test-- "series-back-5"
  --assert 1 = first back back back back back next next next next next [1 2 3 4 5]
  --test-- "series-back-6"
  --assert 49 = first back next "12345"
  --test-- "series-back-7"
  --assert 50 = first back next next "12345"
  --test-- "series-back-8"
  --assert 51 = first back next next next "12345"
  --test-- "series-back-9"
  --assert 52 = first back next next next next "12345"
  --test-- "series-back-10"
  --assert 53 = first back next next next next next "12345"
  --test-- "series-back-11"
  --assert 49 = first back "12345"
  --test-- "series-back-12"
  --assert 1 = first back next make hash! [1 2 3 4 5]
===end-group===

===start-group=== "tail"
  --test-- "series-tail-1"
  --assert 5 = first back tail [1 2 3 4 5]
  --test-- "seried-tail-2" 
  --assert none = pick tail [1 2 3 4 5] 1
  --test-- "series-tail-3"
  hs-ser-1: make hash! [1 2 3 4 5]
  --assert 5 = first back tail hs-ser-1
  --test-- "seried-tail-4"
  hs-ser-2: make hash! [1 2 3 4 5]
  --assert none = pick tail hs-ser-2 1
===end-group===

===start-group=== "pick"

  --test-- "series-pick-1"
  --assert none = pick "" 1
  
  --test-- "series-pick-2"
  --assert none = pick "" 0
  
  --test-- "series-pick-3"
  --assert none = pick "" 2
  
  --test-- "series-pick-4"
  --assert 49 = pick "12345" 1
  
  --test-- "series-pick-5"
  --assert 53 = pick "12345" 5
  
  --test-- "series-pick-6"
  --assert 1 = pick [1 2 3 4 5] 1
  
  --test-- "series-pick-7"
  --assert 2 = pick [1 2 3 4 5] 2
  
  --test-- "series-pick-8"
  --assert 4 = pick [1 2 3 4 5] 4
  
  --test-- "series-pick-9"
  --assert 5 = pick [1 2 3 4 5] 5
  
  --test-- "series-pick-10"
  --assert 2 = pick next next next [1 2 3 4 5] -2
  
  --test-- "series-pick-11"
  --assert 3 = pick next next next [1 2 3 4 5] -1
  
  --test-- "series-pick-12"
  --assert none = pick next next next [1 2 3 4 5] 0
  
  --test-- "series-pick-13"
  --assert none = pick "12345" -1
  
  --test-- "series-pick-14"
    sp14-i: 1
  --assert 1 = pick [1 2 3 4 5] sp14-i
  
  --test-- "series-pick-15"
    sp15-i: 4
  --assert 4 = pick [1 2 3 4 5] sp15-i
  
  --test-- "series-pick-16"
    sp16-i: -2
  --assert 2 = pick next next next [1 2 3 4 5] sp16-i
  
  --test-- "series-pick-17"
    sp17-i: 0
  --assert none = pick next next next [1 2 3 4 5] sp17-i
  
  --test-- "series-pick-18"
    sp18-i: -1
  --assert none = pick "12345" sp18-i
  
  --test-- "series-pick-19"
  --assert 5 = pick make hash! [1 2 3 4 5] 5
  
  --test-- "series-pick-20"
  --assert 2 = pick next next next make hash! [1 2 3 4 5] -2
===end-group===

===start-group=== "select"
	--test-- "series-select-1"
		--assert 2 = select [1 2 3 4 5] 1
	--test-- "series-select-2"
		--assert 5 = select [1 2 3 4 5] 4
	--test-- "series-select-3"
		--assert none = select [1 2 3 4 5] 0
	--test-- "series-select-4"
		--assert none = select [1 2 3 4 5] 5
  
	--test-- "series-select-5"
		a: [2 3 5 test #"A" a/b 5 "tesT"]
		--assert #"A" = select a 'test
		
	--test-- "series-select-6"
		list: [a 1 b 2 c 3]
		--assert 2 = list/b
		
	--test-- "series-select-6"
		--assert 'test = select/skip a 5 2

	--test-- "series-select-7"
		s: "Hello, Red World!"
		--assert #"e" = select s #"r"

	--test-- "series-select-8"
		--assert #"l" = select/last s #"r"

	--test-- "series-select-9"
		--assert #"d" = select/skip s "e" 2

	--test-- "series-select-10"
		--assert none? select s #"!"

	--test-- "series-select-11"
		--assert 5 = select make hash! [1 2 3 4 5] 4

	--test-- "series-select-12"
		hs-sel-1: make hash! [2 3 5 test #"A" a/b 5 "tesT"]
		--assert #"A" = select hs-sel-1 'test
		
	--test-- "series-select-13"
		list: make hash! [a 1 b 2 c 3]
		--assert 2 = list/b

	--test-- "series-select-14"
		--assert 'test = select/skip hs-sel-1 5 2

	--test-- "series-select-15"
		hs-select-1: make hash! [aBc 1 abc 2 ABc 3]
		--assert 1 = select hs-select-1 'abc
		--assert 2 = select/case hs-select-1 'abc
===end-group===

===start-group=== "append"
  --test-- "series-append-1"
  --assert 6 = last append [1 2 3 4 5] 6
  --test-- "series-append-2"
  --assert 6 = last append [1 2 3 4] [5 6]
  --assert 4 = fourth append [1 2 3 4] [5 6]
  --assert 5 = fifth append [1 2 3 4] [5 6]
  --test-- "series-append-3"
  --assert 55 = last append "12345" "67"
  --test-- "series-append-4"
  --assert 233 = last append "abcde" "é" ;; utf-8 C3 A9
  --test-- "series-append-5"
  --assert 49 = last append "abcdeé" "1" ;; utf-8 C3 A9
  --test-- "series-append-6"
  --assert 10000 = last append "abcde" "✐"
  --test-- "series-append-7"
  --assert 48 = last append "abcde^(2710)" "0"
  --test-- "series-append-8"
  --assert 10000 = last append "abcdeé" "^(2710)"
  --test-- "series-append-9"
  --assert 233 = last append "abcde^(2710)" "é"
  --test-- "series-append-10"
  --assert 65536 = last append "abcde" "^(010000)"   
  --test-- "series-append-11"
  --assert 48 = last append "abcde^(010000)" "0"
  --test-- "series-append-12"
  --assert 65536 = last append "abcde^(2710)é" "^(010000)" 
  
  --test-- "series-append-13"
	blk: make block! 1
	append blk 'x/y
	append/only blk  'r/s
	--assert "[x y r/s]" = mold blk

  --test-- "series-append-14"
	blk: [1 2]
	append/dup/part blk [4 5 6] 3 2
	--assert "[1 2 4 5 4 5 4 5]" = mold blk
	
  --test-- "series-append-15"
	blk: [1 2]
	append/dup/part blk [4 5 6] 2 3
	--assert "[1 2 4 5 6 4 5 6]" = mold blk	

  --test-- "series-append-16"
	str: "12"
	append/dup/part str "456" 3 2 
	--assert str = "12454545"

  --test-- "series-append-17"
	str: "12"
	append/part/dup str "456" 3 2 
	--assert str = "12456456"

  --test-- "series-append-18"
  hs-append-1: make hash! [a 1 b 2]
  --assert 6 = last append hs-append-1 [c 6]
  --assert 6 = select hs-append-1 'c
===end-group===

===start-group=== "series-equal"

  --test-- "series-equal-1"
  --assert [] = []
  
  --test-- "series-equal-2"
    se2-b: []
  --assert [] = se2-b
  
  --test-- "series-equal-3"
    se3-b: []
  --assert se3-b = []
  
  --test-- "series-equal-4"
    se4-b: [1]
  --assert se4-b = [1]
  
  --test-- "series-equal-5"
    se5-b: ["abcde"]
  --assert se5-b = ["abcde"]
  
===end-group===

===start-group=== "series-find"

  --test-- "series-find-1"
  --assert 3 = first find [1 2 3 4 5] 3 
  
  --test-- "series-find-2"
  --assert 'a = first find [a b c d e] 'a
  
  --test-- "series-find-3"
  --assert 'e = first find [a b c d e] 'e
  
  --test-- "series-find-4"
  --assert none = find [] 'a
  
  --test-- "series-find-5"
  --assert none = find [1 2 3 4] 'a
  
  --test-- "series-find-6"
  --assert none = find next [a b c d e] 'a
  
  --test-- "series-find-7"
  --assert 51 = first find "12345" "3"
  
  --test-- "series-find-8"
  --assert 51 = first find "12345" "^(33)"
  
  --test-- "series-find-9"
  --assert 51 = first find "12345" first "^(33)"
  
  --test-- "series-find-10"
  --assert 51 = first find "12345" #"3"
  
  --test-- "series-find-11"
  --assert 51 = first find "12345" #"^(33)"
  
  --test-- "series-find-12"
  --assert #"3" = first find "12345" #"3"
  
  --test-- "series-find-13"
  --assert #"a" = first find "abcdefghijklmno" #"a"
  
  --test-- "series-find-14"
  --assert "ghijklmno" = find "abcdefghijklmno" "ghij"
  
  --test-- "series-find-15"
  --assert #"o" = first find "abcdefghijklmno" #"o"
  
  --test-- "series-find-16"
  --assert "o" = find "abcdefghijklmno" #"o"
  
  --test-- "series-find-17"
  --assert #"o" = first find "abcdefghijklmno" "o"
  
  --test-- "series-find-18"
  --assert "o" = find "abcdefghijklmno" "o"
  
  --test-- "series-find-19"
  --assert none = find "" #"a"
  
  --test-- "series-find-20"
  --assert none = find "" #"^(00)"
  
  --test-- "series-find-21"
  --assert none = find "" ""
  
  --test-- "series-find-22"
  --assert "^(00)" = find "^(00)" "^(00)"
  
  --test-- "series-find-23"
  --assert "a^(00)" = find "a^(00)" "a^(00)"
  
  --test-- "series-find-24"
  --assert "^(00)a" = find "^(00)a" "^(00)a"
  
  --test-- "series-find-25"
  --assert "^(00)" = find "^(00)" #"^(00)"
  
  --test-- "series-find-26"
  --assert #"^(00)" = first find "^(00)" #"^(00)"
  
  --test-- "series-find-27"
  --assert #"é" = first find "abcdeé" #"é" 
  
  --test-- "series-find-28"
  --assert "é" = find "abcdeé" "é" 
  
  --test-- "series-find-29"
  --assert "é" = find append "abcde" "é" "é" 
  
  --test-- "series-find-30"
  --assert 10000 = first find "abcde✐" "✐"
  
  --test-- "series-find-30a"
  --assert 10000 = first find "abcde✐" #"✐"
  
  --test-- "series-find-31"
  --assert none = find "012345" 48
  
  --test-- "series-find-32"
  --assert "^(010000)" = find "abcde^(2710)é^(010000)" "^(010000)" 
  
  --test-- "series-find-33"
  --assert "^(010000)cde^(2710)é" = find "ab^(010000)cde^(2710)é" #"^(010000)"
  
  --test-- "series-find-34"
  --assert "^(010000)cde^(2710)é" = find "ab^(010000)cde^(2710)é" "^(010000)"

	--test-- "series-find-35"  
		a: [2 3 5 test #"A" a/b 5 "tesT"]
		append a datatype!
		--assert 3 = index? find a 5
	
	--test-- "series-find-36"
		--assert 8 = index? find a "test"

	--test-- "series-find-37"
		--assert none? find a 99

	--test-- "series-find-38"
		--assert none? find/skip a 'test 2
		
	--test-- "series-find-39"
		--assert 4 = index? find/skip a 'test 3

	--test-- "series-find-40"
		--assert 7 = index? find/last a 5
		
	--test-- "series-find-41"
		--assert 2 = index? find/reverse skip a 4 3

	--test-- "series-find-42"
		--assert 8 = index? find skip a 3 "test"
		
	--test-- "series-find-43"
		--assert none? find/last/part a 3 1

	--test-- "series-find-44"
		--assert 2 = index? find/last/part a 3 2

	--test-- "series-find-45"
		--assert none? find/part a 'test 3

	--test-- "series-find-46"
		--assert 4 = index? find/part a 'test 4

	--test-- "series-find-47"
		--assert 2 = index? find a [3 5]
		
	--test-- "series-find-48"
		--assert 3 = index? find a [5 'test]
	
	--test-- "series-find-49"
		--assert none? find a 'a/b
	
	--test-- "series-find-50"
		--assert 6 = index? find/only a 'a/b

	--test-- "series-find-51"
		--assert 2 = index? find/match a 2

	--test-- "series-find-52"
		--assert none? find/match a 3

	--test-- "series-find-53"
		--assert 4 = index? find/match a [2 3 5]

	--test-- "series-find-54"
		--assert none? find/match next a [2 3 5]
		
	--test-- "series-find-55"
		--assert 4 = index? find/tail a 5

	--test-- "series-find-56"
		--assert 3 = index? find 'a/b/3/d 3
		
	--test-- "series-find-57"
		--assert 2 = index? find 'a/b/3/d 'b
		
	--test-- "series-find-58"
		s: "Hello, Red World!"
		--assert 6 = index? find s ","

	--test-- "series-find-59"
		--assert 8 = index? find s "Red"

	--test-- "series-find-60"
		--assert 8 = index? find s "red"

	--test-- "series-find-61"
		--assert 6 = index? find s #","

	--test-- "series-find-62"
		--assert 1 = index? find "^(00)" "^(00)"

	--test-- "series-find-63"
		--assert 5 = index? find/skip s #"o" 2
		
	--test-- "series-find-64"
		--assert 13 = index? find/skip s #"o" 3

	--test-- "series-find-65"
		--assert 15 = index? find/last s #"l"

	--test-- "series-find-66"
		--assert 13 = index? find/last s "o"

	--test-- "series-find-67"
		--assert none? find/part s #"o" 4

	--test-- "series-find-68"
		--assert 5 = index? find/part s #"o" 5

	--test-- "series-find-69"
		--assert 2 = index? find/match s #"h"

	--test-- "series-find-70"
		--assert 5 = index? find/match s "hell"

	--test-- "series-find-71"
		--assert 5 = index? find/match s "Hell"

	--test-- "series-find-72"
		--assert none? find/match/case s "hell"

	--test-- "series-find-73"
		--assert 5 = index? find/match/case s "Hell"

	--test-- "series-find-74"
		--assert none? find/match next s "hell"

	--test-- "series-find-75"
		--assert 8 = index? find/case s "Red"

	--test-- "series-find-76"  
		hs-fd-1: make hash! [2 3 5 test #"A" a/b 5 "tesT"]
		append hs-fd-1 datatype!
		--assert 3 = index? find hs-fd-1 5
	
	--test-- "series-find-77"
		--assert 8 = index? find hs-fd-1 "test"

	--test-- "series-find-78"
		--assert none? find hs-fd-1 99

	--test-- "series-find-79"
		--assert none? find/skip hs-fd-1 'test 2
		
	--test-- "series-find-80"
		--assert 4 = index? find/skip hs-fd-1 'test 3

	--test-- "series-find-81"
		--assert 7 = index? find/last hs-fd-1 5
		
	--test-- "series-find-82"
		--assert 2 = index? find/reverse skip hs-fd-1 4 3

	--test-- "series-find-83"
		--assert 8 = index? find skip hs-fd-1 3 "test"
		
	--test-- "series-find-84"
		--assert none? find/last/part hs-fd-1 3 1

	--test-- "series-find-85"
		--assert 2 = index? find/last/part hs-fd-1 3 2

	--test-- "series-find-86"
		--assert none? find/part hs-fd-1 'test 3

	--test-- "series-find-87"
		--assert 4 = index? find/part hs-fd-1 'test 4

	--test-- "series-find-88"
		--assert 2 = index? find hs-fd-1 [3 5]
		
	--test-- "series-find-89"
		--assert 3 = index? find hs-fd-1 [5 'test]
	
	--test-- "series-find-90"
		--assert none? find hs-fd-1 'a/b
	
	--test-- "series-find-91"
		--assert 6 = index? find/only hs-fd-1 'a/b

	--test-- "series-find-92"
		--assert 2 = index? find/match hs-fd-1 2

	--test-- "series-find-93"
		--assert none? find/match hs-fd-1 3

	--test-- "series-find-94"
		--assert 4 = index? find/match hs-fd-1 [2 3 5]

	--test-- "series-find-95"
		--assert none? find/match next hs-fd-1 [2 3 5]
		
	--test-- "series-find-96"
		--assert 4 = index? find/tail hs-fd-1 5

===end-group===

===start-group=== "remove"

	--test-- "remove-blk-1"
		a: [1 2 3]
		--assert [2 3] = remove a
		--assert [2 3] = a

	--test-- "remove-blk-2"
		a: [1 2 3]
		--assert [3] = remove next a
		--assert [1 3] = a

	--test-- "remove-blk-3"
		--assert tail? head remove []

	--test-- "remove-blk-4"
		a: [1 2 3]
		--assert [3] = remove/part a 2
		--assert [3] = a

	--test-- "remove-blk-5"
		a: [1 2 3]
		--assert [1 2 3] = remove/part a a

	--test-- "remove-blk-6"
		a: [1 2 3]
		--assert [2 3] = remove/part a next a
		--assert [2 3] = a
	
	--test-- "remove-blk-7"
		a: [1 2 3]
		--assert [1 2 3] =  remove/part a 0

	--test-- "remove-hash-1"
		hs-remove-1: make hash! [a 2 3]
		--assert (make hash! [2 3]) = remove hs-remove-1
		--assert none? hs-remove-1/a

	--test-- "remove-hash-2"
		hs-remove-1: make hash! [a 2 3]
		remove next hs-remove-1
		--assert 3 = hs-remove-1/a

	--test-- "remove-hash-3"
		--assert tail? head remove make hash! []

	--test-- "remove-hash-4"
		hs-remove-1: make hash! [a b c 2]
		remove/part hs-remove-1 2
		--assert 2 = hs-remove-1/c

	--test-- "remove-hash-5"
		hs-remove-1: make hash! [a b c 2]
		remove/part next hs-remove-1 2
		--assert 2 = hs-remove-1/a
		--assert none? hs-remove-1/b
		--assert none? hs-remove-1/c

	--test-- "remove-str-1"
		a: "123"
		--assert "23" = remove a
		--assert "23" = a

	--test-- "remove-str-2"
		a: "123"
		--assert "3" = remove next a
		--assert "13" = a

	--test-- "remove-str-3"
		--assert tail? head remove ""

	--test-- "remove-str-4"
		a: "123"
		--assert "3" = remove/part a 2
		--assert "3" = a

	--test-- "remove-str-5"
		a: "123"
		--assert "123" = remove/part a a

	--test-- "remove-str-6"
		a: "123"
		--assert "23"= remove/part a next a
		--assert "23" = a
	
	--test-- "remove-str-7"
		a: "123"
		--assert "123" = remove/part a 0
	
	--test-- "remove-str-8"
		a: "str123"
		--assert "" = remove back tail a
		--assert "str12" = head a

===end-group===

===start-group=== "clear"
	
	--test-- "clear-1"
		c1-b: [1 2 3 4 5]
	--assert [] = clear c1-b
	
	--test-- "clear-2"
		c2-s: "a"
	--assert "" = clear c2-s
	
	--test-- "clear-3"
		c3-s: "é"
	--assert "" = clear c2-s
	
	--test-- "clear-4"
		c4-s: "✐"
	--assert "" = clear c4-s
	
	--test-- "clear-5"
		c5-s: "^(2710)"
	--assert "" = clear c5-s
	
	--test-- "clear-6"
		c6-b: [a [b] c]
		clear second c6-b
	--assert [a [] c] = c6-b
	
	--test-- "clear-7"
		c7-b: [a b c d e f]
		c7-b: next next next c7-b
	--assert [a b c] = head clear c7-b
	
	--test-- "clear-8"
		c8-b: "123^(2710)"
		c8-b: next next next c8-b
	--assert "123" = head clear c8-b
	
	--test-- "clear-9"
		c9-b: "^(2710)123"
		c9-b:  next c9-b
		--assert "^(2710)" = head clear c9-b

	--test-- "clear-10"
		c1-h: make hash! [a 1 b 2 c 3 d 4 5]
		clear skip c1-h 4
		--assert 2 = c1-h/b
		--assert none? c1-h/c
===end-group===

===start-group=== "at"
	
	--test-- "at-1 #issue 501"
		--assert "c" = at tail "abc" -1
		--assert "" = at tail "abc" 0
	
	--test-- "at-2"
		--assert "bcde" = at "abcde" 2
		--assert "abcde" = at "abcde" 1
		--assert "abcde" = at "abcde" 0
		--assert "abcde" = at "abcde" -1
		--assert "abcde" = at "abcde" -256
		--assert "e" = at "abcde" 5
		--assert "" = at "abcde" 6
		--assert "" = at "abcde" 1028
	
	--test-- "at-3"
		--assert [b c d e] = at [a b c d e] 2
		--assert [a b c d e] = at [a b c d e] 1
		--assert [a b c d e] = at [a b c d e] 0
		--assert [a b c d e] = at [a b c d e] -1
		--assert [a b c d e] = at [a b c d e] -256
		--assert [e] = at [a b c d e] 5
		--assert [] = at [a b c d e] 6
		--assert [] = at [a b c d e] 1028

	--test-- "at-4"
		hs-at-1: make hash! [a b c d e]
		--assert (next hs-at-1) = at hs-at-1 2
		--assert hs-at-1 = at hs-at-1 1
		--assert hs-at-1 = at hs-at-1 0
		--assert hs-at-1 = at hs-at-1 -1
		--assert (make hash! [e]) = at hs-at-1 5
	
===end-group===

===start-group=== "replace"
	
	--test-- "replace-block-1-issue-#667"
		code: [print "Hello"]
		--assert 'print = first replace code "Hello" "Cheers"
		--assert "Cheers" = second code
		
===end-group===

===start-group=== "max/min"			;-- have some overlap with lesser tests

	--test-- "max1"
		--assert "abe"  = max "abc" "abe"
		--assert "abcd" = max "abc" "abcd"

	--test-- "min1"
		--assert ""		= min "" 	"abcdef"
		--assert "abc"	= min "abc" "abcd"

	--test-- "max2"					;@@ need to add tests for word!, path!
		blk1: [1 1.0 #"a" "ab" %ab/cd [] [2] (1 2)]
		blk2: [1 1.0 #"a" "ab" %ab/cd [] [2] (1 3)]
		--assert blk2 = max blk1 blk2
		blk1: next blk1
		--assert blk2 = max blk1 blk2

===end-group===

===start-group=== "reverse"

	--test-- "reverse-str-1"			;-- 4 bytes code point
		--assert "dc𠃌21ba" = reverse "ab12𠃌cd"	;--  = #"^(E818)"
                                                    	;-- 𠃌 = #"^(200CC)"
	--test-- "reverse-str-2"			;-- 2 bytes code point
		--assert "dc21ba" = reverse "ab12cd"

	--test-- "reverse-str-3"			;-- 1 bytes code point
		--assert "dc21ba" = reverse "ab12cd"

	--test-- "reverse-str-4"
		--assert "1ba2𠃌cd" = reverse/part "ab12𠃌cd" 4

	--test-- "reverse-str-5"
		s: "abcdef"
		p: next next next s
		--assert "cbadef" = reverse/part s p

	--test-- "reverse-file-1"			;-- inherit from string!
		--assert %321cba = reverse/part %abc123 6

	--test-- "reverse-blk-1"
		--assert [a b c d] = reverse [d c b a]

	--test-- "reverse-blk-2"
		--assert [c b [a] d] = reverse/part [[a] b c d] 3

	--test-- "reverse-blk-3"
		blk: [1 [2] a b c ]
		p: next next next blk
		--assert [a [2] 1 b c] = reverse/part blk p

	--test-- "reverse-path-1"			;-- inherit from block!
		p1: first [ab/cd/ef]
		p2: first [ef/cd/ab]
		--assert p2 = reverse p1

	--test-- "reverse-hash-1"
		hash: make hash! [d c b a]
		--assert (make hash! [a b c d]) = reverse hash
		--assert 'c = hash/b

	--test-- "reverse-hash-2"
		hash: make hash! [[a] b c d]
		reverse/part hash 3
		--assert [a] = hash/b

===end-group===

===start-group=== "take"

	--test-- "take-blk-1"
		a: [1 2 3]
		--assert 1 = take a
		--assert [2 3] = a

	--test-- "take-blk-2"
		a: [1 2 3]
		--assert 3 = take/last a
		--assert [1 2] = a

	--test-- "take-blk-3"
		a: [1 2 3]
		--assert 2 = take next a
		--assert [1 3] = a

	--test-- "take-blk-4"
		--assert none = take []

	--test-- "take-blk-5"
		a: [1 2 3]
		--assert [1 2] = take/part a 2
		--assert [3] = a

	--test-- "take-blk-6"
		a: [1 2 3]
		--assert 1 = take/part a next a
		--assert [2 3] = a

	--test-- "take-blk-7"
		a: [1 2 3]
		--assert [2 3] = take/part/last a next a
		--assert [1] = a

	--test-- "take-blk-8"
		a: [1 2 3]
		--assert [] = take/part a 0
		--assert [1 2 3] = a

	--test-- "take-blk-9"
		b: "abc"
		a: reduce [b 2 3]
		--assert b = c: take/deep a
		--assert b <> remove c

	--test-- "take-blk-5"
		a: [1 2 3]
		--assert [1 2 3] = take/part a 22
		--assert [] = a

	--test-- "take-str-1"
		a: "123"
		--assert #"1" = take a
		--assert "23" = a

	--test-- "take-str-2"
		a: "123"
		--assert #"3" = take/last a
		--assert "12" = a

	--test-- "take-str-3"
		a: "123"
		--assert #"2" = take next a
		--assert "13" = a

	--test-- "take-str-4"
		--assert none = take ""

	--test-- "take-str-5"
		a: "123"
		--assert "12" = take/part a 2
		--assert "3" = a

	--test-- "take-str-6"
		a: "123"
		--assert "23" = take/part/last a 2
		--assert "1" = a

	--test-- "take-str-7"
		a: "123"
		--assert "" = take/part a a
		--assert "123" = a

	--test-- "take-str-8"
		a: "123"
		--assert #"1"= take/part a next a
		--assert "23" = a

	--test-- "take-str-9"
		a: "123"
		--assert "23" = take/part/last a next a
		--assert "1"  = a

	--test-- "take-str-10"
		a: "123"
		--assert "123" = take/part a 22
		--assert "" = a

	--test-- "take-hash-1"
		h: make hash! [1 2 3]
		--assert 1 = take h
		--assert none? select h 1
		--assert 3 = select h 2

	--test-- "take-hash-2"
		h: make hash! [1 2 3]
		--assert 3 = take/last h
		--assert none? select h 2

	--test-- "take-hash-3"
		h: make hash! [1 2 3]
		--assert 2 = take next h
		--assert 3 = select h 1

===end-group===

===start-group=== "swap"

	--test-- "swap-str-1"			;-- 4 bytes code point
		a: "1234"
		b: "𠃌"						;-- 𠃌 = #"^(200CC)"
		--assert "𠃌234" = swap a b
		--assert "𠃌234" = a
		--assert "1"	 = b

	--test-- "swap-str-2"			;-- 2 bytes code point
		a: "1234"
		b: "ab"					;--  = #"^(E818)"
		--assert "234" = swap a next b
		--assert "234" = a
		--assert "a1b"	 = b

	--test-- "swap-str-3"			;-- 1 bytes code point
		--assert "a234" = swap "1234" "abc"

	--test-- "swap-str-4"
		--assert "123" = swap "123" ""

	--test-- "swap-blk-1"
		a: [1 2]
		b: [a b]
		--assert [a 2] = swap a b
		--assert [a 2] = a
		--assert [1 b] = b

	--test-- "swap-blk-2"
		a: [1 2]
		b: [a b]
		--assert [a]   = swap next a b
		--assert [1 a] = a
		--assert [2 b] = b

	--test-- "swap-blk-3"
		--assert [1 a] = swap [1 a] []

	--test-- "swap-hash-1"
		a: make hash! [1 2]
		b: make hash! [a b]
		swap a b
		--assert 2 = a/a
		--assert 'b = select b 1
===end-group===

===start-group=== "trim"

	str: " ^(A0) ^-a b  ^- c  ^(2000) "
	mstr: {   a ^-1^/    ab2^-  ^/  ac3  ^/  ^/^/}

	--test-- "trim-str-1"
		--assert "a b  ^- c" = trim copy str

	--test-- "trim-str-2"
		--assert "a ^-1^/ab2^/ac3^/" = trim copy mstr

	--test-- "trim-str-3"
		--assert "a ^-1^/    ab2^-  ^/  ac3  ^/  ^/^/" = trim/head copy mstr

	--test-- "trim-str-4"
		--assert "   a ^-1^/    ab2^-  ^/  ac3" = trim/tail copy mstr

	--test-- "trim-str-5"
		--assert "a ^-1^/    ab2^-  ^/  ac3" = trim/head/tail copy mstr

	--test-- "trim-str-6"
		--assert "a 1 ab2 ac3" = trim/lines copy mstr

	--test-- "trim-str-7"
		--assert "a1ab2ac3" = trim/all copy mstr

	--test-- "trim-str-8"
		--assert "    ^-1^/    2^-  ^/  c3  ^/  ^/^/" = trim/with copy mstr "ab"

	--test-- "trim-str-9"
		--assert "    ^-1^/    b2^-  ^/  c3  ^/  ^/^/" = trim/with copy mstr #"a"

	--test-- "trim-str-10"
		--assert "    ^-1^/    b2^-  ^/  c3  ^/  ^/^/" = trim/with copy mstr 97

	--test-- "trim-block-1"
		--assert [1 2] = trim [#[none] 1 #[none] 2 #[none]]

===end-group===

===start-group=== "sort"

	--test-- "sort-str-1"			;-- 4 bytes code point
		a: "g4C28c𠃌9A15Hf3iEG076eBIdbFaDh"
		--assert "0123456789AaBbCcdDEefFGghHIi𠃌" = sort a

	--test-- "sort-str-2"			;-- 2 bytes code point
		a: "g4C28c大9A15Hf3iEG076eBIdbFaDh"
		--assert "0123456789AaBbCcdDEefFGghHIi大" = sort a

	--test-- "sort-str-3"			;-- 1 bytes code point
		a: "g4C28c9A15Hf3iEG076eBIdbFaDh"
		--assert "0123456789AaBbCcdDEefFGghHIi" = sort a
		--assert "0123456789ABCDEFGHIabcdefghi" = sort/case a
		--assert "ihgfedcbaIHGFEDCBA9876543210" = sort/case/reverse a

	--test-- "sort-str-4"
		a: "4gh2ab1cd3ef"
		--assert "1cd2ab3ef4gh" = sort/skip a 3
		--assert "12abcd3ef4gh" = sort/part a 6
		--assert "34efgh" = sort/part skip a 6 tail a

	--test-- "sort-blk-1"
		a: [bc 799 ab2 42 bb1 321.3 "Mo" "Curly" "Larry" -24 0 321.8] 
		--assert ["Curly" "Larry" "Mo" -24 0 42 321.3 321.8 799 ab2 bb1 bc] = sort a
		--assert [bc bb1 ab2 799 321.8 321.3 42 0 -24 "Mo" "Larry" "Curly"] = sort/reverse a

	--test-- "sort-blk-2"
		a: ["Larry" 45 "Curly" 50 "Mo" 42]
		--assert ["Curly" 50 "Larry" 45 "Mo" 42] = sort/skip a 2
		--assert ["Curly" "Larry" 45 50 "Mo" 42] = sort/part a 4
		--assert ["Mo" 42 45 50] = sort/part skip a 2 tail a

	--test-- "sort-blk-3"
		a: ["Larry" 45 "Curly" 50 "Mo" 42]
		--assert ["Mo" 42 "Larry" 45 "Curly" 50] = sort/skip/compare a 2 2
		--assert ["Mo" 42 "Larry" 45 "Curly" 50] = sort/skip/compare a 2 func [a b][a > b]
		--assert ["Curly" 50 "Larry" 45 "Mo" 42] = sort/skip/compare/all a 2 func [a b][a/2 > b/2]

	--test-- "sort-blk-4"
		o1: context [a: 2 i: "a"]
		o2: context [a: 1 i: "b"]
		o3: context [a: 1 i: "c"]
		o4: context [a: 1 i: "d"]
		o5: context [a: 1 i: "e"]
		o6: context [a: 1 i: "f"]
		o7: context [a: 3 i: "g"]
		o8: context [a: 3 i: "h"]
		a: reduce [o1 o2 o3 o8 o4 o5 o6 o7]
		res: reduce [o2 o3 o4 o5 o6 o1 o8 o7]
		--assert res = sort/compare/stable a func [a b][a/a - b/a]
===end-group===

===start-group=== "path access"	

	--test-- "path-blk-1 : issue #939"
		pb1-b: [#"x" #"y"]
		--assert #"y" = pb1-b/(#"x")
		
	--test-- "path-blk-2"
		pb2-b: [#"x" #"y"]
		pb2-c: #"x"
		--assert #"y" = pb2-b/:pb2-c
		
	--test-- "path-str-1"
		pb1-s: "xy"
		--assert #"y" = pb1-s/(#"x")
		
	--test-- "path-str-2"
		ps2-s: "xy"
		ps2-c: #"x"
		--assert #"y" = ps2-s/:ps2-c
	
	--test-- "path-str-3"
		ps3-s: "xy"
		ps3-ss: "x"
		--assert #"y" = ps3-s/:ps3-ss
		
===end-group===

===start-group=== "set operations"	

	--test-- "set-op-blk"
		a: [1 3 2 4]
		b: [3 4 5 4 6]
		--assert [3 4 5 6]		= unique b
		--assert [1 3 2 4 5 6]	= union a b
		--assert [3 4]			= intersect a b
		--assert [1 2 5 6]		= difference a b
		--assert [1 2]			= exclude a b
		--assert [5 6]			= exclude b a

	--test-- "set-op-str"
		a: "CBAD"
		b: "EDCCF"
		--assert "EDCF"		= unique b
		--assert "CBADEF"	= union a b
		--assert "CD"		= intersect a b
		--assert "BAEF"		= difference a b
		--assert "BA"		= exclude a b
		--assert "EF"		= exclude b a

	--test-- "set-op-bitset"
		a: make bitset! [1 2 3 4]
		b: make bitset! [4 5 23]
		--assert b		= unique b
		--assert "make bitset! #{7C0001}" = mold union a b
		--assert "make bitset! #{080000}" = mold intersect a b
		--assert "make bitset! #{740001}" = mold difference a b
		--assert "make bitset! #{700000}" = mold exclude a b
		--assert "make bitset! #{040001}" = mold exclude b a

===end-group===

~~~end-file~~~

