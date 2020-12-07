import math

var boardingPasses: seq[string]

let file = open("input.txt", FileMode.fmRead)
var line: string
while file.readLine(line):
    boardingPasses.add(line)
close(file)

var maxSeatID = 0

for pass in boardingPasses:
    var lowRow = 0
    var highRow = 127
    for c in pass[0..6]:
        case c
        of 'F':
            highRow = highRow - (int)(ceil((highRow - lowRow) / 2))
        of 'B':
            lowRow = lowRow + (int)(ceil((highRow - lowRow) / 2))
        else:
            echo "Unhandled case"
            quit()

    var lowCol = 0
    var highCol = 7
    for c in pass[7..9]:
        case c
        of 'R':
            lowCol = lowCol + (int)(ceil((highCol - lowCol) / 2))
        of 'L':
            highCol = highCol - (int)(ceil((highCol - lowCol) / 2))
        else:
            echo "Unhandled case"
            quit()

    var seatID = lowRow * 8 + lowCol
    if seatID > maxSeatID:
        maxSeatID = seatID

    echo "row ", lowRow, ", column ", lowCol, ", seat ID ", seatID

echo "Max seat ID ", maxSeatID