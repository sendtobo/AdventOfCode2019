//
//  Day5Solution.swift
//  Files
//
//  Created by Blaine Oelkers on 12/4/19.
//

import Foundation

public struct Day5Solution: Day {
    public init() { }
    
    public func run1() -> String {
        return "\(self.runSimulation(input: 1))"
    }
    
    public func run2() -> String {
        return "\(self.runSimulation(input: 5))"
    }
    
    private func runSimulation(input: Int) -> Int {
        var codes = stringInput.split(separator: ",").map({ Int(String($0))! })
        var input = input
        var pointer = 0
        while pointer < codes.count - 1 {
            let opCode = self.generateCode(codes[pointer])
            switch opCode.code {
            case .input:
                pointer += 1
                let param1 = codes[pointer]
                codes[param1] = input
                pointer += 1
            case .output:
                pointer += 1
                let param1 = codes[pointer]
                input = opCode.modes[0].value(param1, in: codes)
                pointer += 1
            case .add:
                pointer += 1
                let param1 = codes[pointer]
                pointer += 1
                let param2 = codes[pointer]
                pointer += 1
                let param3 = codes[pointer]
                let value = opCode.modes[0].value(param1, in: codes) + opCode.modes[1].value(param2, in: codes)
                codes[param3] = value
                pointer += 1
            case .multiply:
                pointer += 1
                let param1 = codes[pointer]
                pointer += 1
                let param2 = codes[pointer]
                pointer += 1
                let param3 = codes[pointer]
                let value = opCode.modes[0].value(param1, in: codes) * opCode.modes[1].value(param2, in: codes)
                codes[param3] = value
                pointer += 1
            case .jumpIfTrue:
                pointer += 1
                let param1 = codes[pointer]
                pointer += 1
                let param2 = codes[pointer]
                if opCode.modes[0].value(param1, in: codes) != 0 {
                    pointer = opCode.modes[1].value(param2, in: codes) //might need to evaluate
                } else {
                    pointer += 1
                }
            case .jumpIfFalse:
                pointer += 1
                let param1 = codes[pointer]
                pointer += 1
                let param2 = codes[pointer]
                if opCode.modes[0].value(param1, in: codes) == 0 {
                    pointer = opCode.modes[1].value(param2, in: codes) //might need to evaluate
                } else {
                    pointer += 1
                }
            case .lessThan:
                pointer += 1
                let param1 = codes[pointer]
                pointer += 1
                let param2 = codes[pointer]
                pointer += 1
                let param3 = codes[pointer]
                let value = opCode.modes[0].value(param1, in: codes) < opCode.modes[1].value(param2, in: codes) ? 1 : 0
                codes[param3] = value // might need to evaluate
                pointer += 1
            case .equals:
                pointer += 1
                let param1 = codes[pointer]
                pointer += 1
                let param2 = codes[pointer]
                pointer += 1
                let param3 = codes[pointer]
                let value = opCode.modes[0].value(param1, in: codes) == opCode.modes[1].value(param2, in: codes) ? 1 : 0
                codes[param3] = value // might need to evaluate
                pointer += 1
            case .end:
                return input
            }
        }
        return input
    }
    
    private func generateCode(_ int: Int) -> OpCode {
        var string = String(int)
        if string.count == 1 {
            string = "0\(string)"
        }
        let intCode = Int(String(string.suffix(2)))!
        string.removeLast(2)
        let code = OpCode.Code.init(intCode)!
        var prefix = String(string.prefix(code.parameters))
        while prefix.count < code.parameters {
            prefix = "0\(prefix)"
        }
        var modes = [OpCode.Mode]()
        while prefix != "" {
            let modeInt = Int(String(prefix.suffix(1)))!
            prefix.removeLast()
            let mode = OpCode.Mode(modeInt)!
            modes.append(mode)
        }
        return OpCode(code: code, modes: modes)
    }
}

private var stringInput = "3,225,1,225,6,6,1100,1,238,225,104,0,2,218,57,224,101,-3828,224,224,4,224,102,8,223,223,1001,224,2,224,1,223,224,223,1102,26,25,224,1001,224,-650,224,4,224,1002,223,8,223,101,7,224,224,1,223,224,223,1102,44,37,225,1102,51,26,225,1102,70,94,225,1002,188,7,224,1001,224,-70,224,4,224,1002,223,8,223,1001,224,1,224,1,223,224,223,1101,86,70,225,1101,80,25,224,101,-105,224,224,4,224,102,8,223,223,101,1,224,224,1,224,223,223,101,6,91,224,1001,224,-92,224,4,224,102,8,223,223,101,6,224,224,1,224,223,223,1102,61,60,225,1001,139,81,224,101,-142,224,224,4,224,102,8,223,223,101,1,224,224,1,223,224,223,102,40,65,224,1001,224,-2800,224,4,224,1002,223,8,223,1001,224,3,224,1,224,223,223,1102,72,10,225,1101,71,21,225,1,62,192,224,1001,224,-47,224,4,224,1002,223,8,223,101,7,224,224,1,224,223,223,1101,76,87,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,108,226,677,224,102,2,223,223,1005,224,329,1001,223,1,223,1107,677,226,224,102,2,223,223,1006,224,344,1001,223,1,223,7,226,677,224,1002,223,2,223,1005,224,359,101,1,223,223,1007,226,226,224,102,2,223,223,1005,224,374,101,1,223,223,108,677,677,224,102,2,223,223,1006,224,389,1001,223,1,223,107,677,226,224,102,2,223,223,1006,224,404,101,1,223,223,1108,677,226,224,102,2,223,223,1006,224,419,1001,223,1,223,1107,677,677,224,1002,223,2,223,1006,224,434,101,1,223,223,1007,677,677,224,102,2,223,223,1006,224,449,1001,223,1,223,1108,226,677,224,1002,223,2,223,1006,224,464,101,1,223,223,7,677,226,224,102,2,223,223,1006,224,479,101,1,223,223,1008,226,226,224,102,2,223,223,1006,224,494,101,1,223,223,1008,226,677,224,1002,223,2,223,1005,224,509,1001,223,1,223,1007,677,226,224,102,2,223,223,1005,224,524,1001,223,1,223,8,226,226,224,102,2,223,223,1006,224,539,101,1,223,223,1108,226,226,224,1002,223,2,223,1006,224,554,101,1,223,223,107,226,226,224,1002,223,2,223,1005,224,569,1001,223,1,223,7,226,226,224,102,2,223,223,1005,224,584,101,1,223,223,1008,677,677,224,1002,223,2,223,1006,224,599,1001,223,1,223,8,226,677,224,1002,223,2,223,1006,224,614,1001,223,1,223,108,226,226,224,1002,223,2,223,1006,224,629,101,1,223,223,107,677,677,224,102,2,223,223,1005,224,644,1001,223,1,223,8,677,226,224,1002,223,2,223,1005,224,659,1001,223,1,223,1107,226,677,224,102,2,223,223,1005,224,674,1001,223,1,223,4,223,99,226"
