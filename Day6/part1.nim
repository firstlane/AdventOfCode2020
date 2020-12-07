import tables

var groupAnswers: seq[CountTable[char]]

let file = open("input.txt", FileMode.fmRead)
var line: string
var answer: CountTable[char]
while file.readLine(line):
    if line == "":
        groupAnswers.add(answer)
        answer.clear()
        continue

    for c in line:
        answer.inc(c)
close(file)
groupAnswers.add(answer)

var count = 0
for group in groupAnswers:
    count += len(group)

echo count