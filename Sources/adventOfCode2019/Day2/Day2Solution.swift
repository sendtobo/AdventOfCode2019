//
//  Day2Solution.swift
//  adventOfCode2019
//
//  Created by Blaine Oelkers on 12/1/19.
//

import Foundation

public struct Day2Solution: Day {
    private let endCode = 99
    private let addCode = 1
    private let multiplyCode = 2
    
    public init() { }
    
    public func run1() -> String {
        return "\(self.runSimulation(noun: 12, verb: 2))"
    }
    
    public func run2() -> String {
        let validRange = 0...99
        let seed = 19690720
        for noun in validRange {
            for verb in validRange {
                if self.runSimulation(noun: noun, verb: verb) == seed {
                    return "\((100 * noun) + verb)"
                }
            }
        }
        return ""
    }
    
    private func runSimulation(noun: Int, verb: Int) -> Int {
        let stringInput = input
        var input = stringInput.split(separator: ",").map({ Int(String($0))! })
        input[1] = noun
        input[2] = verb
        for pointer in (0...input.count).filter({ $0 % 4 == 0 }) {
            if input[pointer] == self.endCode {
                return(input[0])
            }
            let value1 = input[input[pointer + 1]]
            let value2 = input[input[pointer + 2]]
            let position3 = input[pointer + 3]
            if input[pointer] == self.addCode {
                input[position3] = value1 + value2
            } else if input[pointer] == self.multiplyCode {
                input[position3] = value1 * value2
            } else {
                print("Something is wrong, unknown op code: \(input[pointer])")
            }
        }
        return -1
    }
}

private var input = """
1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,13,1,19,1,19,6,23,1,23,6,27,1,13,27,31,2,13,31,35,1,5,35,39,2,39,13,43,1,10,43,47,2,13,47,51,1,6,51,55,2,55,13,59,1,59,10,63,1,63,10,67,2,10,67,71,1,6,71,75,1,10,75,79,1,79,9,83,2,83,6,87,2,87,9,91,1,5,91,95,1,6,95,99,1,99,9,103,2,10,103,107,1,107,6,111,2,9,111,115,1,5,115,119,1,10,119,123,1,2,123,127,1,127,6,0,99,2,14,0,0
"""
