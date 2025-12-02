//
//  ApexPredators.swift
//  ApexPredator
//
//  Created by Guang on 2025/11/26.
//

import Foundation
import Observation

@Observable
class ApexPredators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
                
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        }
        else {
            return apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            if alphabetical {
                predator1.name < predator2.name
            }
            else {
                predator1.id < predator2.id
            }
        }
    }
    
    func filter(by type: PredatorType) {
        if type == .all {
            apexPredators = allApexPredators
        }
        else {
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }
    }
    
    func getAllMovies() -> [String] {
        var moviesSet = Set<String>()
        for predator in allApexPredators {
            for movie in predator.movies {
                moviesSet.insert(movie)
            }
        }
        return Array(moviesSet).sorted()
    }
    
    func filter(by option: FilterOption) {
        switch option {
        case .type(let type):
            if type == .all {
                apexPredators = allApexPredators
            }
            else {
                apexPredators = allApexPredators.filter { predator in
                    predator.type == type
                }
            }
        case .movie(let movie):
            apexPredators = allApexPredators.filter { predator in
                predator.movies.contains(movie)
            }
        }
    }
    
    func delete(predator: ApexPredator) {
        allApexPredators.removeAll { $0.id == predator.id }
        apexPredators.removeAll { $0.id == predator.id }
    }
}
