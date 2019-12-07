//
//  Day7Solution.swift
//  AdventOfCode2019
//
//  Created by Blaine Oelkers on 12/6/19.
//

import Foundation

public struct Day7Solution: Day {
    private let stringInput = "3,8,1001,8,10,8,105,1,0,0,21,38,59,84,93,110,191,272,353,434,99999,3,9,101,5,9,9,1002,9,5,9,101,5,9,9,4,9,99,3,9,1001,9,3,9,1002,9,2,9,101,4,9,9,1002,9,4,9,4,9,99,3,9,102,5,9,9,1001,9,4,9,1002,9,2,9,1001,9,5,9,102,4,9,9,4,9,99,3,9,1002,9,2,9,4,9,99,3,9,1002,9,5,9,101,4,9,9,102,2,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,99"
    
    public init() { }
    
    public func run1() -> String {
        var max = 0
        let inputs = permutations([0,2,1,3,4])
        for signals in inputs {
            let output = self.generateOutput2(signals)
            if max < output {
                max = output
            }
        }
        return "\(max)"
    }
    
    public func run2() -> String {
        var max = 0
        let inputs = permutations([5,6,7,8,9])
        for signals in inputs {
            let output = self.generateOutput2(signals, shouldPauseAtOutput: true)
            if max < output {
                max = output
            }
        }
        return "\(max)"
    }
    
    private func validInput(_ input: [Int]) -> Bool {
        return Set(input).count == input.count
    }
    
    private func generateOutput2(_ signals: [Int], shouldPauseAtOutput: Bool = false) -> Int {
        var amplifierOutput = 0
        var halted = false
        
        let computerA = Computer(computer: self.stringInput,
                                 phaseSetting: signals[0],
                                 input: 0)
        let computerB = Computer(computer: self.stringInput,
                                 phaseSetting: signals[1])
        let computerC = Computer(computer: self.stringInput,
                                 phaseSetting: signals[2])
        let computerD = Computer(computer: self.stringInput,
                                 phaseSetting: signals[3])
        let computerE = Computer(computer: self.stringInput,
                                 phaseSetting: signals[4])
        
        computerA.outputFound = { code in
            computerB.addInput(code)
        }
        computerA.haltFound = {
            halted = true
        }
        
        computerB.outputFound = { code in
            computerC.addInput(code)
        }
        computerB.haltFound = {
            halted = true
        }
        
        computerC.outputFound = { code in
            computerD.addInput(code)
        }
        computerC.haltFound = {
            halted = true
        }
        
        computerD.outputFound = { code in
            computerE.addInput(code)
        }
        computerD.haltFound = {
            halted = true
        }
        
        computerE.outputFound = { code in
            amplifierOutput = code
            computerA.addInput(code)
        }
        
        computerE.haltFound = {
            halted = true
        }
        
        while(!halted) {
            computerA.runSimulation(shouldPauseAtOutput: shouldPauseAtOutput)
            computerB.runSimulation(shouldPauseAtOutput: shouldPauseAtOutput)
            computerC.runSimulation(shouldPauseAtOutput: shouldPauseAtOutput)
            computerD.runSimulation(shouldPauseAtOutput: shouldPauseAtOutput)
            computerE.runSimulation(shouldPauseAtOutput: shouldPauseAtOutput)
        }
        return amplifierOutput
    }
}

extension Array {
    func decompose() -> (Iterator.Element, [Iterator.Element])? {
        guard let x = first else { return nil }
        return (x, Array(self[1..<count]))
    }
}

func between<T>(_ x: T, _ ys: [T]) -> [[T]] {
    guard let (head, tail) = ys.decompose() else { return [[x]] }
    return [[x] + ys] + between(x, tail).map { [head] + $0 }
}

func permutations<T>(_ xs: [T]) -> [[T]] {
    guard let (head, tail) = xs.decompose() else { return [[]] }
    return permutations(tail).flatMap { between(head, $0) }
}
