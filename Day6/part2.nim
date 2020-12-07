import tables

var groupSizes: seq[int]
var groupAnswers: seq[CountTable[char]]

let file = open("input.txt", FileMode.fmRead)
var line: string
var answer: CountTable[char]
var groupSize = 0
while file.readLine(line):
    if line == "":
        groupAnswers.add(answer)
        groupSizes.add(groupSize)
        answer.clear()
        groupSize = 0
        continue

    for c in line:
        answer.inc(c)
    groupSize += 1
close(file)
groupAnswers.add(answer)
groupSizes.add(groupSize)

var count = 0
for i, group in groupAnswers[0..^1]:
    for q, a in group:
        if a == groupSizes[i]:
            count += 1

echo count