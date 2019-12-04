//
//  Day1Solution.swift
//  Basic
//
//  Created by Blaine Oelkers on 12/1/19.
//

import Foundation
import Files

public class Day1Solution: Day {
    public func run1() {
        let stringInput = try! File(path: "Day1Input").readAsString()
        let splitInput = stringInput.split(separator: "\n")
        var total = 0
        for input in splitInput {
            let fuel = (Int(String(input))! / 3) - 2
            total += fuel
        }
        print(total)
    }
    
    public func run2() {
        let stringInput = try! File(path: "Day1Input").readAsString()
        let splitInput = stringInput.split(separator: "\n")
        var total = 0
        for input in splitInput {
            let fuel = self.calculateFuel(Int(String(input))!)
            total += fuel
        }
        print(total)
    }
    
    private func calculateFuel(_ input: Int) -> Int {
        var fuel = (input / 3) - 2
        fuel = fuel > 0 ? fuel : 0
        if fuel > 0 {
            fuel += calculateFuel(fuel)
        }
        return fuel
    }
}
