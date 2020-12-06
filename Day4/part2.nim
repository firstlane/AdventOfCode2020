import re
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
        case unit
        of "in":
            var hgt = parseInt(hgtString.substr(0, len(hgtString) - 3))
            if hgt >= 59 and hgt <= 76:
                return true
            else:
                return false
        of "cm":
            var hgt = parseInt(hgtString.substr(0, len(hgtString) - 3))
            if hgt >= 150 and hgt <= 193:
                return true
            else:
                return false
        else:
            # Handle case where data from input has no unit
            var hgt = parseInt(hgtString)
            if (hgt >= 59 and hgt <= 76) or (hgt >= 150 and hgt <= 193):
                return true
            else:
                return false
    else:
        return false

proc ValidateHairColor(passport: Passport): bool =
    if passport.contains("hcl"):
        var hcl = passport["hcl"]
        if hcl.find(re"^#[A-Za-z0-9]{6}$", 0) >= 0:
            return true
        else:
            return false
    else:
        return false

proc ValidateEyeColor(passport: Passport): bool =
    if passport.contains("ecl"):
        var ecl = passport["ecl"]
        if ecl.find(re"^(amb|blu|brn|gry|grn|hzl|oth)$", 0) >= 0:
            return true
        else:
            return false
    else:
        return false

proc ValidatePassportId(passport: Passport): bool =
    if passport.contains("pid"):
        var pid = passport["pid"]
        if pid.find(re"^[0-9]{9}$", 0) >= 0:
            return true
        else:
            return false
    else:
        return false


var numValidPassports = 0

for pass in passports:
    if ValidateBirthYear(pass) and ValidateExpYear(pass) and ValidateEyeColor(pass) and ValidateHairColor(pass) and ValidateHeight(pass) and ValidateIssueYear(pass) and ValidatePassportId(pass):
        numValidPassports += 1

echo numValidPassports