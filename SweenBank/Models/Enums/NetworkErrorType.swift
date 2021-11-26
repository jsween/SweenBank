//
//  NetworkErrorType.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case decodingError
    case noData
}
