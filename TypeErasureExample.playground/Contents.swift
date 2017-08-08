import Foundation

// car factory protocol
protocol CarFactoryProtocol {
    associatedtype CarType
    func produce() -> CarType
}

struct ElectricCar {
    let type = "electric"
    let brand: String
}

struct PetrolCar {
    let type = "petrol"
    let brand: String
}

// concrete implementations of the car factories
struct TeslaFactory: CarFactoryProtocol {
    typealias CarType = ElectricCar

    func produce() -> TeslaFactory.CarType {
        print("producing tesla car ...")
        return ElectricCar(brand: "Tesla")
    }
}

struct BMWFactory: CarFactoryProtocol {
    typealias CarType = ElectricCar

    func produce() -> BMWFactory.CarType {
        print("producing bmw car ...")
        return ElectricCar(brand: "BMW")
    }
}

struct ToyotaFactory: CarFactoryProtocol {
    typealias CarType = PetrolCar

    func produce() -> ToyotaFactory.CarType {
        print("producing toyota car ...")
        return PetrolCar(brand: "Toyota")
    }
}

// Type erasure wrapper class
struct AnyCarFactory<CarType>: CarFactoryProtocol {
    private let _produce: () -> CarType

    init<CarFactory: CarFactoryProtocol>(_ carFactory: CarFactory) where CarFactory.CarType == CarType {
        _produce = carFactory.produce
    }

    func produce() -> CarType {
        return _produce()
    }
}

// Let's test it:

let teslaFactory = TeslaFactory()
teslaFactory.produce()

let bmwFactory = BMWFactory()
bmwFactory.produce()

let toyotaFactory = ToyotaFactory()
toyotaFactory.produce()


let factories = [AnyCarFactory(TeslaFactory()), AnyCarFactory(BMWFactory())]
factories.map() { $0.produce() }

