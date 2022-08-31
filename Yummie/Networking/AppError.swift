//
//  AppError.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 24..
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
            case .errorDecoding:
                return "Response could not be decoded"
            case .invalidUrl:
                return "Give me a valid URL"
            case .serverError(let error):
                return error
            case .unknownError:
                return "Some unknown error occurred"
        }
    }
}
