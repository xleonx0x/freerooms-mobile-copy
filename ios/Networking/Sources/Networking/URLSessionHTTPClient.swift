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

// MARK: - URLSessionProtocol

public protocol URLSessionProtocol {
  func data(from url: URL) async throws -> (Data, URLResponse)
}

// MARK: - URLSession + URLSessionProtocol
@available(macOS 12.0, *)
extension URLSession: URLSessionProtocol { }

// MARK: - MockURLSession

public struct MockURLSession: URLSessionProtocol {
  public var data: Data
  public var urlResponse: URLResponse
  public var error: Error?

  public init(data: Data, urlResponse: URLResponse, error: Error? = nil) {
    self.data = data
    self.urlResponse = urlResponse
    self.error = error
  }

  public func data(from _: URL) async throws -> (Data, URLResponse) {
    guard let error = error else {
      return (data, urlResponse)
    }
    throw error
  }
}
