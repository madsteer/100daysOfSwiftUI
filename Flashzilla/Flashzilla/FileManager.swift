//
//  FileManager.swift
//  Flashzilla
//
//  Created by Cory Steers on 10/18/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func contentsOfDocumentsDirectory() -> [URL] {
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            return directoryContents
        } catch {
            print("some kind of error getting direcotry contents: \(error.localizedDescription)")
            return []
        }
    }
}
