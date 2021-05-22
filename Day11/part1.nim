import algorithm
import intsets
import sequtils
import strutils
import tables

var adapters: seq[int]

let file = open("input.txt", FileMode.fmRead)
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

var countTable: CountTable[int]

var source = 0
for adapter in adapters:
    var difference = adapter - source
    countTable.inc(difference)
    source = adapter

echo countTable[1], " ", countTable[3]
echo "Answer: ", countTable[1] * countTable[3]
