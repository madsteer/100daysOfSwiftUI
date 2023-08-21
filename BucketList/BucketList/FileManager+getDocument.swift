//
//  FileManager+getDocument.swift
//  BucketList
//
//  Created by Cory Steers on 8/21/23.
//

import Foundation

extension FileManager {
    class func getDocument(from url: URL) -> String {
        do {
            let input = try String(contentsOf: url)
            return input
        } catch {
            print(error.localizedDescription)
        }
        
        return ""
    }
    
    class func writeTo(_ url: URL, _ data: String) {
        do {
            try data.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
}
