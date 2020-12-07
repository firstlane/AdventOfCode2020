import intsets
import math

var boardingPasses: seq[string]

let file = open("input.txt", FileMode.fmRead)
var line: string
while file.readLine(line):
    boardingPasses.add(line)
close(file)

var passIDs: IntSet

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
    passIDs.incl(seatID)

var arr: seq[int]
for i in 0..127:
    for j in 0..7:
        arr.add(i * 8 + j)
var allIDs = toIntSet(arr)

var missingIDs = difference(allIDs, passIDs)
echo missingIDs

var missingIDsArray: seq[int]
for i in missingIDs.items():
    missingIDsArray.add(i)

for i in countup(0, len(missingIDsArray) - 2):
    if missingIDsArray[i + 1] - missingIDsArray[i] > 1:
        echo "Santa's seat ID is ", missingIDsArray[i + 1]
        break;