//
//  CalculatorBrain.swift
//  Calculator
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    private var internalProgram = [Op]()
    
    func setOperand(_ operand: Double) {
        accumulator = operand
        internalProgram.append(.operand(operand))
    }
    
    var operations =  [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "±" : Operation.UnaryOperation({-$0}),
        "√" : Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "×": Operation.BinaryOperation({$0 * $1}),
        "÷": Operation.BinaryOperation({$0 / $1}),
        "+": Operation.BinaryOperation({$0 + $1}),
        "-": Operation.BinaryOperation({$0 - $1}),
        "=": Operation.Equals
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    enum Op {
        case operand(Double)
        case operation(String)
    }
    
    func performOperation(_ symbol: String) {
        internalProgram.append(.operation(symbol))
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let val):
                accumulator = val
            case .UnaryOperation(let f):
                accumulator = f(accumulator)
            case .BinaryOperation(let f):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: f, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation(){
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
        
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    typealias PropertyList = [Op]
    
    var program: PropertyList {
        get {
            return internalProgram
        }
        set {
            clear()
            for op in newValue {
                switch op{
                case .operand(let operand):
                    setOperand(operand)
                case .operation(let operation):
                    performOperation(operation)
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
