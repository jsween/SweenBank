//
//  AccountSummaryViewModel.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import Foundation

class AccountSummaryViewModel: ObservableObject {
    
    @Published var activeSheet: ActiveSheet = .addAccount
    private var _accountModels = [Account]()
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    
    var total: Double {
        _accountModels.map { $0.balance }.reduce(0, +)
    }
    
    func setAccounts(_ accounts: [Account]) {
        _accountModels = accounts
        self.accounts = _accountModels.map(AccountViewModel.init)
    }
    
    func getAllAccounts() {
        
        AccountService.shared.getAllAccounts { result in
            switch result {
            case .success(let accounts):
                if let accounts = accounts {
                    DispatchQueue.main.async {
                        self._accountModels = accounts
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
