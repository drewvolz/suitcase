//
//  pack.swift
//  suitcase
//
//  Created by Drew Volz on 2/7/21.
//

import Foundation

extension Suitcase.Pack {
    
    internal func getFileNames(path: String, filter: Bool) -> FileNames {
        var items = [String]()
        
        do {
            items = try fileManager.contentsOfDirectory(atPath: path)
            
            if filter {
                items = items.filter { $0 != ".DS_Store" }
            }
        } catch let error as NSError {
            print("Failed parsing the filenames for the path: \(path), Error: " + error.localizedDescription)
        }
        
        return items
    }
    
    internal func getContentsOfFiles(path: String, fileNames: FileNames) -> FileContents {
        var items = FileContents()
        
        for name in fileNames {
            do {
                let filePath = path + name
                let fileUrl = URL(fileURLWithPath: filePath)
                let contents = try String(contentsOf: fileUrl)
                items[filePath] = contents
            } catch let error as NSError {
                print("Failed parsing the contents of file: \(name), Error: " + error.localizedDescription)
            }
        }
        
        return items
    }
    
    internal func save(contents: FileContents, to: String) {
        do {
            let fileUrl = URL(fileURLWithPath: to)
            let data = try JSONEncoder().encode(contents)
            
            try data.write(to: fileUrl)
            
            print("Success. Packed contents are located at: \(to)")
        } catch let error as NSError {
            print("Failed writing to URL: \(to), Error: " + error.localizedDescription)
        }
    }

    internal func removeOldFile(path: String) {
        if fileManager.fileExists(atPath: path) {
            do {
                try fileManager.removeItem(atPath: path)
            } catch {
                print("Failed to remove the old packed file, Error: " + error.localizedDescription)
            }
        }
    }
}
