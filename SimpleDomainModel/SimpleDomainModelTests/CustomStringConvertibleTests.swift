//
//  CustomStringConvertibleTests.swift
//  SimpleDomainModel
//
//  Created by David Yuan on 4/18/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class CustomStringConvertibleTests : XCTestCase {
    // test Money class
    
    func testMoneyStringDescription() {
        let fiveUSD = Money(amount: 5, currency: "USD")
        XCTAssert(fiveUSD.description == "USD5")
    }
    
    func testMoneyStringDescription2() {
        let tenCAN = Money(amount: 10, currency: "CAN")
        XCTAssert(tenCAN.description == "CAN10")
    }
    
    
    
    func testJobStringDescriptionSalary() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.description == "Guest Lecturer - $1000 per year")
    }
    
    func testJobStringDescriptionHourly() {
        let job = Job(title: "Substitute Teacher", type: Job.JobType.Hourly(15))
        XCTAssert(job.description == "Substitute Teacher - $15.0 per hour")
    }
    
    func testPersonStringDescription() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        XCTAssert(ted.description == "firstName:Ted lastName:Neward age:45 job:has no job spouse:has no spouse")
    }
    
    func testFamilyStringDescription() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        
        let family = Family(spouse1: ted, spouse2: charlotte)
        
        XCTAssert(family.description == "[Person: firstName:Ted lastName:Neward age:45 job:Guest Lecturer spouse:Charlotte Neward] [Person: firstName:Charlotte lastName:Neward age:45 job:has no job spouse:Ted Neward] Household Income: 1000")
    }
}