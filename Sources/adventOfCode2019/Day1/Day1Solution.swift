//
//  Day1Solution.swift
//  Basic
//
//  Created by Blaine Oelkers on 12/1/19.
//

import Foundation
import Files

public struct Day1Solution: Day {
    public init() { }
    public func run1() -> String {
        let stringInput = try! File(path: "Day1Input.txt").readAsString()
        let splitInput = stringInput.split(separator: "\n")
        var total = 0
        for input in splitInput {
            guard let newFuel = Int(String(input)) else { continue }
            let fuel = (newFuel / 3) - 2
            total += fuel
        }
        return "\(total)"
    }
    
    public func run2() -> String {
        let stringInput = try! File(path: "Day1Input.txt").readAsString()
        let splitInput = stringInput.split(separator: "\n")
        var total = 0
        for input in splitInput {
            guard let newFuel = Int(String(input)) else { continue }
            let fuel = self.calculateFuel(newFuel)
            total += fuel
        }
        return "\(total)"
    }
    
    private func calculateFuel(_ input: Int) -> Int {
        var fuel = (input / 3) - 2
        fuel = fuel > 0 ? fuel : 0
        if fuel > 0 {
            fuel += self.calculateFuel(fuel)
        }
        return fuel
    }
}
