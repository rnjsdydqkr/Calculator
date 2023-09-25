//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 박권용 on 2023/09/21.
//

import Foundation

func multiply(op1: Double, op2: Double) -> Double {
  return op1 * op2
}

class CalculatorBrain {
  private var accumulator = 0.0
  
  func setOperand(operand: Double) {
    accumulator = operand
  }
  
  var operations: Dictionary<String, Operation> = [
    "π": Operation.Constant(.pi),
    "e": Operation.Constant(M_E),
    "√": Operation.UnaryOperation(sqrt),
    "cos": Operation.UnaryOperation(cos),
//    "÷": Operation.BinaryOperation(calculateBinaryOperation),
    "×": Operation.BinaryOperation(multiply),
//    "+": Operation.BinaryOperation(calculateBinaryOperation),
//    "−": Operation.BinaryOperation(calculateBinaryOperation),
    "=": Operation.Equals
  ]
  
  enum Operation {
    case Constant(Double)
    case UnaryOperation((Double) -> Double)
    case BinaryOperation((Double, Double) -> Double)
    case Equals
  }
  
  func performOperation(symbol: String) {
    if let constant = operations[symbol] {
      switch constant {
      case .Constant(let value): accumulator = value
      case .UnaryOperation(let function): accumulator = function(accumulator)
      case .BinaryOperation(let function): pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
      case .Equals:
        if pending != nil {
          accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
          pending = nil
        }
      }
    }
  }
  
  private var pending: PendingBinaryOperationInfo?
  
  struct PendingBinaryOperationInfo {
    var binaryFunction: (Double, Double) -> Double
    var firstOperand: Double
  }
  
  var result: Double {
    get {
      return accumulator
    }
  }
}
