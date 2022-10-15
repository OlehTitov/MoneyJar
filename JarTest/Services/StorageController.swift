//
//  StorageController.swift
//  JarTest
//
//  Created by Oleh Titov on 16.06.2022.
//

import Foundation

class StorageController: StorageControllerProtocol {
    private let documentsDirectoryURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    private var accountsFileURL: URL {
        return documentsDirectoryURL
            .appendingPathComponent("MasterJarAccount")
            .appendingPathExtension("json")
    }
    
    func save(_ masterAccount: MasterAccount) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(masterAccount) else { return }
        try? data.write(to: accountsFileURL)
    }
    
    /**
     Fetching existing user's data from disk, if data does not exists the method returns an empty struct
     */
    func fetchMasterAccount() -> MasterAccount {
        let emptyAccount = MasterAccount(name: "", goalAmount: 0, baseCurrency: .eur, rates: [:], lastRatesUpdate: "", assets: [], balance: 0, awards: [], portfolioItems: [], balanceBeforeChange: 0)
        guard let data = try? Data(contentsOf: accountsFileURL) else { return emptyAccount }
        let decoder = JSONDecoder()
        let accounts = try? decoder.decode(MasterAccount.self, from: data)
        return accounts ?? emptyAccount
    }
}
