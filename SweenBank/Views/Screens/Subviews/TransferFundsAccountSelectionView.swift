//
//  TransferFundsAccountSelectionView.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/26/21.
//

import SwiftUI

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
            
            TextField("Amount", text: self.$transferFundsVM.transferAmount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
        }
        .padding()
    }
}
