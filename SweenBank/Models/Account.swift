//
//  Account.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import Foundation

struct Account: Codable {
    var id: UUID
    var name: String
    let accountType: AccountType
    var balance: Double
}
