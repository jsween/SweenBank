//
//  URL+Extensions.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import Foundation

extension URL {
    static let glitchBaseUrl = "https://brassy-emphasized-tourmaline.glitch.me"
    
    static func urlForAccounts() -> URL? {
         return URL(string: "\(glitchBaseUrl)/api/accounts")
    }
    
    static func urlForCreateAccounts() -> URL? {
        return URL(string: "\(glitchBaseUrl)/api/TO_DO_HERE")
    }
}
