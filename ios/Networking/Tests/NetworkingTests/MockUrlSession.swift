//
//  MockUrlSession.swift
//  Networking
//
//  Created by Chris Wong on 27/4/2025.
//

import Networking
import Foundation

public struct MockURLSession: HTTPSession {
  public var data: Data
  public var urlResponse: URLResponse
  public var error: Error?

  public init(data: Data, urlResponse: URLResponse, error: Error? = nil) {
    self.data = data
    self.urlResponse = urlResponse
    self.error = error
  }

  public func data(from _: URL) async throws -> (Data, URLResponse) {
    guard let error else {
      return (data, urlResponse)
    }
    throw error
  }
}

