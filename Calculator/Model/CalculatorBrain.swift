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
  
  func performOperation(symbol: String) {
    switch symbol {
    case "π": accumulator = .pi
    case "√": accumulator = sqrt(accumulator)
    default: break
    }
  }
  
  var result: Double {
    get {
      return accumulator
    }
  }
}
