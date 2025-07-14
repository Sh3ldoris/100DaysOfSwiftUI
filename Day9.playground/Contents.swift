import Cocoa


var a = ["a", "c", "b"]
a.sort {$0 < $1}

print(a)

// accept function as parm
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var resultArr = [Int]();
    for _ in 0..<size {
        resultArr.append(generator())
    }
    return resultArr
}
let genArr = makeArray(size: 10, using: { Int.random(in: 1...100)})

print(genArr)

// Multiple func params
func doStuff(first: () -> Void, second: () -> Void) {
    print("Before first")
    first()
    print("Before second")
    second()
}

doStuff(first: { print("1st stff")}, second: {print("2nd stuff")})

// Challenge
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

var f = luckyNumbers.filter { !$0.isMultiple(of: 2)}
f.sort {$0 < $1}
var s = f.map { "\($0) is a lucky number"}

print(s)
