//
//  ValidatorsMediumPostTests.swift
//  ValidatorsMediumPostTests
//
//  Created by Arlind on 8/1/18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import XCTest
@testable import Validators

class ValidatorsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testProjectNumberValidator() {
        let validator = ProjectIdentifierValidator()
        
        let invalidProjectNumber = try? validator.validated("ABSC-12")
        XCTAssertNil(invalidProjectNumber)
        
        let validProjectId = "J3-123A"
        let validProjectIdValidated = try? validator.validated(validProjectId)
        XCTAssertEqual(validProjectId, validProjectIdValidated)
    }
    
    func testUsernameValidator() {
        let validator = UserNameValidator()
        let shortUsername = try? validator.validated( "ab")
        XCTAssertNil(shortUsername)
        
        let tooLongUsername = try? validator.validated("ABCDEFGHIJKLMNOPQR")//17 chars
        XCTAssertNil(tooLongUsername)
        
        let whitespaceUsername = try? validator.validated("a cv as")
        XCTAssertNil(whitespaceUsername)
        
        let specialCharactersUsername = try? validator.validated("a#as!")
        XCTAssertNil(specialCharactersUsername)
        
        let mixedWithNumbers = try? validator.validated("arlind123")
        XCTAssertNil(mixedWithNumbers)
        
        let mixedWithNumbers2 = try? validator.validated("123arl12ind123")
        XCTAssertNil(mixedWithNumbers2)
        
        let validUsername = "arlind"
        let validatedUsername = try? validator.validated(validUsername)
        XCTAssertEqual(validUsername, validatedUsername)
    }
    
    func testPasswordValidator() {
        let validator = PasswordValidator()
        let numbersOnlyPassword = try? validator.validated("123456")
        XCTAssertNil(numbersOnlyPassword)
        
        let shortPassword = try? validator.validated("as345")
        XCTAssertNil(shortPassword)
        
        let lettersOnlyPassword = try? validator.validated("abcdef")
        XCTAssertNil(lettersOnlyPassword)
        
        let validPasword = "abcde1"
        let validatedPassword = try? validator.validated(validPasword)
        XCTAssertEqual(validatedPassword, validPasword)
    }
    
    func testRequiredFieldValidator() {
        let validator = RequiredFieldValidator("Test Field")
        let emptyField = try? validator.validated("")
        XCTAssertNil(emptyField)
        
        let validField = try? validator.validated("valid field")
        XCTAssertEqual("valid field", validField)
    }
    
}
