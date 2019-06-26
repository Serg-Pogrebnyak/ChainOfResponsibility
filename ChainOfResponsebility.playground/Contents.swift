import UIKit

protocol Handler {
    var nextHandler: Handler? {get set}
    
    func setNextHandler(handler: Handler)
    func handle(request: String) -> String?
}

class BaseHandler: Handler {
    var nextHandler: Handler?
    
    func setNextHandler(handler: Handler) {
        self.nextHandler = handler
    }
    
    func handle(request: String) -> String? {
        return nextHandler?.handle(request: request)
    }
}

class CarWithWheelsHandler: BaseHandler {
    override func handle(request: String) -> String? {
        if request == "4 wheels" {
            return "car with wheels)"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class CarWithEngineHandler: BaseHandler {
    override func handle(request: String) -> String? {
        if request == "engine" {
            return "car with engine)"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class CarWithRoofHandler: BaseHandler {
    override func handle(request: String) -> String? {
        if request == "roof" {
            return "car with roof)"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class Car {
    static func checkIsValidCar(handler: Handler) {
        let carPartsArray = ["roof", "4 wheels", "engine", "part"]
        
        for part in carPartsArray {
            if let result = handler.handle(request: part) {
                print(result)
            } else {
                print("\(part) is invalid")
                return
            }
        }
    }
}

let engineHandler = CarWithEngineHandler()
let roofHandler = CarWithRoofHandler()
let wheelsHandler = CarWithWheelsHandler()
engineHandler.setNextHandler(handler: roofHandler)
wheelsHandler.setNextHandler(handler: engineHandler)

Car.checkIsValidCar(handler: wheelsHandler)
