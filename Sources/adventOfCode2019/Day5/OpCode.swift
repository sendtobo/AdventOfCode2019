//
//  OpCode.swift
//  adventOfCode2019
//
//  Created by Blaine Oelkers on 12/6/19.
//

import Foundation

public struct OpCode {
    public enum Code {
        case end
        case add
        case multiply
        case input
        case output
        case jumpIfTrue
        case jumpIfFalse
        case lessThan
        case equals
        
        public init?(_ code: Int) {
            switch code {
            case 99:
                self = .end
            case 1:
                self = .add
            case 2:
                self = .multiply
            case 3:
                self = .input
            case 4:
                self = .output
            case 5:
                self = .jumpIfTrue
            case 6:
                self = .jumpIfFalse
            case 7:
                self = .lessThan
            case 8:
                self = .equals
            default:
                return nil
            }
        }
        
        var parameters: Int {
            switch self {
            case .end:
                return 0
            case .input, .output:
                return 1
            case .jumpIfTrue, .jumpIfFalse:
                return 2
            case .add, .multiply, .lessThan, .equals:
                return 3
            }
        }
    }
    
    public enum Mode {
        case position
        case immediate
        
        public init?(_ code: Int) {
            switch code {
            case 0:
                self = .position
            case 1:
                self = .immediate
            default:
                return nil
            }
        }
        
        public func value(_ value: Int, in codes: [Int]) -> Int {
            switch self {
            case .immediate:
                return value
            case .position:
                return codes[value]
            }
        }
    }
    
    public var code: Code
    public var modes = [Mode]()
}
