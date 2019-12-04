//
//  Day2Solution.swift
//  adventOfCode2019
//
//  Created by Blaine Oelkers on 12/1/19.
//

import Foundation
import Files

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
        let stringInput = try! File(path: "Day2Input.txt").readAsString()
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
