//
//  Day3Solution.swift
//  Basic
//
//  Created by Blaine Oelkers on 12/2/19.
//

import Foundation
import Files

public struct Point: Equatable, Hashable {
    var x: Int
    var y: Int
}

public class Day3Solution: Day {
    
    public func run1() {
        let stringInput = try! File(path: "Day3Input").readAsString()
        let splitInput = stringInput.split(separator: "\n")
        let wire1 = splitInput[0].split(separator: ",").map({ String($0) })
        let wire1Points = self.runPoints(input: wire1)
        
        let wire2 = splitInput[1].split(separator: ",").map({ String($0) })
        let wire2Points = self.runPoints(input: wire2)
        
        let commonPoints = Array(Set(wire1Points).intersection(Set(wire2Points)))
        let distances = commonPoints.map({ abs($0.x) + abs($0.y) })
        print(distances.min() ?? -1)
    }
    
    public func run2() {
        let stringInput = try! File(path: "Day3Input").readAsString()
        let splitInput = stringInput.split(separator: "\n")
        let wire1 = splitInput[0].split(separator: ",").map({ String($0) })
        let wire1Points = self.runPoints(input: wire1)
        
        let wire2 = splitInput[1].split(separator: ",").map({ String($0) })
        let wire2Points = self.runPoints(input: wire2)
        
        let commonPoints = Array(Set(wire1Points).intersection(Set(wire2Points)))
        var pointsToNum = [Point: Int]()
        for intersectionPoint in commonPoints {
            let steps1 = self.runPoints(input: wire1, stoppingAt: intersectionPoint)
            let steps2 = self.runPoints(input: wire2, stoppingAt: intersectionPoint)
            pointsToNum[intersectionPoint] = steps1 + steps2
        }
        let minimum = pointsToNum.min { (one, two) -> Bool in
            one.value < two.value
        }
        print(minimum!.value)
    }
    
    private func moveUp(point: Point) -> Point {
        return Point(x: point.x, y: point.y + 1)
    }
    
    private func moveLeft(point: Point) -> Point {
        return Point(x: point.x - 1, y: point.y)
    }
    
    private func moveRight(point: Point) -> Point {
        return Point(x: point.x + 1, y: point.y)
    }
    
    private func moveDown(point: Point) -> Point {
        return Point(x: point.x, y: point.y - 1)
    }
    
    private func runPoints(input: [String]) -> [Point] {
        var points = [Point]()
        var currentPoint = Point(x: 0, y: 0)
        for stringPoint in input {
            let count = Int(stringPoint[stringPoint.index(after: stringPoint.startIndex)..<stringPoint.endIndex])!
            let direction = stringPoint[stringPoint.startIndex]
            switch direction {
            case "R":
                for _ in 0..<count {
                    currentPoint = self.moveRight(point: currentPoint)
                    points.append(currentPoint)
                }
            case "U":
                for _ in 0..<count {
                    currentPoint = self.moveUp(point: currentPoint)
                    points.append(currentPoint)
                }
            case "L":
                for _ in 0..<count {
                    currentPoint = self.moveLeft(point: currentPoint)
                    points.append(currentPoint)
                }
            case "D":
                for _ in 0..<count {
                    currentPoint = self.moveDown(point: currentPoint)
                    points.append(currentPoint)
                }
            default:
                print("Oh No")
            }
        }
        return points
    }
    
    private func runPoints(input: [String], stoppingAt intersectionPoint: Point?) -> Int {
        var steps = 0
        var timeToStop = false
        
        var currentPoint = Point(x: 0, y: 0)
        for stringPoint in input {
            let count = Int(stringPoint[stringPoint.index(after: stringPoint.startIndex)..<stringPoint.endIndex])!
            let direction = stringPoint[stringPoint.startIndex]
            switch direction {
            case "R":
                for _ in 0..<count {
                    currentPoint = self.moveRight(point: currentPoint)
                    steps += 1
                    if currentPoint == intersectionPoint {
                        timeToStop = true
                        break
                    }
                }
            case "U":
                for _ in 0..<count {
                    currentPoint = self.moveUp(point: currentPoint)
                    steps += 1
                    if currentPoint == intersectionPoint {
                        timeToStop = true
                        break
                    }
                }
            case "L":
                for _ in 0..<count {
                    currentPoint = self.moveLeft(point: currentPoint)
                    steps += 1
                    if currentPoint == intersectionPoint {
                        timeToStop = true
                        break
                    }
                }
            case "D":
                for _ in 0..<count {
                    currentPoint = self.moveDown(point: currentPoint)
                    steps += 1
                    if currentPoint == intersectionPoint {
                        timeToStop = true
                        break
                    }
                }
            default:
                print("Oh No")
            }
            if timeToStop {
                break
            }
        }
        return steps
    }
}
