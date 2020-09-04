//
//  countOnMeCalculatorTest.swift
//  Calculette-version1Tests
//
//  Created by macmini-Armelle on 21/08/2020.
//  Copyright © 2020 armellelecerf. All rights reserved.
//

import XCTest

@testable import Calculette_version1

class CountOnMeCalculatorTestCase: XCTestCase {
    private var calculator: CountOnMeCalculator!
    func createExpression(nums: [String], opes: [String]) {
     calculator.reset()
        // enumerated nous renvoie l'index et la valeur qui se trouve à cet index
        //dans le tableau sur lequel elle est appelée
        for (index, num) in nums.enumerated() {
            // on ajoute le chiffre à l'expression
            calculator.addANumber(num)
            // si l'index du chiffre actuel est inferieur au nombre d'éléments dans opes
            if index < opes.count {
                // alors on ajoute l'opérateur
               calculator.addOperator(opes[index])
                          }
        }
    }
    override func setUp() {
        super.setUp()
        calculator = CountOnMeCalculator()
        }
    
    func testGivenAnExpressionWithoutEqualSign_WhenCallingExpressionHasResult_ThenResultIsFalse() {
        //given
        createExpression(nums: ["4", "5"], opes: ["+"])
        //when
        let result = calculator.expressionHasResult(elements: calculator.elements)
        //then
        XCTAssertEqual(result, false)
    }
    
    func testGivenAnExpressionWithEqualSign_WhenCallingExpressionHasResult_ThenResultIsTrue() {
        //given
        createExpression(nums: ["7", "5"], opes: ["-"])
        //when
        let result = calculator.expressionHasResult(elements: calculator.elements)
        //then
        XCTAssertEqual(result, false)
    }
    func testGivenAnExpression_WhenCallingReset_ThenResultIsTrue() {
        createExpression(nums: ["5","7", "9", "2"], opes: ["+", "-", "/"])
        calculator.reset()
        XCTAssertTrue(calculator.expression == " ")
    }
    func testGivenAnExpressionWithPlusAndDivide_whenCallingExpressionHasResut_ThenResultIsTrue() {
        createExpression(nums: ["6", "18", "3"], opes: ["-", "/", "="])
        let result = calculator.expressionHasResult(elements: calculator.elements)
        XCTAssertEqual(result, true)
    }
    
    func testGivenLastElementOperatorPlus_whenCallingExpressionIsCorrect_ThenResultIsFalse() {
        createExpression(nums: ["2", "3"], opes: ["-", "+"])
        let result = calculator.expressionIsCorrect(elements: calculator.elements)
        XCTAssertFalse(result)
    }
    
    func testGivenLastElementOperatorMinus_whenCallingExpressionIsCorrect_ThenResultIsFalse() {
        createExpression(nums: ["4", "5"], opes: ["+", "-"])
        let result = calculator.expressionIsCorrect(elements: calculator.elements)
        XCTAssertFalse(result)
    }
    
    func testGivenLastElementOperatorDivide_whenCallingExpressionIsCorrect_ThenResultIsFalse() {
        createExpression(nums: ["7", "3"], opes: ["-", "/"])
        let result = calculator.expressionIsCorrect(elements: calculator.elements)
        XCTAssertFalse(result)
    }
    
    func testGivenLastElementOperatorMultiply_whenCallingExpressionIsCorrect_ThenResultIsFalse() {
        createExpression(nums: ["9", "2"], opes: ["+", "x"])
        let result = calculator.expressionIsCorrect(elements: calculator.elements)
        XCTAssertFalse(result)
    }
    func testGivenFirstElementOperatorPlus_whenCallingExpressionIsCorrect_ThenResultIsFalse() {
        createExpression(nums: ["", "2", "8"], opes: ["+", "-"])
        let result = calculator.expressionIsCorrect(elements: calculator.elements)
        XCTAssertFalse(result)
    }
    func testGivenFirstElementOperatorMinus_whenCallingExpressionIsCorrect_ThenResultIsTrue() {
        createExpression(nums: ["-4", "5"], opes: ["+"])
        let result = calculator.expressionIsCorrect(elements: calculator.elements)
        XCTAssertTrue(result)
    }
    func testGivenFirstElementOperatorDivide_whenCallingExpressionIsCorrect_ThenResultIsFalse() {
        createExpression(nums: ["", "2", "3"], opes: ["/", "-"])
        let result = calculator.expressionIsCorrect(elements: calculator.elements)
        XCTAssertFalse(result)
    }
    func testGivenFirstElementOperatorMultiply_whenCallingExpressionIsCorrect_ThenResultIsFalse() {
        createExpression(nums: ["", "9", "2"], opes: ["x", "+"])
        let result = calculator.expressionIsCorrect(elements: calculator.elements)
        XCTAssertFalse(result)
    }
    func testGivenTwoElements_whenTestingExpressionHasEnoughElements_ThenResultIsFalse() {
        createExpression(nums: ["9"] , opes: ["+"])
        let result = calculator.expressionHasEnoughElement(elements: calculator.elements)
        XCTAssertFalse(result)
    }
    func testGivenTreeElements_whenTestingExpressionHasEnoughElements_ThenResultIsTrue() {
        
        createExpression(nums: ["5", "4"], opes: ["+"])
        let result = calculator.expressionHasEnoughElement(elements: calculator.elements)
        XCTAssertTrue(result)
    }
    func testGivenLastElementOperande_whenTestingAddOperator_ThenResultIsTrue() {
        createExpression(nums: ["5", "2"], opes: ["+"])
        calculator.addOperator(calculator.expression)
        XCTAssertFalse(calculator.expression == "7")
    }
    func testGivenLastElementOperator_whenTestingAddOperator_ThenResultIsFalse() {
        createExpression(nums: ["4", "7"], opes: ["-", "/"])
        calculator.addOperator(calculator.expression)
        XCTAssertFalse(calculator.expression == "4 - 7 / ")
    }
    func testGivenLastElementIsOperator_whenTestingAddOperator_ThenResultIsFalse() {
        createExpression(nums: ["8"], opes: ["x"])
        calculator.addOperator(calculator.expression)
        XCTAssertFalse(calculator.expression == "8 x")
    }
    func testGivenElementsWithEqual_whenTestingExpressionHasResult_ThenResultIsTrue() {
        createExpression(nums: ["2", "3", "4"], opes: ["+", "4"])
        calculator.addOperator(calculator.expression)
        XCTAssertFalse(calculator.expression == "12")
    }
    func testGivenElementsWithEqual_whenTestingExpressionHasResult_ThenResultIsFalse() {
        createExpression(nums: ["7", "200"], opes: ["-"])
        let result = calculator.expressionHasResult(elements: calculator.elements)
        XCTAssertFalse(result)
    }
    func testGivenLastElementsEqual0_whenTestingdividingIsPossible_ThenResultIsFalse() {
        createExpression(nums: ["78", "4", "0"], opes: ["+", "/"])
        let result = calculator.dividingIsPossible(elements: calculator.elements)
        XCTAssertFalse(result)
    }
    func testGivenLastElementsNonEqualZero_whenTestingdividingIsPossible_ThenResultIstrue() {
        createExpression(nums: ["213", "4", "9"], opes: ["-", "/"])
        let result = calculator.dividingIsPossible(elements: calculator.elements)
        XCTAssertTrue(result)
    }
    func testGivenElementsOnePlusNine_whenTestingEqualFunc_ThenResultShouldBeTen() {
         createExpression(nums: ["1", "9"], opes: ["+"])
               let result = calculator.equalFunc(elements: calculator.elements)
                XCTAssertEqual(result, "10.0")
    }
    func testGivenElementsTreeMinusSeven_whenTestingEqualFunc_ThenResultShouldBeMinusFour() {    createExpression(nums: ["3", "7"], opes: ["-"])
        let result = calculator.equalFunc(elements: calculator.elements)
         XCTAssertEqual(result, "-4.0")
    }
    func testGivenElementsSeventeenDividedByTwo_whenTestingEqualFunc_ThenResultShouldBeEightPointFive() {   createExpression(nums: ["17", "2"], opes: ["/"])
    let result = calculator.equalFunc(elements: calculator.elements)
     XCTAssertEqual(result, "8.5")
       }
    func testGivenElementsNineMutipliedByZero_whenTestingEqualFunc_ThenResultShouldBeZero() {
        createExpression(nums: ["9", "0"], opes: ["x"])
           let result = calculator.equalFunc(elements: calculator.elements)
            XCTAssertEqual(result, "0.0")
        }
    func testGivenElementsTwoMutipliedByThreeDividedByFourPlusSeven_whenTestingEqualFunc_ThenResultShouldBeEightPointFive() {
    createExpression(nums: ["2", "3", "0", "7"], opes: ["x", "/", "+"])
         let result = calculator.equalFunc(elements: calculator.elements)
         XCTAssertEqual(result, nil)
    }
    func testGivenElementsNineMutipliedByTwoDividedByFive_whenTestingEqualFunc_ThenResultShouldBeTreePointSix() {
        createExpression(nums: ["9", "2", "5"], opes: ["x", "/"])
           let result = calculator.equalFunc(elements: calculator.elements)
            XCTAssertEqual(result, "3.6")
      }
    func testGivenElementsNinePlusTwoDividedByTwo_whenTestingEqualFunc_ThenResultShouldBeTen() {
        createExpression(nums: ["9", "2", "2"], opes: ["+", "/"])
           let result = calculator.equalFunc(elements: calculator.elements)
            XCTAssertEqual(result, "10.0")
       }
    func testGivenElementsSevenMinusThreeMultipliedByFour_whenTestingEqualFunc_ThenResultShouldBeMinusfive() {
        createExpression(nums: ["7", "3", "4"], opes: ["-", "x"])
           let result = calculator.equalFunc(elements: calculator.elements)
            XCTAssertEqual(result, "-5.0")
       }
    func testGivenElementsThousandPlustwoDividedByThree_whenTestingEqualFunc_ThenResultShouldBeThreeHundredThirtyFour() {
            createExpression(nums: ["0", "1002", "3"], opes: ["+", "/"])
               let result = calculator.equalFunc(elements: calculator.elements)
                XCTAssertEqual(result, "334.0")
            }
    func testGivenElementsThousandMinusHundredMultipliedBytwoDividedbyFive_whenTestingEqualFunc_ThenResultShouldBeThirty() {
        createExpression(nums: ["1000", "100", "2", "5"], opes: ["-", "x", "/"])
           let result = calculator.equalFunc(elements: calculator.elements)
            XCTAssertEqual(result, "960.0")
        }
    func testGivenElementsThousandMinusThousand_whenTestingEqualFunc_ThenResultShouldBeZero() {
        createExpression(nums: ["1000", "1000"], opes: ["-"])
           let result = calculator.equalFunc(elements: calculator.elements)
            XCTAssertEqual(result, "0.0")
        }
    func testGivenElementsThousandMinusThousandDividedByZero_whenTestingEqualFunc_ThenResultShouldBeNil() {
           createExpression(nums: ["1000", "1000", "0"], opes: ["-", "/"])
              let result = calculator.equalFunc(elements: calculator.elements)
               XCTAssertEqual(result, nil)
           }
    func testGivenElementsHundredDividedBZero_whenTestingEqualFunc_ThenResultShouldBeNil() {
    createExpression(nums: ["Hundred", "0"], opes: ["/"])
       let result = calculator.equalFunc(elements: calculator.elements)
        XCTAssertEqual(result, nil)
    }
    func testGivenElementsHundredMinusPlus_whenTestingEqualFunc_ThenResultShouldBeNil() {
    createExpression(nums: ["0", "5"], opes: ["-", "+"])
       let result = calculator.equalFunc(elements: calculator.elements)
        XCTAssertEqual(result, "-5.0")
    }
    func testGivenElementsFiveMinusSevenPlusTwoMinusTwoPlusNine_whenTestingEqualFunc_ThenResultShouldBeNil() {
    createExpression(nums: ["5", "7", "2", "2", "9"], opes: ["-", "+", "-", "/"])
       let result = calculator.equalFunc(elements: calculator.elements)
        XCTAssertEqual(result, "-0.2222222222222222")
    }
    func testGivenElementsThousandDividedByHundredMinusTen_whenTestingEqualFunc_ThenResultShouldBeZero() {
           createExpression(nums: ["1000", "100", "10"], opes: ["/", "-"])
              let result = calculator.equalFunc(elements: calculator.elements)
               XCTAssertEqual(result, "0.0")
           }
    func  testGivenElemenstFourTwo_WhentestingAddANumber_ThenResultShouldBeFortyTwo() {
        calculator.addANumber("4")
        calculator.addANumber("2")
        let result = calculator.expression
        XCTAssertEqual(result, "42")
    }
    func  testGivenElemenstTwoDivided_WhentestingAddANumber_ThenResultShouldBeFalse() {
            calculator.addANumber("4")
            calculator.addANumber("0")
            let result = calculator.expression
            XCTAssertEqual( result, "40")
        }
    func  testGivenElemenstFourMinus_WhentestingcanAddOperator_ThenResultShouldBeFalse() {
    createExpression(nums: ["4"], opes: ["-"])
    let result = calculator.canAddOperator()
    XCTAssertFalse(result)
    }
    func  testGivenElemenstElevenDividedBy3_WhentestingcanAddOperator_ThenResultShouldBeTrue() {
          createExpression(nums: ["11", "3"], opes: ["/"])
          let result = calculator.canAddOperator()
          XCTAssertTrue(result)
          }
     func  testGivenElemenstFifteenMinusFourDivided_WhentestingcanAddOperator_ThenResultShouldBeFalse() {
        createExpression(nums: ["15", "4"], opes: ["-", "/"])
        let result = calculator.canAddOperator()
        XCTAssertFalse(result)
        }
    
    func testToto() {
        calculator.reset()
        calculator.expression = "99 / A"
        XCTAssertNil(calculator.equalFunc(elements: ["99", "/", "A"]))
    }
}
