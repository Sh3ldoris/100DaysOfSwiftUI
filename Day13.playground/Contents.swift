import Cocoa

// Define an interface (protocol)
protocol Vehicle {
    func calculateComuteTime(distance: Double) -> Double
}

class MeanOfTransport {
    func doTransport() {
        print("Transport!")
    }
}

// Implement the protocol (adopt it) (Base classes go first)
class Car: MeanOfTransport, Vehicle {
    let timeIndex = 0.6
    
    func calculateComuteTime(distance: Double) -> Double {
        return distance * timeIndex
    }
}

class Truck : Vehicle {
    func calculateComuteTime(distance: Double) -> Double {
        return distance * 1.1
    }
}

// Work with protocols
func comute(vehicle: Vehicle, distance: Double) -> Void {
    if (vehicle.calculateComuteTime(distance: distance) < distance * 0.9) {
        print("Fast comute")
    } else {
        print("Slow comute")
    }
}


comute(vehicle: Car(), distance: 20)
let c = Car()
c.doTransport()


// Opaque usage
func getRandomNumber() -> some Equatable {
    return Int.random(in: 0...100)
}

func generateVehicle(type: String) -> some Vehicle {
    return Car() // You have to return only one implementation of Vehicle
}

// Extension
extension String {
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
    
    // With extension this is non-mutating, use past sentance
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // This mutate the value so present sentence
    mutating func trim() {
        self = self.trimmed()
    }
}

var s = " hej \n noo\n nie"
s.trim()
s.lines

var ml = """
asdadad
 noo
"""
ml.trim()

// How to use protocol extensions
// - Extension is defined on a type (class or whatever)
// - there is technique called POP - protocol oriented programming
//      - define a domain class
//      - extensions can replace utils functions ?

class Person {
    private(set) var name: String
    private(set) var age: Int
    private(set) var nationality: String
    
    init(name: String, age: Int, nationality: String) {
        self.name = name
        self.age = age
        self.nationality = nationality
    }
    
    func updateName(to nameToUpdate: String) -> Bool {
        let isSameName = self.name == nameToUpdate
        let isNameShort = nameToUpdate.count < 4
        
        if ( isSameName || isNameShort) {
            return false
        } else {
            self.name = nameToUpdate
            return true
        }
    }
    
    func updateAge(to ageToUpdate: Int ) -> Bool {
        if (ageToUpdate <= self.age) {
            return false
        } else {
            self.age = ageToUpdate
            return true
        }
    }
}

extension Person {
    func isAdult() -> Bool {
        self.age >= 18
    }
    func isSlovak() -> Bool {
        self.nationality == "Slovak"
    }
}

let me = Person(name: "Adkou", age: 26, nationality: "Slovak")
print(me.isAdult(), me.isSlovak())

// Advanced usage

// Define a generic extension for numbers
extension Numeric {
    // To return correct Type of number, use Self (self refers to a value)
    func squared() -> Self {
        self * self
    }
}
let n: Double = 5.1
print(n.squared())

// Chellenge 8
protocol Building {
    var rooms: Int { get }
    var cost: Int { get set }
    var estateAgent: String { get }
    
    func summarty() -> String
}

struct House: Building {
    var rooms: Int
    var cost: Int
    var estateAgent: String
    
    func summarty() -> String {
        "House has \(rooms) rooms, cost \(cost) and is managed by \(estateAgent)"
    }
}

struct Office: Building {
    var rooms: Int
    var cost: Int
    var estateAgent: String
    
    func summarty() -> String {
        "Office has \(rooms) rooms, cost \(cost) and is managed by \(estateAgent)"
    }
}

var o = Office(rooms: 10, cost: 1000, estateAgent: "Name Estate")
o.rooms = 20
