//
//  ContentView.swift
//  ApexPredator
//
//  Created by Guang on 2025/11/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var predators = ApexPredators()

    @State var searchText: String = ""
    @State var alphabetical: Bool = false
    @State var currentSelection = FilterOption.defaultFilter
    @State var predatorToDelete: ApexPredator?

    var filteredDinosaurs: [ApexPredator] {
        var result = predators.allApexPredators
        
        // Apply filter
        switch currentSelection {
        case .type(let type):
            if type != .all {
                result = result.filter { $0.type == type }
            }
        case .movie(let movie):
            result = result.filter { $0.movies.contains(movie) }
        }
        
        // Apply sort
        result.sort { predator1, predator2 in
            if alphabetical {
                return predator1.name < predator2.name
            } else {
                return predator1.id < predator2.id
            }
        }
        
        // Apply search
        if !searchText.isEmpty {
            result = result.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return result
    }
    
    var allMovies: [String] {
        predators.getAllMovies()
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredDinosaurs) { predator in
                    NavigationLink {
                        PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                    } label: {
                        HStack {
                            // Dinosaur image
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .shadow(color: .white, radius: 2)

                            VStack(alignment: .leading) {
                                // Name
                                Text(predator.name)
                                    .fontWeight(.bold)
                                // Type
                                Text(predator.type.rawValue.capitalized)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 13)
                                    .padding(.vertical, 5)
                                    .background(predator.type.background)
                                    .clipShape(.capsule)
                            }
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            predatorToDelete = predator
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .animation(.easeInOut(duration: 0.3), value: currentSelection)
            .alert("Delete Dinosaur", isPresented: Binding(
                get: { predatorToDelete != nil },
                set: { if !$0 { predatorToDelete = nil } }
            )) {
                Button("Cancel", role: .cancel) {
                    predatorToDelete = nil
                }
                Button("Delete", role: .destructive) {
                    if let predator = predatorToDelete {
                        withAnimation {
                            predators.delete(predator: predator)
                        }
                        predatorToDelete = nil
                    }
                }
            } message: {
                if let predator = predatorToDelete {
                    Text("Are you sure you want to delete \(predator.name)?")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Text("Type")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Picker(selection: $currentSelection, label: Text("")) {
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                                    .tag(FilterOption.type(type))
                            }
                        }
                        .pickerStyle(.inline)
                        
                        Divider()
                        
                        Text("Movie")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Picker(selection: $currentSelection, label: Text("")) {
                            ForEach(allMovies, id: \.self) { movie in
                                Label(movie, systemImage: FilterOption.movie(movie).icon)
                                    .tag(FilterOption.movie(movie))
                            }
                        }
                        .pickerStyle(.inline)
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }

}

#Preview {
    ContentView()
}
