import Cocoa

/// Return simple Tupple with name
func getTupple() -> (firstName: String, lastName: String) {
    return (firstName: "John", lastName: "Snow") // return ("ThisName", "ThisLastName")
}

let user = getTupple()
print("\(user.firstName) \(user.lastName)")

//let (firstName, lastName) = getTupple()
//print("\(firstName) \(lastName)")

let (_, lastName) = getTupple()
print("\(lastName)")
print(getTupple())


/// Function with empty parameter name (when using it doesn't have to be provided)
func isLongName(_ name: String) -> Bool {
    return name.count > 10
}
print(isLongName("John Snow"));


/// Function with alias param name define for outer usage
func printTimesStar(for count: Int = 12) {
    for i in 1...count {
        print("*")
    }
}
printTimesStar(for: 10)
printTimesStar() // Run for 12

/**
 EROORS
 */

// Define enum of possible errors
enum PasswordError: Error {
    case short, obvious
}


/// Password checked that throws error
func checkPass(_ password: String) throws -> Bool {
    if password.count < 4 {
        throw PasswordError.short
    }
    if password == "0000" {
        throw PasswordError.obvious
    }
    
    return true;
}

// Run the function
do {
    // Always use try to indicate that func can throw error
    let isGoodPass = try checkPass("0000")
    print(isGoodPass)
} catch PasswordError.obvious{
    print("There was an obvious error")
} catch {
    print("Som¬ething went wrong")
}


func findSqrtOf(_ n: Int) throws -> Int {
    if (n < 1 || n > 10_000) {
        throw PasswordError.obvious
    }
    
    for i in 1...100 {
        if (i * i == n) {
            return i;
        }
    }
    
    return -1;
    
}

print(try! findSqrtOf(10_000))
