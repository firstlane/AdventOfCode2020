import re
import intsets
import sequtils
import strutils
import tables

var numbers: seq[int]

let file = open("input.txt", FileMode.fmRead)
var line: string
while file.readLine(line):
    numbers.add(parseInt(line))
close(file)

#[
Find the first number in the list which
is not the sum of two of the previous 25
numbers in the list.
Note: the two summed numbers must not be equal.
]#

# Preamble length is 25. Must include a number
# after the preamble.
var preambleLength = 25
if len(numbers) < preambleLength + 1:
    echo "Not enough numbers to form a preamble"
    quit(1)

var result = -1
var resultIndex = -1

for i in countup(preambleLength, len(numbers) - 1, 1):
    var num = numbers[i]
    var preamble1 = numbers[(i - preambleLength)..(i - 1)].toIntSet()
    var preamble2 = numbers[(i - preambleLength)..(i - 1)].toIntSet()

    var sumFound = false
    for j in preamble1:
        for k in preamble2:
            if j + k == num:
                sumFound = true

    if not sumFound:
        result = num
        resultIndex = i
        break

if resultIndex != -1:
    for i in countup(0, len(numbers) - 1, 1):
        for j in countup(i + 1, len(numbers) - i - 2, 1):
            var sum = numbers[i..j].foldl(a + b)
            if sum > result:
                break
            elif sum == result:
                var min = numbers[i..j].min()
                var max = numbers[i..j].max()
                echo "Encryption weakness: ", min, ", ", max
                echo "Sum: ", min + max
                quit(0)

    echo "Failed to find an encryption weakness"
    quit(1)
else:
    echo "Failed to find an invalid number"
    quit(1)
