//
//  MapViewModel.swift
//  Freerooms
//
//  Created by MUQUEET MOHSEN CHOWDHURY on 26/4/25.
//

import Buildings 
import Foundation 
import Observation 

// The @Observable macro automatically makes this class observable for UI updates.
@Observable
final class MapViewModel {
    // The UI will automatically update when this array changes because of @Observable.
    var buildings: [Building] = []
    
    // Reference to a service that provides building data.
    private let buildingService: BuildingService

    // Custom BuildingService (for example, a mock for testing), or use the default one for normal app usage.
    init(buildingService: BuildingService = BuildingService()) {
        self.buildingService = buildingService 
    }

    // Loads building data from the service and updates the buildings array.
    func loadBuildings() {
        buildings = buildingService.getBuildings()
    }
}
