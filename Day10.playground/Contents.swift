import Cocoa

// Example of Struct
// Func in struct can change its attributes only if they are marked with mutating
struct ExmapleStruct {
    let name: String
    var price: Double {
        willSet {
            print("Price will be set to: \(newValue)")
        }
        didSet {
            print("Price was: \(oldValue)")
        }
    }
    
    // Computed value
    var totalPrice: Double {
        price * 1.23
    }
    
    func getTotalPrice() -> Double { price * 1.23 }
    
    mutating func setDiscount() {
        price *= 0.9
    }
}

// To be able to call the mutating func, the struct needs to be created as var
var s = ExmapleStruct(name: "Exmpl Name", price: 100.0)
print(s.getTotalPrice())
s.setDiscount()
print(s.totalPrice)
s.price = 10

struct Doctor {
    var name: String
    var location: String
    private var currentPatient : String
    
    // custom initializer
    init(_ name: String, _ location: String) {
        self.name = name
        self.location = location
        self.currentPatient = ""
    }
}
let drJones = Doctor("Esther Jones", "Bristol")

// Check point
// Model
// No seats
// Current gear
// Gear up or down method

struct Vehicle {
    let model: String
    let seats: Int
    private(set) var gear = 5
    
    mutating func gearUp() {
        if (gear < 5) {
            gear += 1
        }
    }
    
    mutating func gearDown() {
        if (gear > 1) {
            gear -= 1
        }
    }
}

var myCar = Vehicle(model: "Toyota Corolla", seats: 4)
print(myCar.gear)
myCar.gearDown()
myCar.gearDown()
print(myCar.gear)
