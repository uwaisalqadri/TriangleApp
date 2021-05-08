//
//  TriangleAppTests.swift
//  TriangleAppTests
//
//  Created by Uwais Alqadri on 08/05/21.
//

import XCTest
@testable import TriangleApp

class TriangleAppTests: XCTestCase {
    
    func testInvalidInputTest() {
        XCTAssertThrowsError(try detectTriangle(-1, 2, 3)) { error in
            XCTAssertEqual(error as? TriangleError, TriangleError.invalidInput)
        }
    }
    
    func detectTriangle(
        _ sideA: Int,
        _ sideB: Int,
        _ sideC: Int
    ) throws -> String {
        
        let sides = [sideA, sideB, sideC].sorted()
        
        for side in sides {
            if side < 0 {
                throw TriangleError.invalidInput
            }
        }
        
        if sides[1] + sides[0] < sides[2] {
            throw TriangleError.inequalityInput
        } else if sides[0] == sides[1] && sides[0] == sides[2] {
            return "Segitiga sama sisi"
        } else if sides[0] == sides[1] || sides[1] == sides[2] {
            return "Segitiga sama kaki"
        } else if Double((sides[0] * sides[0] + sides[1] * sides[1])).squareRoot() == Double(sides[2]) {
            return "Segitiga siku-siku"
        } else {
            return "Segitiga sembarang"
        }
    }
    
    func testDetectEquilateralTriangle() {
        XCTAssertEqual(try detectTriangle(2, 2, 2), "Segitiga sama sisi") // 2, 2, 2
    }

    func testDetectIsoscelesTriangle() {
        XCTAssertEqual(try detectTriangle(1, 1, 2), "Segitiga sama kaki")
        XCTAssertEqual(try detectTriangle(1, 2, 1), "Segitiga sama kaki")
        XCTAssertEqual(try detectTriangle(1, 2, 2), "Segitiga sama kaki")
        XCTAssertEqual(try detectTriangle(2, 1, 2), "Segitiga sama kaki")
    }
    
    func testInequalityTriangle() {
        XCTAssertThrowsError(try detectTriangle(4, 1, 2)) { error in
            XCTAssertEqual(error as? TriangleError, TriangleError.inequalityInput)
        }
        XCTAssertThrowsError(try detectTriangle(5, 1, 3)) { error in
            XCTAssertEqual(error as? TriangleError, TriangleError.inequalityInput)
        }
    }
    
    func testDetectPythagorasTriangle() {
        XCTAssertEqual(try detectTriangle(6, 8, 10), "Segitiga siku-siku")
    }
    
    enum TriangleError: Error {
        case invalidInput
        case inequalityInput
    }

}
