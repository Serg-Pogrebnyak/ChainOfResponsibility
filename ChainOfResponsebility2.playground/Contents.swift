import UIKit

protocol Handler {
    var nextHandler: Handler? {get set}
    
    func setNextHandler(handler: Handler)
    func handle(car: [String]) -> Bool
}

class BaseHandler: Handler {
    var nextHandler: Handler?
    
    func setNextHandler(handler: Handler) {
        self.nextHandler = handler
    }
    
    func handle(car: [String]) -> Bool {
        return nextHandler?.handle(car: car) ?? false
    }
}

class CarWithWheelsHandler: BaseHandler {
    override func handle(car: [String]) -> Bool {
        if car.first == "4 wheels" {
            print("car with wheels)")
            var nextArray = car
            nextArray.removeFirst()
            return nextHandler == nil ? true : nextHandler!.handle(car: nextArray)
        } else {
            return false
        }
    }
}

class CarWithEngineHandler: BaseHandler {
    override func handle(car: [String]) -> Bool {
        if car.first == "engine" {
            print("car with engine)")
            var nextArray = car
            nextArray.removeFirst()
            return nextHandler == nil ? true : nextHandler!.handle(car: nextArray)
        } else {
            return false
        }
    }
}

class CarWithRoofHandler: BaseHandler {
    override func handle(car: [String]) -> Bool {
        if car.first == "roof" {
            print("car with roof)")
            var nextArray = car
            nextArray.removeFirst()
            return nextHandler == nil ? true : nextHandler!.handle(car: nextArray)
        } else {
            return false
        }
    }
}

class Car {
    
    static func checkIsValidCar(handler: Handler) {
        let carPartsArray = ["4 wheels", "engine", "roof"]
        
        if handler.handle(car: carPartsArray) {
            print("all done")
        } else {
            print("car is invalid")
        }
    }
}

let engineHandler = CarWithEngineHandler()
let roofHandler = CarWithRoofHandler()
let wheelsHandler = CarWithWheelsHandler()
engineHandler.setNextHandler(handler: roofHandler)
wheelsHandler.setNextHandler(handler: engineHandler)

Car.checkIsValidCar(handler: wheelsHandler)
