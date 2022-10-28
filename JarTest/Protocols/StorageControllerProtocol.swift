//
//  StorageControllerProtocol.swift
//  JarTest
//
//  Created by Oleh Titov on 01.08.2022.
//

import Foundation

protocol StorageControllerProtocol {
    func save(_ masterAccount: Account)
    func fetchMasterAccount() -> Account
}
