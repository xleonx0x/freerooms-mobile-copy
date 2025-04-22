//
//  LocationService.swift
//  Location
//
//  Created by Anh Nguyen on 22/4/2025.
//

import Foundation

class LocationService {
  func getCurrentLocation() throws -> Location {
    fatalError("TODO: Implement")
  }
  
  func requestLocationPermissions() -> Bool {
    fatalError("TODO: Implement")
  }
}

enum LocationServiceError: Error {
  case locationPermissionsDenied
}
