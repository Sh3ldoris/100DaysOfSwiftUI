import Cocoa

enum Foo : Comparable {
    case some
    case any
    case lol
}

// True, since some was declared before any
//print(Foo.some < Foo.any)

let words: [String] = ["Hello", "World"]

// Basic loop
for w in words {
    print("Word of the day is: \(w)!");
}

// in range of 1 to 15 inclusive
for i in 1...15 {
    print("Iterating: \(i).")
}
// In range of 1 to 15 - exclusive with loop label
myLoop: for i in 1..<15 {
    print("Iterating: \(i).")
}

// FizzBuzz
for i in 1...100 {
    if (i % 3 == 0 && i % 5 == 0) {
        print("FizzBuzz")
    } else if (i % 3 == 0) {
        print("Fizz")
    } else if (i % 5 == 0) {
        print("Buzz")
    } else {
        print(i)
    }
}
