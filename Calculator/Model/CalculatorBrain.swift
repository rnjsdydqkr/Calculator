//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 박권용 on 2023/09/21.
//

import Foundation

class CalculatorBrain {
  private var accumulator = 0.0
  private var internalProgram = [Any]()
  
  func setOperand(operand: Double) {
    accumulator = operand
    internalProgram.append(operand)
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
    internalProgram.append(symbol)
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
  
  typealias PropertyList = Any
  var program: PropertyList {
    get {
      return internalProgram
    }
    set {
      clear()
      if let arrayOfOps = newValue as? [Any] {
        for op in arrayOfOps {
          if let operand = op as? Double {
            setOperand(operand: operand)
          } else if let operation = op as? String {
            performOperation(symbol: operation)
          }
        }
      }
    }
  }
  
  func clear() {
    accumulator = 0.0
    pending = nil
    internalProgram.removeAll()
  }
  
  var result: Double {
    get {
      return accumulator
    }
  }
}
