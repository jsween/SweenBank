//
//  TransferFundsViewModel.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/25/21.
//

import Foundation

class TransferFundsViewModel: ObservableObject {
    var fromAccount: AccountViewModel?
    var toAccount: AccountViewModel?
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    
    var fromAccountType: String {
        fromAccount != nil ? fromAccount!.accountType : ""
    }
    
    var toAccountType: String {
        toAccount != nil ? toAccount!.accountType : ""
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
}
