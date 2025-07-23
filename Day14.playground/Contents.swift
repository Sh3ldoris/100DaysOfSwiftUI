import Cocoa

// Optionals

var myVar: Int? = 3

if let unwrappedVar = myVar {
    // Will run only if myVar has a value inside
} else {
    // there is no value
}

// Guard are mostly used in inputs check, they are required to return function in check fails
func foo(p: Int?) {
    guard let unwrappedVar = p else {
        // Run if myVar doesn't have a value inside
        print("")
        return
    }
}


// nil coalescing
let new = myVar ?? 5
let dict: [String: Int] = ["a": 1]
let b = dict["b", default: 0]
 

enum UserError: Error {
    case invalidId, networkError
}

func getUser(id: Int?) throws -> String {
    guard let id = id else {
        throw UserError.invalidId
    }
    return "User"
}
// Catch error and return default user
let serverUser = (try? getUser(id: nil)) ?? "Anonymous"

if let user = try? getUser(id: 1) {
    print(user)
}

print(serverUser)

// Challange

func getRandom(arr: [Int]?) -> Int {
    arr?.randomElement() ?? Int.random(in: 1...100)
}

print(getRandom(arr: nil ))
