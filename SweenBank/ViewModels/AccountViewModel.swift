//
//  AccountViewModel.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import Foundation

class AccountViewModel {
    var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    var name: String {
        account.name
    }
    
    var accountId: String {
        account.id.uuidString
    }
    
    var accountType: String {
        account.accountType.title
    }
    
    var balance: Double {
        account.balance
    }
}
