//
//  AccountType.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import Foundation

enum AccountType: String, Codable, CaseIterable {
    case checking
    case saving
}

extension AccountType {
    var title: String {
        switch self {
        case .checking:
            return "Checking"
        case .saving:
            return "Saving"
        }
    }
}
