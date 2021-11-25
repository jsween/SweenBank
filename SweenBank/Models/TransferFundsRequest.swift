//
//  TransferAccountFunds.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/25/21.
//

import Foundation

struct TransferFundRequest: Codable {
    let accountFromId: String
    let accountToId: String
    let amount: Double 
}
