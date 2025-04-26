//
//  FetchingServerDataTests.swift
//  Networking
//
//  Created by Chris Wong on 26/4/2025.
//

import Foundation
import Networking
import Testing

struct FetchingServerDataTests {
  
  /// Simulates a successful connection and response from the server
  @Test
  func successfulConnectionAndResponse() async throws {
    let mockUrlSession = MockURLSession(data: Data(), urlResponse: HTTPURLResponse())
    let sut = URLSessionHTTPClient(urlSession: mockUrlSession)
    let res = await sut.get(from: URL(string: "www.fake.com")!)
    
    switch res {
    case .success(let (data, httpUrlResponse)):
      #expect(data == mockUrlSession.data && httpUrlResponse == mockUrlSession.urlResponse)
      break
    case .failure(_):
      Issue.record("Expected success")
      break
    }
  }
  
  /// Simulates connection lost during request
  @Test
  func connectionLostDuringRequest() async throws {
    let mockUrlSession = MockURLSession(data: Data(), urlResponse: HTTPURLResponse(), error: URLError(.networkConnectionLost))
    let sut = URLSessionHTTPClient(urlSession: mockUrlSession)
    let res = await sut.get(from: URL(string: "www.fake.com")!)
    
    switch res {
    case .failure(let error as HTTPClientError):
      #expect(error == .networkFailure)
      break
    case .success(_), .failure(_):
      Issue.record("Expected network failure")
      break
    }
  }
  
  /// Simulates an invalid http response received
  @Test
  func invalidHttpResponse() async throws {
    let mockUrlSession = MockURLSession(data: Data(), urlResponse: URLResponse())
    let sut = URLSessionHTTPClient(urlSession: mockUrlSession)
    let res = await sut.get(from: URL(string: "www.fake.com")!)
    
    switch res {
    case .failure(let error as HTTPClientError):
      #expect(error == .invalidHTTPResponse)
      break
    case .success(_), .failure(_):
      Issue.record("Expected invalid http response failure")
      break
    }
  }
  
  /// Simulates no internet connection when making request
  @Test
  func noInternetConnection() async throws {
    let mockUrlSession = MockURLSession(data: Data(), urlResponse: URLResponse(), error: URLError(.notConnectedToInternet))
    let sut = URLSessionHTTPClient(urlSession: mockUrlSession)
    let res = await sut.get(from: URL(string: "www.fake.com")!)
    
    switch res {
    case .failure(let error as HTTPClientError):
      #expect(error == .networkFailure)
      break
    case .success(_), .failure(_):
      Issue.record("Expected network failure")
      break
    }
  }
  
  /// Simulates an unknown error is thrown and caught
  @Test
  func unknownError() async throws {
    let mockUrlSession = MockURLSession(data: Data(), urlResponse: URLResponse(), error: URLError(.unknown))
    let sut = URLSessionHTTPClient(urlSession: mockUrlSession)
    let res = await sut.get(from: URL(string: "www.fake.com")!)
    
    switch res {
    case .failure(let error as URLError):
      #expect(error == URLError(.unknown))
      break
    case .success(_), .failure(_):
      Issue.record("Expected unknown failure")
      break
    }
  }


}
