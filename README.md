# ApexPredator

An iOS app showcasing apex predators from the Jurassic Park franchise, built with SwiftUI 6 and Swift 6 for iOS 18.

## Features

### 🦖 Dinosaur Collection
- Browse a comprehensive list of apex predators from Jurassic Park movies
- View detailed information including:
  - Dinosaur images and names
  - Predator types (Land, Air, Sea)
  - Movies they appeared in
  - Movie scenes and descriptions
  - Geographic locations on an interactive map

### 🔍 Search & Filter
- **Search**: Quickly find dinosaurs by name using the search bar
- **Filter by Type**: Filter predators by Land, Air, or Sea
- **Filter by Movie**: Filter by specific Jurassic Park movies:
  - Jurassic Park
  - The Lost World: Jurassic Park
  - Jurassic Park III
  - Jurassic World
  - Jurassic World: Fallen Kingdom
  - Jurassic World: Dominion

### 📊 Sorting
- Toggle between alphabetical sorting and original ID order
- Sort button located in the top-left toolbar

### 🗑️ Delete Functionality
- **Swipe-to-Delete**: Swipe left on any dinosaur row to reveal a delete button
- **Confirmation Alert**: Tap the "x" button to see a confirmation dialog
- **Safe Deletion**: Prevents accidental deletions with a two-step confirmation process
- **Animated Updates**: Smooth animations when items are removed from the list

### 🗺️ Interactive Maps
- View each predator's location on an interactive map
- Detailed view with map integration showing geographic coordinates

## Requirements

- iOS 18.0+
- Xcode 15.0+
- Swift 6.0+

## Project Structure

```
ApexPredator/
├── ApexPredatorApp.swift      # App entry point
├── ContentView.swift          # Main list view with search, filter, and delete
├── ApexPredator.swift         # Data models (ApexPredator, PredatorType, FilterOption)
├── ApexPredators.swift        # Data manager with @Observable support
├── PredatorDetail.swift       # Detail view for individual predators
├── PredatorMap.swift          # Map view component
├── jpapexpredators.json       # JSON data source
└── Assets.xcassets/          # Images and assets
```

## Key Implementation Details

### Observable Data Model
The `ApexPredators` class uses the `@Observable` macro (Swift 6) to automatically update SwiftUI views when data changes:

```swift
@Observable
class ApexPredators {
    var allApexPredators: [ApexPredator] = []
    // ...
}
```

### Swipe-to-Delete Implementation
- Uses `.swipeActions(edge: .trailing, allowsFullSwipe: false)` modifier
- Custom "x" button with destructive role styling
- Two-step confirmation process for safety

### Filtering & Sorting
- Pure computed property `filteredDinosaurs` that doesn't mutate state
- Prevents infinite update loops by avoiding side effects
- Combines filter, sort, and search operations efficiently

## Usage

1. **Browse**: Scroll through the list of apex predators
2. **Search**: Use the search bar at the top to find specific dinosaurs
3. **Filter**: Tap the filter icon (top-right) to filter by type or movie
4. **Sort**: Tap the sort icon (top-left) to toggle between alphabetical and ID order
5. **View Details**: Tap any dinosaur to see detailed information and map location
6. **Delete**: Swipe left on a dinosaur row, tap the "x" button, and confirm deletion

## Data Source

The app loads dinosaur data from `jpapexpredators.json`, which includes:
- Predator information (name, type, location)
- Movie appearances
- Movie scene descriptions
- Links to additional resources

## Notes

- Deletions are **in-memory only** and will reset when the app restarts
- The app uses dark mode by default
- All images are included in the Assets catalog

## Technologies Used

- **SwiftUI 6**: Modern declarative UI framework
- **Swift 6**: Latest Swift language features including `@Observable` macro
- **MapKit**: For displaying geographic locations
- **Observation Framework**: For reactive data updates

## Author

Created by Guang on 2025/11/26

## License

This project is part of an iOS development exercise course.

