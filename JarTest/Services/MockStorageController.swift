//
//  MockStorageController.swift
//  JarTest
//
//  Created by Oleh Titov on 01.08.2022.
//

import Foundation

class MockStorageController: StorageControllerProtocol {
    private let documentsDirectoryURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    private var accountsFileURL: URL {
        return documentsDirectoryURL
            .appendingPathComponent("MockAccount")
            .appendingPathExtension("json")
    }
    
    func save(_ masterAccount: MasterAccount) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(masterAccount) else { return }
        try? data.write(to: accountsFileURL)
    }
    
    func fetchMasterAccount() -> MasterAccount {
        return MasterAccount(name: "", goalAmount: 0, baseCurrency: .eur, rates: [:], lastRatesUpdate: "", assets: [], balance: 0, awards: [], portfolioItems: [], balanceBeforeChange: 0)
    }
    
    
}
