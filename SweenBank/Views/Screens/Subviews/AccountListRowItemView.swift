//
//  AccountListRowItemView.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import SwiftUI

struct AccountListRowItemView: View {
    
    let account: AccountViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(account.name)
                    .font(.headline)
                Text(account.accountType.capitalized)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text("\(account.balance.formatAsCurrency())")
                .foregroundColor(account.balance > 0 ? .green : .red)
        }
    }
}

struct AccountListRowItemView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListRowItemView(account: AccountViewModel(account: Account(id: UUID(), name: "Mr. DeadPool", accountType: .checking, balance: 5_000_000)))
            .previewLayout(.sizeThatFits)
    }
}
