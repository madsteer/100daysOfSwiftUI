//
//  FileManager.swift
//  HotProspects
//
//  Created by Cory Steers on 9/25/23.
//

import Foundation
import SwiftUI

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
