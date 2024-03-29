//
//  Day1Solution.swift
//  Basic
//
//  Created by Blaine Oelkers on 12/1/19.
//

import Foundation

public struct Day1Solution: Day {
    public init() { }
    public func run1() -> String {
        let stringInput = input
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
        let stringInput = input
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

private let input = """
54032
64433
71758
133884
76994
99596
90491
89188
142280
127352
62127
79849
96049
56527
148029
81386
149827
105377
91970
98708
88611
99785
99229
88460
80396
70097
91784
81733
75671
106787
77196
132234
98698
115243
119574
142851
58964
137814
127695
92139
106277
51240
121351
78316
129472
65201
116068
72803
52582
135433
87619
68096
116952
106437
70517
69840
89863
134618
83823
113436
103779
134819
107928
138503
82509
90104
98001
76202
136238
66426
74030
55075
124163
57133
79908
109977
66903
125400
130961
149293
99203
120307
142403
50262
52854
70851
142213
77567
149144
144582
58138
61765
116209
128192
137436
101406
69037
107389
112389
124402
"""
