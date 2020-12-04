var numCols: int
var rows: seq[string]

let file = open("input.txt", FileMode.fmRead)
var line: string
while file.readLine(line):
    numCols += 1
    add(rows, line)
close(file)

const run = 3
let rowLength = len(rows[0])
var currIndex = 0
var numTreeHits = 0

for row in rows:
    # Calculate out for extended row
    var index = currIndex mod rowLength
    if row[index] == '#':
        numTreeHits += 1

    currIndex += run

echo numTreeHits