import strutils

var numbers = newSeq[int]()

let file = open("input.txt", FileMode.fmRead)
var line: string
while file.readLine(line):
    numbers.add(parseInt(line))
close(file)

const sumToFind = 2020
var product: int

for i in numbers:
    for j in numbers:
        for k in numbers:
            if i + j + k == sumToFind:
                product = i * j * k

echo product