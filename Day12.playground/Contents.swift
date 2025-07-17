import Cocoa

class Vehicle {
    let wheels: Int
    
    init (wheels: Int) {
        self.wheels = wheels
    }
}

class Car: Vehicle {
    func honk () -> Void {
        print("Small Honk!")
    }
}

class Truck: Vehicle {
    var loadWeight: Int {
        didSet {
            print("Load is \(loadWeight)")
        }
    }
    let name: String
    
    init(load: Int, name: String) {
        self.loadWeight = load
        self.name = name
        super.init(wheels: 6)
    }
    
    func honk () -> Void {
        print("Big Honk!")
    }
    
    // Manual copy of class
    func copy() -> Truck {
        return Truck(load: self.loadWeight, name: "Copy")
    }
    
    // Destruction
    deinit {
        print("End of Truck \(self.name)")
    }
}

let myTruck: Truck = Truck(load: 1000, name: "MyOwn")
myTruck.honk()

// Check scope destruction
for _ in 0..<10 {
    let myTruck: Truck = Truck(load: 1000, name: "MyOwn")
    myTruck.honk()
}

// Checkpoint
class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
    init() {
        self.legs = 4
    }
    
    func speak() {}
}

class Dog: Animal {
    override init() {
        super.init(legs: 4)
    }
    
    override func speak() {
        print("Bark!")
    }
}

class Poodle: Dog {
    override init() {
        super.init()
    }
    
    override func speak() {
        print("Wuff Poodle!")
    }
}

class Cat: Animal {
    override func speak() {
        print("Meow!")
    }
}


let cat = Cat()
cat.speak()
print(cat.legs)
let poodle = Poodle()
poodle.speak()
