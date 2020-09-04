//
//  CountOnMeCalculator.swift
//  Calculette-version1
//
//  Created by macmini-Armelle on 10/08/2020.
//  Copyright © 2020 armellelecerf. All rights reserved.
//

import Foundation


class CountOnMeCalculator {
    
    enum Error: Swift.Error {
        case cantAddOperator
    }
    // MARK: - properties
    var expression = ""
    var elements: [String] { return expression.split(separator: " ").map {"\($0)"}}
    var hasAResult = false

    // MARK: - function RESET  //display a void screen
    func reset() {expression = " "}
    // MARK: - other functions
    func expressionIsCorrect(elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x" &&
            elements.first != "+" && elements.last != "-" && elements.first != "/" && elements.first != "x"
    }
    func expressionHasEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }
    func canAddOperator() -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    }
    func addOperator(_ ope: String) {
//    func addOperator(_ ope: String) throws {
//        guard canAddOperator() else {
//            throw Error.cantAddOperator
//        }
        expression.append(" \(ope) ")
    }
    func addANumber(_ number: String) {
        expression += number
        print(elements)
    }
    func expressionHasResult(elements: [String]) -> Bool {
        return elements.contains("=")
    }

    func dividingIsPossible( elements: [String]) -> Bool {if elements[elements.count-1] == "0"
        && elements[elements.count-2] == "/" { return false }
        return true
    }
    // MARK: - performes calcul
    @objc func equalFunc(elements: [String]) -> String? {
        var operationsToReduce: [String] = elements
        //        if the first index is a subtraction operator than it's a negative number so it
        //        merges the first and the second index
        if operationsToReduce[0] == "-" {
            operationsToReduce[0] = "\(operationsToReduce[0])\(operationsToReduce[1])"
            operationsToReduce.remove(at: 1)
        }
        while operationsToReduce.contains("x") || operationsToReduce.contains("/") {
            if let result = calculatePriorities(operationsToReduce: operationsToReduce) {
                operationsToReduce = result
            } else {
                return nil
            }
        }
        while expressionHasEnoughElement(elements: operationsToReduce) {
            if let result = calculateAdditionAndSubtraction(operationsToReduce: operationsToReduce) {
                operationsToReduce = result
            } else {
                return nil
            }
        }
        return operationsToReduce.first
    }
    // MARK: - calculate the addition and subtraction
    private func calculateAdditionAndSubtraction(operationsToReduce: [String]) -> [String]? {
        var additionAndSubtraction: [String] = operationsToReduce
        guard let left: Double = Double(additionAndSubtraction[0]) else {
            return nil
        }
        let operand = additionAndSubtraction[1]
        guard let right: Double = Double(additionAndSubtraction[2]) else {
            return nil
        }
        let result: Double
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        default: return nil
        }
        additionAndSubtraction = Array(additionAndSubtraction.dropFirst(3))
        additionAndSubtraction.insert("\(result)", at: 0)
        return additionAndSubtraction
    }
    // MARK: - calculate the priorities when the calcul contains a division and\or a multiplication
    private func calculatePriorities(operationsToReduce: [String]) -> [String]? {
        var prioritiesCalculated: [String] = operationsToReduce
        if let index = prioritiesCalculated.firstIndex(where: { $0 == "x" || $0 == "/"}) {
            guard let left: Double = Double(prioritiesCalculated[index - 1]) else {
                return nil
            }
            let operand = prioritiesCalculated[index]
            guard let right: Double = Double(prioritiesCalculated[index + 1]) else {
                return nil
            }
            let result: Double
            switch operand {
            case "x":
                result = left * right
            case "/":
                if right == 0 {
                    return nil
                } else {
                    result = left / right
                }
            default:
                return nil
            }
            prioritiesCalculated[index - 1] = "\(result)"
            prioritiesCalculated.remove(at: index)
            prioritiesCalculated.remove(at: index)
        }
        return prioritiesCalculated
    }
}
