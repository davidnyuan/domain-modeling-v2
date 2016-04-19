//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

public class TestMe {
  public func Please() -> String {
    return "I have been tested"
  }
}


// CustomStringConvertible Protocol
protocol CustomStringConvertible {
    var description : String { get }
}

//Mathmatics protocol 
protocol Mathematics {
    func +(left: Money, right: Money) -> Money
    func -(left: Money, right: Money) -> Money
}

public func +(left: Money, right: Money) -> Money {
    let result = left.add(right)
    return result
}

public func -(left: Money, right: Money) -> Money {
    let result = left.subtract(right)
    return result
}

extension Double {
    var USD: Money {return Money(amount: Int(self), currency: "USD")}
    
    var EUR: Money {return Money(amount: Int(self), currency: "EUR")}
    
    var GBP: Money {return Money(amount: Int(self), currency: "GBP")}
    
    var CAN: Money {return Money(amount: Int(self), currency: "CAN")}
}

////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics{
  public var amount : Int
  public var currency : String
  
  public func convert(to: String) -> Money {
    let currencyConverter: [String: Double] = ["USD": 1, "GBP": 0.5, "EUR": 1.5, "CAN": 1.25]
    return(Money(amount: Int(Double(amount) * (currencyConverter[to]! / currencyConverter[currency]!)), currency: to))
    }
  
  public func add(to: Money) -> Money {
    if(currency == to.currency) {
        return(Money(amount: (amount + to.amount), currency: self.currency))
    } else {
        // Different currencies
        return(Money(amount: (convert(to.currency).amount + to.amount), currency: to.currency))
    }
  }
    
  public func subtract(from: Money) -> Money {
    if(currency == from.currency) {
        return(Money(amount: (amount - from.amount), currency: self.currency))
    } else {
        // Different currencies
        return(Money(amount: (convert(from.currency).amount - from.amount), currency: from.currency))
    }
    }
    
    public var description: String {
        get {
            return("\(currency)\(amount)")
        }
    }
}

////////////////////////////////////
// Job
//
public class Job : CustomStringConvertible{
  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
    public var title : String
    public var type : JobType
    
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  public func calculateIncome(hours: Int) -> Int {
    switch type {
    case .Hourly(let value):
        return(Int(Double(hours) * (value)))
    case .Salary(let value):
        return value
    }
  }
    
    public func raise(amt : Double) {
        switch type {
        case .Hourly(let value):
            self.type = JobType.Hourly(value + amt)
        case .Salary(let value):
            self.type = JobType.Salary(value + Int(amt))
        }
    }
    public var description: String {
        get {
            switch type {
            case .Hourly(let value):
                return("\(title) - $\(value) per hour")
            case .Salary(let value ):
                return("\(title) - $\(value) per year")
            }        }
    }
}

////////////////////////////////////
// Person
//

public class Person : CustomStringConvertible{
    var firstName : String = ""
    var lastName : String = ""
    var age : Int = 0
    private var _job: Job?
    private var _spouse: Person?
    
    public var job: Job? {
        get {
            return self._job
        }
        set(value) {
            if(age >= 16) {
                self._job = value
            } else {
                self._job = nil
            }
        }
    }
    
    public var spouse : Person? {
        get {
            return self._spouse
        }
        set(value) {
            if(self.age >= 18) {
                self._spouse = value
            } else {
                self._spouse = nil
            }
        }
    }

    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
  
  public func toString() -> String {
    return("[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]")
  }
    
    public var description: String {
        get {
            var isJob = "has no job"
            
            var isSpouse = "has no spouse"
            
            if self.job != nil {
                isJob = self.job!.title
            }
            
            if self.spouse != nil {
                isSpouse = "\(self.spouse!.firstName) \(self.spouse!.lastName)"
            }
            return "firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(isJob) spouse:\(isSpouse)"
        }
    }
}

////////////////////////////////////
// Family
//
public class Family : CustomStringConvertible{
  private var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if(spouse1.age >= 18 && spouse2.age >= 18) {
        if(spouse1.spouse == nil && spouse2.spouse == nil) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
  }
  
  public func haveChild(child: Person) -> Bool {
    var canhave = false
    for person: Person in members {
        if(person.age >= 21) {
            canhave = true
        }
        if(canhave) {
            var notalreadyin = true
            for person: Person in members {
                if(person.firstName == child.firstName) {
                    notalreadyin = false
                }
            }
            if(notalreadyin) {
                members.append(child)
            }
        }
    }
    return canhave
  }
  
  public func householdIncome() -> Int {
    var totalIncome = 0
    for person in members {
        if(person.job != nil) {
            totalIncome += person.job!.calculateIncome(2000)
            print(person.firstName)
            print(person.job!.calculateIncome(2000))
        }
    }
    return totalIncome
  }
    
    public var description: String {
        get {
            var longString: String = ""
            for person in members {
                longString += "[Person: \(person.description)] "
            }
            longString += "Household Income: \(householdIncome())"
            return longString
        }
    }
}


