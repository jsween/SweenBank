//
//  AcountListView.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import SwiftUI

struct AccountListView: View {
    
    let accounts: [AccountViewModel]
    
    var body: some View {
        List(accounts, id: \.accountId) { account in
            AccountListRowItemView(account: account)
        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        let accountVMArray: [AccountViewModel] = [AccountViewModel(account: Account(id: UUID(), name: "Mr. DeadPool", accountType: .checking, balance: 5_000_000)), AccountViewModel(account: Account(id: UUID(), name: "Justin Bieber", accountType: .saving, balance: -1_240_000.43))]
        AccountListView(accounts: accountVMArray)
    }
}


