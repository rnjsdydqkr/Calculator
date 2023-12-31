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
  
  private var operations: Dictionary<String, Operation> = [
    "π" : .Constant(.pi),
    "e" : .Constant(M_E),
    "±" : .UnaryOperation({ -$0 }),
    "√" : .UnaryOperation(sqrt),
    "cos" : .UnaryOperation(cos),
    "÷" : .BinaryOperation({ $0 / $1 }),
    "×" : .BinaryOperation({ $0 * $1 }),
    "+" : .BinaryOperation({ $0 + $1 }),
    "−" : .BinaryOperation({ $0 - $1 }),
    "=" : .Equals
  ]
  
  private enum Operation {
    case Constant(Double)
    case UnaryOperation((Double) -> Double)
    case BinaryOperation((Double, Double) -> Double)
    case Equals
  }
  
  func performOperation(symbol: String) {
    if let constant = operations[symbol] {
      switch constant {
      case .Constant(let value):
        accumulator = value
      case .UnaryOperation(let function):
        accumulator = function(accumulator)
      case .BinaryOperation(let function):
        executePendingBinaryOperation()
        pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
      case .Equals:
        executePendingBinaryOperation()
      }
    }
  }
  
  private func executePendingBinaryOperation() {
    if let pending = self.pending {
      accumulator = pending.binaryFunction(pending.firstOperand, accumulator)
      self.pending = nil
    }
  }
  
  private var pending: PendingBinaryOperationInfo?
  
  private struct PendingBinaryOperationInfo {
    var binaryFunction: (Double, Double) -> Double
    var firstOperand: Double
  }
  
  var result: Double {
    get {
      return accumulator
    }
  }
}
