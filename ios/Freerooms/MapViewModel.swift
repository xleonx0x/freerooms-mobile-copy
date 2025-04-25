//
//  MapViewModel.swift
//  Freerooms
//
//  Created by MUQUEET MOHSEN CHOWDHURY on 26/4/25.
//

import Foundation
import Buildings

class MapViewModel: ObservableObject {
  @Published var buildings: [Building] = []

  private let buildingService = BuildingService()

  init() {
    loadBuildings()
  }

  private func loadBuildings() {
    self.buildings = buildingService.getBuildings()
  }
}

