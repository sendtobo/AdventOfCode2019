//
//  Day2Solution.swift
//  adventOfCode2019
//
//  Created by Blaine Oelkers on 12/1/19.
//

import Foundation
import Files

public class Day2Solution: Day {
    public func run1() {
        print(self.runSimulation(noun: 12, verb: 2))
    }
    
    public func run2() {
        for noun in 0...99 {
            for verb in 0...99 {
                if self.runSimulation(noun: noun, verb: verb) == 19690720 {
                    print(noun, verb)
                    return
                }
            }
        }
    }
    
    private func runSimulation(noun: Int, verb: Int) -> Int {
        let stringInput = try! File(path: "Day2Input").readAsString()
        var input = stringInput.split(separator: ",").map({ Int(String($0))! })
        input[1] = noun
        input[2] = verb
        for pointer in (0...input.count).filter({ $0 % 4 == 0 }) {
            if input[pointer] == 99 {
                return(input[0])
            }
            let value1 = input[input[pointer + 1]]
            let value2 = input[input[pointer + 2]]
            let position3 = input[pointer + 3]
            if input[pointer] == 1 {
                input[position3] = value1 + value2
            } else if input[pointer] == 2 {
                input[position3] = value1 * value2
            } else {
                print("Something is wrong, op code: \(input[pointer])")
            }
        }
        return -1
    }
}
