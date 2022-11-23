import Foundation

protocol HotDrink
{
  func consume()
}

class Tea : HotDrink {
    func consume() {
        print("This tea is nice but I'd prefer it with milk.")
    }
}

class Coffee : HotDrink {
  func consume() {
    print("This coffee is delicious!")
  }
}

protocol HotDrinkFactory {
  func prepare(amount: Int) -> HotDrink
  init()
}

class TeaFactory : HotDrinkFactory{
  required init() {}
  func prepare(amount: Int) -> HotDrink {
    print("Put in tea bag, boil water, pour \(amount) ml, add lemon, enjoy!")
    return Tea()
  }
}

class CoffeeFactory : HotDrinkFactory {
  required init() {}
  func prepare(amount: Int) -> HotDrink {
    print("Grind some beans, boil water, pour \(amount) ml, add cream and sugar, enjoy!")
    return Coffee()
  }
}

class HotDrinkMachine {

  enum AvailableDrink : String, CaseIterable { // violates open-closed {
    case coffee = "Coffee"
    case tea = "Tea"
      
      func type() -> HotDrinkFactory {
          switch self {
          case .coffee:
              return CoffeeFactory()
          case .tea:
              return TeaFactory()
          }
      }
  }

  internal var factories = [AvailableDrink: HotDrinkFactory]()

  internal var namedFactories = [(String, HotDrinkFactory)]()

  init() {
    for drink in AvailableDrink.allCases {
      let factory = drink.type()
      factories[drink] = factory
      namedFactories.append((drink.rawValue, factory))
    }
  }

  func makeDrink() -> HotDrink {
    print("Available drinks")
    for i in 0..<namedFactories.count
    {
      let tuple = namedFactories[i]
      print("\(i): \(tuple.0)")
    }
    let input = Int(readLine()!)!
    return namedFactories[input].1.prepare(amount: 250)
  }
}

func main()
{
  let machine = HotDrinkMachine()
  print(machine.namedFactories.count)
  let drink = machine.makeDrink()
  drink.consume()
}

main()
