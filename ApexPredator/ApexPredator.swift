//
//  ApexPredator.swift
//  ApexPredator
//
//  Created by Guang on 2025/11/26.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }

    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
}

enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    case all // "all"
    case land // "land"
    case air  // "air"
    case sea // "sea"
    
    var id: PredatorType {
        self
    }
    
    var background: Color {
        switch self {
        case .land:
            .brown
        case .air:
            .teal
        case .sea:
            .blue
        case .all:
            .black
        }
   
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
    
}

enum FilterOption: Identifiable, Hashable {
    case type(PredatorType)
    case movie(String)
    
    var id: String {
        switch self {
        case .type(let type):
            return "type_\(type.rawValue)"
        case .movie(let movie):
            return "movie_\(movie)"
        }
    }
    
    var displayName: String {
        switch self {
        case .type(let type):
            return type.rawValue.capitalized
        case .movie(let movie):
            return movie
        }
    }
    
    var icon: String {
        switch self {
        case .type(let type):
            return type.icon
        case .movie(let movie):
            return iconForMovie(movie)
        }
    }
    
    private func iconForMovie(_ movie: String) -> String {
        switch movie {
        case "Jurassic Park":
            return "sparkles"
        case "The Lost World: Jurassic Park":
            return "map.fill"
        case "Jurassic Park III":
            return "diamond.fill"
        case "Jurassic World":
            return "globe.americas.fill"
        case "Jurassic World: Fallen Kingdom":
            return "flame.fill"
        case "Jurassic World: Dominion":
            return "crown.fill"
        default:
            return "film.fill"
        }
    }
    
    static var defaultFilter: FilterOption {
        .type(.all)
    }
}
