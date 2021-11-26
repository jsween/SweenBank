//
//  TransferFundsViewModel.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/25/21.
//

import Foundation
import SwiftUI

class TransferFundsViewModel: ObservableObject {
    var fromAccount: AccountViewModel?
    var toAccount: AccountViewModel?
    @Published var message: String?
    @Published var transferAmount: String = ""
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    
    var fromAccountType: String {
        fromAccount != nil ? fromAccount!.accountType : ""
    }
    
    var toAccountType: String {
        toAccount != nil ? toAccount!.accountType : ""
    }
    
    var readyToSubmitTransfer: Bool {
        return fromAccount != nil && toAccount != nil
        && !transferAmount.isEmpty
    }
    
    var isAmountValid: Bool {
        guard let userAmount = Double(transferAmount) else {
            return false
        }
        
        return userAmount > 0 ? true : false
    }
    
    var filteredAccounts: [AccountViewModel] {
        if self.fromAccount == nil {
            return accounts
        } else {
            return accounts.filter {

                guard let fromAccount = fromAccount else {
                    return false
                }

                return $0.accountId != fromAccount.accountId
            }
        }
    }
    
    func populateAccounts() {
        AccountService.shared.getAllAccounts { result in
            switch result {
            case .success(let accounts):
                if let accounts = accounts {
                    DispatchQueue.main.async {
                        self.accounts = accounts.map(AccountViewModel.init)
                    }
                }
            case .failure(let error):
                switch error {
                case .badUrl:
                    print("Bad URL Error: \(error.localizedDescription)")
                case .noData:
                    print("No Data Error: \(error.localizedDescription)")
                case .decodingError:
                    print("Decoding Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func isValid() -> Bool {
        // Add more functionality here as app grows
        return isAmountValid
    }
    
    func submitTranser(completion: @escaping () -> Void) {
        
        if !isValid() {
            return
        }
        
        guard let fromAccount = fromAccount, let toAccount = toAccount, let amount = Double(transferAmount) else {
            return
        }
        
        let transferFundRequest = TransferFundRequest(accountFromId: fromAccount.accountId.lowercased(), accountToId: toAccount.accountId.lowercased(), amount: amount)
        
        AccountService.shared.transferFunds(transferFundRequest: transferFundRequest) { result in
            switch result {
            case .success(let response):
                if response.success {
                    completion()
                } else {
                    self.message = response.error
                }
            case .failure(let error):
                self.message = error.localizedDescription
            }
        }
    }
}
