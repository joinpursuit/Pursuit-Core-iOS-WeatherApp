//
//  AppError.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

public enum AppError: Error {
  case badURL(String)
  case networkError(Error)
  case noResponse
  case decodingError(Error)
  case badStatusCode(String)
  case badMimeType(String)
  
  public func errorMessage() -> String {
    
    switch self {
    case .badURL(let message):
      return "Bad URL: \(message)"
    case .networkError(let error):
      return error.localizedDescription
    case .noResponse:
      return "No network resonse"
    case .decodingError(let error):
      return "Decoding error: \(error)"
    case .badStatusCode(let message):
      return "Bad status code: \(message)"
    case .badMimeType(let message):
      return "Bad mime code: \(message)"
    }
  }
}
