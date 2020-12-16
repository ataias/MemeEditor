//
//  FileManager+Extensions.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 03/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation
import SwiftUI

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    static let dataFile = FileManager.documentsDirectory.appendingPathComponent("memeData.json")

    static func decode<T: Codable>(_ url: URL) -> T? {

        if !FileManager.default.fileExists(atPath: url.path) {
            return nil
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(url) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(url) from bundle")
        }

        return loaded
    }


    static func save<T: Codable>(_ toSave: T) throws {
        let data = try JSONEncoder().encode(toSave)
        try data.write(to: dataFile, options: [.atomicWrite])
    }

}
