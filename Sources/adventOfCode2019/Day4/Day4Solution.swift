//
//  Day4Solution.swift
//  Basic
//
//  Created by Blaine Oelkers on 12/2/19.
//

import Foundation

public struct Day4Solution: Day {
    private let range = 240920...789857

    public init() { }
    public func run1() -> String {
        return self.findNumbers(in: self.range) { number in
            return String("\(number)".sorted()) == "\(number)" &&
            self.containsDuplicate("\(number)")
        }
    }
    
    public func run2() -> String {
        return self.findNumbers(in: self.range) { number in
            return String("\(number)".sorted()) == "\(number)" &&
            self.containsDuplicate("\(number)") &&
            self.twoOfANumber("\(number)")
        }
    }
    
    private func findNumbers(in range: ClosedRange<Int>, satisfying: (String) -> Bool) -> String {
        var count = 0
        for number in range {
            if satisfying("\(number)") {
                count += 1
            }
        }
        return "\(count)"
    }
    
    private func containsDuplicate(_ number: String) -> Bool {
        return Set(number).count != number.count
    }
    
    private func twoOfANumber(_ number: String) -> Bool {
        for char in number {
            if number.components(separatedBy: String(char)).count - 1 == 2 {
                return true
            }
        }
        return false
    }
}
