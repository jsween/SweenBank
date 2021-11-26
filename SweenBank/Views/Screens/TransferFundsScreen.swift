//
//  TransferFundsScreen.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/25/21.
//

import SwiftUI

struct TransferFundsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
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
            TransferFundsAccountSelectionView(transferFundsVM: transferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAccount)
            Spacer()
                .onAppear {
                    self.transferFundsVM.populateAccounts()
                }
            Text(self.transferFundsVM.message ?? "")
                .foregroundColor(.red)
            Button("Submit Transfer") {
                self.transferFundsVM.submitTranser() {
                    print("success")
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            .opacity(self.transferFundsVM.readyToSubmitTransfer ? 1.0 : 0)
            .disabled(!self.transferFundsVM.readyToSubmitTransfer)
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
