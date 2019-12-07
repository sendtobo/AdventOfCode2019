//
//  Computer.swift
//  AdventOfCode2019
//
//  Created by Blaine Oelkers on 12/6/19.
//

import Foundation

public class Computer {
    let phaseSetting: Int
    var codes: [Int]
    var inputs = [Int]()
    
    var outputFound: ((Int) -> ())?
    var haltFound: (() -> ())?
    
    var needsToStop = false
    
    init(computer: String, phaseSetting: Int , input: Int? = nil) {
        self.phaseSetting = phaseSetting
        self.codes = computer.split(separator: ",").map({ Int(String($0))! })
        if let input = input {
            inputs.append(input)
        }
    }
    
    func addInput(_ input: Int) {
        self.inputs.append(input)
    }
    
    func someoneElseHalted() {
        self.needsToStop = true
    }
    
    var pointer = 0
    var opCode: OpCode?
    
    var usedInput1 = false
    
    func runSimulation(shouldPauseAtOutput: Bool) {
        while pointer < self.codes.count - 1 {
            if self.needsToStop { return }
            opCode = self.generateCode(self.codes[pointer])
            switch opCode!.code {
            case .input:
                pointer += 1
                let inputParam1 = self.codes[pointer]
                pointer += 1
                if !usedInput1 {
                    self.codes[inputParam1] = self.phaseSetting
                    usedInput1 = true
                } else {
                    self.codes[inputParam1] = self.inputs.first!
                    self.inputs.removeFirst(1)
                }
            case .output:
                pointer += 1
                let param1 = self.codes[pointer]
                self.outputFound?(opCode!.modes[0].value(param1, in: self.codes))
                pointer += 1
                if shouldPauseAtOutput {
                    return                    
                }
            case .add:
                pointer += 1
                let param1 = self.codes[pointer]
                pointer += 1
                let param2 = self.codes[pointer]
                pointer += 1
                let param3 = self.codes[pointer]
                let value = opCode!.modes[0].value(param1, in: self.codes) + opCode!.modes[1].value(param2, in: self.codes)
                self.codes[param3] = value
                pointer += 1
            case .multiply:
                pointer += 1
                let param1 = self.codes[pointer]
                pointer += 1
                let param2 = self.codes[pointer]
                pointer += 1
                let param3 = self.codes[pointer]
                let value = opCode!.modes[0].value(param1, in: self.codes) * opCode!.modes[1].value(param2, in: self.codes)
                self.codes[param3] = value
                pointer += 1
            case .jumpIfTrue:
                pointer += 1
                let param1 = self.codes[pointer]
                pointer += 1
                let param2 = self.codes[pointer]
                if opCode!.modes[0].value(param1, in: self.codes) != 0 {
                    pointer = opCode!.modes[1].value(param2, in: self.codes) //might need to evaluate
                } else {
                    pointer += 1
                }
            case .jumpIfFalse:
                pointer += 1
                let param1 = self.codes[pointer]
                pointer += 1
                let param2 = self.codes[pointer]
                if opCode!.modes[0].value(param1, in: self.codes) == 0 {
                    pointer = opCode!.modes[1].value(param2, in: self.codes) //might need to evaluate
                } else {
                    pointer += 1
                }
            case .lessThan:
                pointer += 1
                let param1 = self.codes[pointer]
                pointer += 1
                let param2 = self.codes[pointer]
                pointer += 1
                let param3 = self.codes[pointer]
                let value = opCode!.modes[0].value(param1, in: self.codes) < opCode!.modes[1].value(param2, in: self.codes) ? 1 : 0
                self.codes[param3] = value // might need to evaluate
                pointer += 1
            case .equals:
                pointer += 1
                let param1 = self.codes[pointer]
                pointer += 1
                let param2 = self.codes[pointer]
                pointer += 1
                let param3 = self.codes[pointer]
                let value = opCode!.modes[0].value(param1, in: self.codes) == opCode!.modes[1].value(param2, in: self.codes) ? 1 : 0
                self.codes[param3] = value // might need to evaluate
                pointer += 1
            case .end:
                self.haltFound?()
                return
            }
        }
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
