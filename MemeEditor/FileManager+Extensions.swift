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

    /// Reads all files at path as "Element"
    static func decodeArray<Element: Codable>(at url: URL) throws -> [Element]  {
        let manager = FileManager.default
        let files = try manager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        return files.compactMap { decode($0) }
    }

    static func jsonPath<T: Identifiable>(_ data: T) -> URL {
        FileManager.documentsDirectory.appendingPathComponent("\(data.id).json")
    }


    static func save<T: Codable>(_ toSave: T) throws where T: Identifiable {
        let data = try JSONEncoder().encode(toSave)
        try data.write(to: jsonPath(toSave))
    }

    static func removeJson<T: Identifiable>(_ toRemove: T) throws {
        try FileManager.default.removeItem(at: jsonPath(toRemove))
    }

}
