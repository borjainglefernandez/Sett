//
//  Utils.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/30/23.
//

import Foundation

class Utils {
    static public func readJsonArray(for filePath: String) -> [[String: Any]]? {
    
    guard let jsonFilePath = Bundle.main.path(forResource: filePath, ofType: "json") else {
        print("JSON file not found.")
        return nil
    }
    
    do {
        let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
        let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
        return jsonArray
        
    } catch {
        print("Error reading JSON file: \(error.localizedDescription)")
        return nil
    }
}
}
