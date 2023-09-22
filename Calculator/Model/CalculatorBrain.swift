//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 박권용 on 2023/09/21.
//

import Foundation

class CalculatorBrain {
  private var accumulator = 0.0
  
  func setOperand(operand: Double) {
    accumulator = operand
  }
  
  var operations: Dictionary<String, Operations> = [
    "π": Operations.Constant(.pi),
    "e": Operations.Constant(M_E),
    "√": Operations.UnaryOperation, // sqrt,
    "cos": Operations.UnaryOperation // cos
  ]
  
  enum Operations {
    case Constant(Double)
    case UnaryOperation
    case BinaryOperation
    case Equals
  }
  
  func performOperation(symbol: String) {
    if let constant = operations[symbol] {
      switch constant {
      case .Constant(let value): accumulator = value
      case .UnaryOperation: break
      case .BinaryOperation: break
      case .Equals: break
      }
    }
  }
  
  var result: Double {
    get {
      return accumulator
    }
  }
}
