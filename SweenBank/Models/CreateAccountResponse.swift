//
//  CreateAccountResponse.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import Foundation

struct CreateAccountResponse: Decodable {
    let success: Bool
    let error: String? 
}
