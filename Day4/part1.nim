import sequtils
import strutils

type Field = tuple[key: string, value: string]
type Passport = seq[Field]

var passports: seq[Passport]

let file = open("input.txt", FileMode.fmRead)
var line: string
var passport: Passport
while file.readLine(line):
    if line == "":
        passports.add(passport)
        passport = Passport.default
        continue

    var keyValPairs = line.split(' ')
    for pair in keyValPairs:
        var items = pair.split(':')
        var tup: Field
        tup.key = items[0]
        tup.value = items[1]
        passport.add(tup)
close(file)
passports.add(passport)

proc ContainsOnlyOne(passport: Passport, searchKey: string): bool =
    var count = countIt(passport, it.key == searchKey)
    if count == 0:
        echo "Invalid passport: missing field ", searchKey
        return false
    if count == 1:
        return true
    if count > 1:
        echo "Passport has multiple entries for same field"
        return false

var numValidPassports = 0

for pass in passports:
    if ContainsOnlyOne(pass, "byr") and ContainsOnlyOne(pass, "iyr") and ContainsOnlyOne(pass, "eyr") and ContainsOnlyOne(pass, "hgt") and ContainsOnlyOne(pass, "hcl") and ContainsOnlyOne(pass, "ecl") and ContainsOnlyOne(pass, "pid"):
        numValidPassports += 1

echo numValidPassports