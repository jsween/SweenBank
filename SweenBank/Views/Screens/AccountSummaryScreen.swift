//
//  AccountSummaryScreen.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import SwiftUI

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { g in
                VStack {
                    AccountListView(accounts: accountSummaryVM.accounts)
                        .frame(height: g.size.height/2)
                    Text("\(accountSummaryVM.total.formatAsCurrency())")
                    Spacer()
                    Button("Transfer Funds") {
                        self.accountSummaryVM.activeSheet = .transferFunds
                        self.isPresented = true
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            self.accountSummaryVM.getAllAccounts()
        }
        .sheet(isPresented: $isPresented, onDismiss: {
            self.accountSummaryVM.getAllAccounts()
        }) {
            switch self.accountSummaryVM.activeSheet {
            case .addAccount:
                AddAccountScreen()
            case .transferFunds:
                TransferFundsScreen()
            }
        }
        .navigationBarItems(trailing: Button("Add Account") {
            self.accountSummaryVM.activeSheet = .addAccount
            isPresented = true
        })
        .navigationTitle("Account Summary")
        .embedInNavigationView()
    }
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
            .environmentObject(AppState())
    }
}
