var numCols: int
var rows: seq[string]

type Slope = object
    rise, run: int

let file = open("input.txt", FileMode.fmRead)
var line: string
while file.readLine(line):
    numCols += 1
    add(rows, line)
close(file)

const slopes = @[Slope(rise: 1, run: 1), Slope(rise: 1, run: 3), Slope(rise: 1, run: 5), Slope(rise: 1, run: 7), Slope(rise: 2, run: 1)]

let rowLength = len(rows[0])
var multTreeHits = 1

for slope in slopes:
    var currIndex = 0
    var numTreeHits = 0
    for i, row in rows[0..^1]:
        if i mod slope.rise == 0:
            # Calculate out for extended row
            var index = currIndex mod rowLength
            if row[index] == '#':
                numTreeHits += 1

            currIndex += slope.run

    echo "Slope: rise = ", slope.rise, ", run = ", slope.run, ", hits = ", numTreeHits
    multTreeHits *= numTreeHits

echo multTreeHits