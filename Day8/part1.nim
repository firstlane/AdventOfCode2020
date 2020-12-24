import re
import intsets
import strutils
import tables

type Operation = enum
    acc,
    jmp,
    nop

type Instruction = tuple[operation: Operation, value: int, complete: bool]

var instructions: seq[Instruction]

let file = open("input.txt", FileMode.fmRead)
var line: string
var id = 0
while file.readLine(line):
    var items = line.split(' ')
    var op = Operation.nop
    case items[0]
    of "acc": op = Operation.acc
    of "jmp": op = Operation.jmp
    of "nop": op = Operation.nop
    else: discard
    var val = parseInt(items[1])

    instructions.add((op, val, false))
close(file)

var accumulator = 0

var i = 0

while true:
    if instructions[i].complete:
        break

    instructions[i].complete = true
    case instructions[i].operation
    of Operation.acc:
        accumulator += instructions[i].value
        i += 1
    of Operation.jmp:
        i += instructions[i].value
    of Operation.nop:
        i += 1
    else:
        echo "Unhandled case"
        quit(1)

echo accumulator
