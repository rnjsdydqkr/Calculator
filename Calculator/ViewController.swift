//
//  ViewController.swift
//  Calculator
//
//  Created by 박권용 on 2022/02/03.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet private var display: UILabel!
  
  private var userIsInTheMiddleOfTyping: Bool = false
  
  private var brain = CalculatorBrain()
  
  private var displayValue: Double {
    get {
      return Double(display.text!)!
    }
    set {
      display.text = String(newValue)
    }
  }
  
  @IBAction private func touchDigit(_ sender: UIButton) {
    let digit = sender.currentTitle!
    if userIsInTheMiddleOfTyping {
      let textCurrentlyInDisplay = display.text!
      display.text = textCurrentlyInDisplay + digit
    } else {
      display.text = digit
    }
    userIsInTheMiddleOfTyping = true
  }
  
  var savedProgram: CalculatorBrain.PropertyList?
  
  @IBAction func save() {
    savedProgram = brain.program
  }
  
  @IBAction func restore() {
    if savedProgram != nil {
      brain.program = savedProgram!
      displayValue = brain.result
    }
  }
  
  
  @IBAction private func performOperation(_ sender: UIButton) {
    if userIsInTheMiddleOfTyping {
      brain.setOperand(operand: displayValue)
      userIsInTheMiddleOfTyping = false
    }
    if let mathematicalSymbol = sender.currentTitle {
      brain.performOperation(symbol: mathematicalSymbol)
    }
    displayValue = brain.result
  }
  
}

