//
//  Planet.swift
//  adventOfCode2019
//
//  Created by Blaine Oelkers on 12/6/19.
//

import Foundation

public class Planet: Equatable {
    var name: String
    var orbitingPlanets: [Planet] = []
    
    static var starterPlanet = Planet(name: "COM")
    
    public init(name: String) {
        self.name = name
    }
    
    public static func == (lhs: Planet, rhs: Planet) -> Bool {
        return lhs.name == rhs.name
    }
}

public extension Collection where Element == Planet {
    var allOrbits: Int? {
        guard let firstPlanet = self.findStarterPlanet() else {
            return -1
        }
        return firstPlanet.orbitingPlanets.reduce(0) { result, planet in
            return result + self.allOrbits(indirect: 1, inputPlanet: planet)
        }
    }
    
    private func allOrbits(indirect: Int, inputPlanet: Planet) -> Int {
        //one to count the current planet
        return inputPlanet.orbitingPlanets.reduce(1) { results, planet in
            //add one to the indirect because every layer is one more indirect
            return results + indirect + self.allOrbits(indirect: (indirect + 1), inputPlanet: planet)
        }
    }
    
    func containsPlanet(named name: String) -> Planet? {
        for planet in self {
            if planet.name == name {
                return planet
            }
            if let planetToReturn = planet.orbitingPlanets.containsPlanet(named: name) {
                return planetToReturn
            }
        }
        return nil
    }
    
    func chainTo(_ destination: Planet) -> [Planet] {
        guard let starterPlanet = self.findStarterPlanet() else { return [] }
        var planetChain = [starterPlanet]
        for planet in starterPlanet.orbitingPlanets {
            if planet == destination {
                return planetChain
            }
            if let chain = planet.orbitingPlanets.findInChain(destination: destination) {
                planetChain.append(planet)
                planetChain.append(contentsOf: chain)
            }
        }
        return planetChain
    }
    
    func findInChain(destination: Planet) -> [Planet]? {
        for planet in self {
            if planet == destination {
                return []
            }
            if let chain = planet.orbitingPlanets.findInChain(destination: destination) {
                var planetChain = [planet]
                planetChain.append(contentsOf: chain)
                return planetChain
            }
        }
        return nil
    }
    
    private func findStarterPlanet() -> Planet? {
        for planet in self {
            if planet == Planet.starterPlanet {
                return planet
            }
            if let planet = planet.orbitingPlanets.findStarterPlanet() {
                return planet
            }
        }
        return nil
    }
}
