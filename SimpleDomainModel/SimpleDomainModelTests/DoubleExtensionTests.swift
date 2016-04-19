//
//  DoubleExtensionTests.swift
//  SimpleDomainModel
//
//  Created by David Yuan on 4/19/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class DoubleExtensionTests : XCTestCase {
    func testUSD() {
        let myUsd = 10.0.USD
        XCTAssert(myUsd.description == "USD10")
    }
    
    func testEUR() {
        let myEur = 5.0.EUR
        XCTAssert(myEur.description == "EUR5")
    }
    
    func testGBP() {
        let myGbp = 5.9.GBP
        XCTAssert(myGbp.description == "GBP5")
    }
    
    func testYEN() {
        let myYen = 2.4.CAN
        XCTAssert(myYen.description == "CAN2")
    }
    
}