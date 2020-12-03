import strutils

type PasswordLine = tuple
    pos1: int
    pos2: int
    letter: char
    password: string

proc SplitLine(line: string): PasswordLine =
    # Split line on spaces
    var items = splitWhitespace(line)

    var numRange = items[0]
    var letter = items[1]
    var password = items[2]

    var value: PasswordLine

    # Get the range of valid character occurrences
    var nums = split(numRange, '-')
    value.pos1 = parseInt(nums[0])
    value.pos2 = parseInt(nums[1])

    # Get the character and password
    value.letter = letter[0]
    value.password = password

    return value

var lines = newSeq[string]()

let file = open("input.txt", FileMode.fmRead)
var line: string
while file.readLine(line):
    lines.add(line)
close(file)

var numValid = 0
for line in lines:
    var pass = SplitLine(line)

    if pass.password[pass.pos1 - 1] == pass.letter xor pass.password[pass.pos2 - 1] == pass.letter:
        numValid += 1

echo numValid
