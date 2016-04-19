//
//  MathematicsTest.swift
//  SimpleDomainModel
//
//  Created by David Yuan on 4/18/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class MathematicsTests : XCTestCase {
    let tenUSD = Money(amount: 10, currency: "USD")
    let fiveUSD = Money(amount: 5, currency: "USD")
    
    func testAddMoney() {
        let total = tenUSD + tenUSD
        XCTAssert(total.amount == 20)
        XCTAssert(total.currency == "USD")
    }
    
    func testAddMoney2() {
        let total = fiveUSD + tenUSD
        XCTAssert(total.amount == 15)
        XCTAssert(total.currency == "USD")
    }
    
    func testSubtractMoney() {
        let total = tenUSD - tenUSD
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "USD")
    }
    
    func testSubtractMoney2() {
        let total = tenUSD - fiveUSD
        XCTAssert(total.amount == 5)
        XCTAssert(total.currency == "USD")
    }
    
}