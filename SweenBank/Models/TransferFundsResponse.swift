//
//  TransferFundsResponse.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/25/21.
//

import Foundation

// TODO: Refactor XferFundsReq & Resp into 1 generic class

struct TransferFundResponse: Decodable {
    let success: Bool
    let error: String?
}
