//
//  URLSessionHTTPClient.swift
//  Networking
//
//  Created by Anh Nguyen on 23/4/2025.
//

import Foundation

// MARK: - URLSessionHTTPClient

@available(macOS 12.0, *)
public struct URLSessionHTTPClient: HTTPClient {
  private var urlSession: URLSessionProtocol

  public init(urlSession: URLSessionProtocol) {
    self.urlSession = urlSession
  }

  public func get(from url: URL) async -> HTTPClient.Result {
    do {
      let (data, urlResponse) = try await urlSession.data(from: url)
      guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
        return .failure(HTTPClientError.invalidHTTPResponse)
      }
      return .success((data, httpUrlResponse))
    } catch let networkError as URLError where networkError.code == .networkConnectionLost || networkError.code == .notConnectedToInternet {
      return .failure(HTTPClientError.networkFailure)
    } catch let error {
      return .failure(error)
    }
  }
}