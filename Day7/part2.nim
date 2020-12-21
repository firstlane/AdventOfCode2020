import re
import intsets
import strutils
import tables

type BagCount = object
    id, count: int

var bagIDs: Table[string, int]
var compatibleBags: Table[int, seq[BagCount]]

let file = open("input.txt", FileMode.fmRead)
var line: string
var id = 0
while file.readLine(line):
    var bag = line.substr(0, line.find(re" bags contain", 0) - 1)
    if not bagIDs.contains(bag):
        bagIDs[bag] = id
        id += 1
    # echo "Stored bag \"", bag, "\" in bagIDs with ID ", id

    for bagString in line.findAll(re"\d [A-za-z]* [A-Za-z]*", 0):
        # echo "bagString = \"", bagString, "\""
        var splitIndex = bagString.find(" ")
        var num = parseInt(bagString.substr(0, splitIndex - 1))
        var subBag = bagString.substr(splitIndex + 1)
        # echo num, " ", subBag
        if not bagIDs.contains(subBag):
            bagIDs[subBag] = id
            id += 1

        var bagCount: BagCount
        bagCount.id = bagIDs[subBag]
        bagCount.count = num
        if not compatibleBags.contains(bagIDs[bag]):
            var bags: seq[BagCount]
            compatibleBags[bagIDs[bag]] = bags
        compatibleBags[bagIDs[bag]].add(bagCount)
close(file)

# Build for easy name lookup while debugging
var idToName: Table[int, string]
for key, value in bagIDs:
    idToName[value] = key

proc CountBags(search: int): int = 
    if compatibleBags.contains(search):
        var returnCount = 0
        for bag in compatibleBags[search]:
            var count = CountBags(bag.id)

            if count == 0:
                returnCount += bag.count
            else:
                returnCount += ((count * bag.count) + bag.count)
        return returnCount
    else:
        return 0

echo CountBags(bagIDs["shiny gold"])