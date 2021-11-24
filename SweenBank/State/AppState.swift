//
//  AppState.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import Foundation

class AppState: ObservableObject {
    @Published var accounts = [Account]()
    
    init() {
        populateAllAccounts()
    }
    
    private func populateAllAccounts() {
        
        AccountService.shared.getAllAccounts { result in
            switch result {
            case .success(let accounts):
                if let accounts = accounts {
                    DispatchQueue.main.async {
                        self.accounts = accounts
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
    
    func update() {
        populateAllAccounts()
    }
}
