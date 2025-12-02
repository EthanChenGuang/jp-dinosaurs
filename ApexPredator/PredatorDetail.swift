//
//  PredatorDetail.swift
//  ApexPredator
//
//  Created by Guang on 2025/11/28.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    var predator: ApexPredator
    
    @State var position: MapCameraPosition
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack {
                    // background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8),
                                                Gradient.Stop(color: .black, location: 1)],
                                           startPoint: .top, endPoint: .bottom)
                        }
                    
                    // Dinosour image
                    NavigationLink {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(x: -1)
                            .padding()
                        
                    } label: {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                            .scaleEffect(x: -1)
                            .shadow(color:.black, radius: 7)
                            .offset(y:20)
                    }
                    
                }
                
                VStack(alignment: .leading) {
                    // Dinosaur Name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    
                    // Current Location
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000, heading: 250, pitch: 80))
                        )
                        
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                        
                    }
                    
                    // Appears in
                    Text("Appears in:")
                        .font(.title2)
                    
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    // Movie moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }

                    // Link to webpage
                    Text("Read More:")
                        .font(.caption)
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
                
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        PredatorDetail(predator: ApexPredators().apexPredators[7], position: .camera(MapCamera(centerCoordinate: ApexPredators().apexPredators[7].location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
}
