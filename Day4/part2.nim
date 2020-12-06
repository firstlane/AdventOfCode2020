import sequtils
import strutils
import tables

type Passport = Table[string, string]

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
        passport[items[0]] = items[1]
close(file)
passports.add(passport)

proc ValidateBirthYear(passport: Passport): bool =
    if passport.contains("byr"):
        var byr = parseInt(passport["byr"])
        if byr >= 1920 and byr <= 2002:
            return true
        else:
            return false
    else:
        return false

proc ValidateIssueYear(passport: Passport): bool =
    if passport.contains("iyr"):
        var iyr = parseInt(passport["iyr"])
        if iyr >= 2010 and iyr <= 2020:
            return true
        else:
            return false
    else:
        return false

proc ValidateExpYear(passport: Passport): bool =
    if passport.contains("eyr"):
        var eyr = parseInt(passport["eyr"])
        if eyr >= 2020 and eyr <= 2030:
            return true
        else:
            return false
    else:
        return false

proc ValidateHeight(passport: Passport): bool =
    if passport.contains("hgt"):
        var hgtString = passport["hgt"]
        var unit = hgtString.substr(len(hgtString) - 2)
        var hgt = parseInt(hgtString.substr(0, len(hgtString) - 2))
        case unit
        of "in":
            if hgt >= 59 and hgt <= 76:
                return true
            else:
                return false
        of "cm":
            if hgt >= 150 and hgt <= 193:
                return true
            else:
                return false
        else:
            echo "Unhanlded case"
            quit()
    else:
        return false

proc ValidateHairColor(passport: Passport): bool =
    if passport.contains("hcl"):
        var hcl = passport["hcl"]
        

        if byr >= 1920 and byr <= 2002:
            return true
        else:
            return false
    else:
        return false

proc ValidateEyeColor(passport: Passport): bool =
    if passport.contains("byr"):
        var byr = parseInt(passport["byr"])
        if byr >= 1920 and byr <= 2002:
            return true
        else:
            return false
    else:
        return false

proc ValidatePassportId(passport: Passport): bool =
    if passport.contains("byr"):
        var byr = parseInt(passport["byr"])
        if byr >= 1920 and byr <= 2002:
            return true
        else:
            return false
    else:
        return false


var numValidPassports = 0

for pass in passports:
    if ContainsOnlyOne(pass, "byr") and ContainsOnlyOne(pass, "iyr") and ContainsOnlyOne(pass, "eyr") and ContainsOnlyOne(pass, "hgt") and ContainsOnlyOne(pass, "hcl") and ContainsOnlyOne(pass, "ecl") and ContainsOnlyOne(pass, "pid"):
        numValidPassports += 1

echo numValidPassports