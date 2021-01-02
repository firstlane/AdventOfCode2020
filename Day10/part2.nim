import algorithm
import intsets
import sequtils
import strformat
import strutils
import tables

var adapters: seq[int]

let file = open("test.txt", FileMode.fmRead)
var line: string
while file.readLine(line):
    adapters.add(parseInt(line))
close(file)

adapters.sort()
let highestRated = adapters[^1]
let builtIn = highestRated + 3

adapters.add(builtIn)

#[
An adapter can only connect to a source
1-3 jolts lower than its rating.
]#

echo adapters

#[
With the adapters sorted, we can count every 
arrangement where one number that has a difference
less than 3 from the previous adapter is removed.
Ex: Say we have 0, 1, 4, 5, 6, 9.
- 1 cannot be remove in any valid configuration 
since 4 cannot connect to 0.
- 4 cannot be removed since 5 cannot connect to 1.
- 5 can be removed since 6 can connect to 4. 
So we count the configuration 0, 1, 4, 6, 9.
- 6 cannot be removed.
- 9 cannot be removed.
So this example would have two valid configurations.
]#

#[
Find all the numbers that cannot be removed.
Then, look at the differences between each set of 
adjacent non-removable numbers. If the difference 
is >= 3, count 2^n for n = number of adapters between 
the adjacent numbers.
If the difference is > 3, uhhh...do some combinatorics
stuff.

I couldn't work out this solution in full. Things got 
hairy when you have a sequence like 
7, 10, 11, 12, 13, 15, 16, 19 
where 7, 10, 16, and 19 cannot be removed from the 
sequence. 11-15 can, but how do you count the possible 
combinations? You could just choose 13 and satisfy the 
requirements. Every other combination requires at least 
two of the numbers to be present to satisfy requirements.

Instead, I'm falling back on the solution this guy used 
(linked below).
]#

# https://dev.to/sleeplessbyte/comment/192lf

var source = 0
var combinations = 0
for adapter in adapters:
    var difference = adapter - source
    case difference
    of 1:
        combinations = combinations 
    of 2:
        discard
    of 3:
        discard
    else:
        echo fmt("Difference greater than 3: {source} -> {adapter}")
        quit(1)

    source = adapter

