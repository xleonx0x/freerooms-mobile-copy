//
//  LocationService.swift
//  Location
//
//  Created by Anh Nguyen on 22/4/2025.
//

import Foundation

// MARK: - LocationService

class LocationService {
  func getCurrentLocation() throws -> Location {
    fatalError("TODO: Implement")
  }

  func requestLocationPermissions() -> Bool {
    fatalError("TODO: Implement")
  }
}

// MARK: - LocationServiceError

enum LocationServiceError: Error {
  case locationPermissionsDenied
}
