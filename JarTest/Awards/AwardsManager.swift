//
//  AwardsManager.swift
//  JarTest
//
//  Created by Oleh Titov on 05.10.2022.
//

import Foundation

class AwardsManager {
    
    func loadAwards() -> [Award]? {
        if let url = Bundle.main.url(forResource: "Awards", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Award].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
