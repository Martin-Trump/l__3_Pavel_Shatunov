//
//  main.swift
//  l__3_Pavel_Shatunov
//
//  Created by Павел Шатунов on 14.03.2021.
//

import Foundation

enum WindowStatus: String {
    case opened = "открыты"
    case closed = "закрыты"
}
enum EngineStatus: String {
    case on = "запущен"
    case off = "заглушен"
}
enum TrunkStatus {
    case full, empty
}
enum StatusChange {
    case openWindow, closeWindow, startEngine, stopEngine
}
enum Trailer: String {
    case linked = "сцеплен"
    case disengaged = "расцеплен"
}
func printString() {
    print("______________________________")
}
struct SportCar {
    let brand: String
    let releaseYear: Int
    let trunkVolume: Double
    var engineStatus: EngineStatus {
        willSet {
            print("Двигатель будет \(newValue.rawValue)")
        }
    }
    var windowStatus: WindowStatus {
        willSet {
            print("Окна будут \(newValue.rawValue)")
        }
    }
    var usedTrunkVolume: Double
    var notUsedVolume: Double {
            return trunkVolume - usedTrunkVolume
    }
    mutating func changeTrunkStatus(mode: TrunkStatus) {
        switch mode {
        case .full:
            usedTrunkVolume = trunkVolume
        case .empty:
            usedTrunkVolume = 0
        }
    }
    mutating func putLuggage(weight: Double) {
        if notUsedVolume >= weight  && (weight + usedTrunkVolume) >= 0 {
            usedTrunkVolume += weight
            print("Загружено \(usedTrunkVolume) кг, еще можно загрузить \(notUsedVolume) кг")
        }
        else {
            print("Невозможно выполнить, т.к. загружено \(usedTrunkVolume) кг. Еще можно загрузить \(notUsedVolume) кг  ")
        }
        
    }
    mutating func statusChange(action: StatusChange) {
        switch action {
        case .openWindow:
            windowStatus = .opened
        case .closeWindow:
            windowStatus = .closed
        case .stopEngine:
            engineStatus = .off
        case .startEngine:
            engineStatus = .on
        }
    }
}
//
var bmw = SportCar(brand: "BMW", releaseYear: 2015, trunkVolume: 2000, engineStatus: .on, windowStatus: .opened, usedTrunkVolume: 1000)
print(bmw.brand)
bmw.putLuggage(weight: -200)
bmw.statusChange(action: .openWindow)
bmw.changeTrunkStatus(mode: .full)
print("\(bmw.usedTrunkVolume) загружено")
bmw.statusChange(action: .closeWindow)
printString()
//
var mercedes = SportCar(brand: "Mercedes" , releaseYear: 2019, trunkVolume: 1500, engineStatus: .off, windowStatus: .closed, usedTrunkVolume: 0)
print(mercedes.brand)
mercedes.statusChange(action: .openWindow)
mercedes.windowStatus = .closed
mercedes.putLuggage(weight: 700)
mercedes.putLuggage(weight: -300)
mercedes.changeTrunkStatus(mode: .empty)
mercedes.statusChange(action: .startEngine)
printString()

//2

struct TruckCar {
    let brand: String
    let releaseYear: Int
    let trunkVolume: Double
    var trailer: Trailer
    var kilometers: Double {
        didSet {
            print("Вы недавно проехали \(kilometers - oldValue) км")
        }
    }
    var engineStatus: EngineStatus {
        willSet {
            print("Двигатель будет \(newValue.rawValue)")
        }
    }
    var windowStatus: WindowStatus {
        willSet {
            print("Окна будут \(newValue.rawValue)")
        }
    }
    var usedTrunkVolume: Double
    var notUsedVolume: Double {
            return trunkVolume - usedTrunkVolume
    }
    mutating func changeTrunkStatus(mode: TrunkStatus) {
        switch mode {
        case .full:
            usedTrunkVolume = trunkVolume
        case .empty:
            usedTrunkVolume = 0
        }
    }
    mutating func putLuggage(weight: Double) {
        if notUsedVolume >= weight && (weight + usedTrunkVolume) >= 0 {
            usedTrunkVolume += weight
            print("Загружено \(usedTrunkVolume) кг, еще можно загрузить \(notUsedVolume) кг")
        }
        else {
            print("Невозможно выполнить, т.к. загружено \(usedTrunkVolume) кг. Еще можно загрузить \(notUsedVolume) кг  ")
        }
        
    }
    mutating func statusChange(action: StatusChange) {
        switch action {
        case .openWindow:
            windowStatus = .opened
        case .closeWindow:
            windowStatus = .closed
        case .stopEngine:
            engineStatus = .off
        case .startEngine:
            engineStatus = .on
        }
    }
    mutating func linkTrailer() {
        trailer = .linked
    }
    mutating func disengageTrailer() {
        trailer = .disengaged
    }
}

var volvo = TruckCar(brand: "Volvo", releaseYear: 2005, trunkVolume: 30000, trailer: .linked, kilometers: 1000000, engineStatus: .on, windowStatus: .closed, usedTrunkVolume: 15000)
print(volvo.brand)
volvo.disengageTrailer()
volvo.changeTrunkStatus(mode: .full)
volvo.kilometers = 1000100
volvo.windowStatus = .opened
volvo.linkTrailer()
print(volvo.trailer.rawValue)
printString()
//
var scania = TruckCar(brand: "Scania", releaseYear: 2011, trunkVolume: 70450.80, trailer: .disengaged, kilometers: 120000, engineStatus: .on, windowStatus: .opened, usedTrunkVolume: 10)
print(scania.brand)
scania.changeTrunkStatus(mode: .full)
scania.statusChange(action: .stopEngine)
scania.linkTrailer()
scania.engineStatus = .on
print("Окна \(scania.windowStatus.rawValue)")
