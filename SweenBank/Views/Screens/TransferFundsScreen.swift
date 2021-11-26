//
//  TransferFundsScreen.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/25/21.
//

import SwiftUI

struct TransferFundsScreen: View {
    
    @ObservedObject private var transferFundsVM = TransferFundsViewModel()
    @State private var showSheet: Bool = false
    @State private var isFromAccount = false
    
    var actionSheetButtons: [Alert.Button] {
        var actionButtons = self.transferFundsVM.filteredAccounts.map { account in
            Alert.Button.default(Text("\(account.name) (\(account.accountType))")) {
                if self.isFromAccount {
                    self.transferFundsVM.fromAccount = account
                } else {
                    self.transferFundsVM.toAccount = account
                }
            }
        }
        
        actionButtons.append(.cancel())
        return actionButtons
    }
    
    var body: some View {
        VStack {
            AccountListView(accounts: transferFundsVM.accounts)
                .frame(height: 300)
            Spacer()
            TransferFundsAccountSelectionView(transferFundsVM: transferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAccount)
        }
        .onAppear {
            self.transferFundsVM.populateAccounts()
        }
        .actionSheet(isPresented: $showSheet, content: {
            ActionSheet(title: Text("TransferFunds"), message: Text("Choose Account"), buttons: self.actionSheetButtons)
        })
        .navigationTitle("Transfer Funds")
        .embedInNavigationView()
    }
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}

struct TransferFundsAccountSelectionView: View {
    
    @ObservedObject var transferFundsVM: TransferFundsViewModel
    @Binding var showSheet: Bool
    @Binding var isFromAccount: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Button("From \(self.transferFundsVM.fromAccountType)") {
                self.isFromAccount = true
                self.showSheet = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.green)
            .foregroundColor(.white)
            
            Button("To \(self.transferFundsVM.toAccountType)") {
                self.isFromAccount = false
                self.showSheet = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.green)
            .foregroundColor(.white)
            .opacity(self.transferFundsVM.fromAccount != nil ? 1.0 : 0.5)
            .disabled(self.transferFundsVM.fromAccount == nil)
        }
        .padding()
    }
}
