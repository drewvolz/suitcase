//
//  unpack.swift
//  suitcase
//
//  Created by Drew Volz on 2/8/21.
//

import Foundation

extension Suitcase.Unpack {

    internal func getPackedContents(path: String) -> FileContents {
        return decodeJson(path: path)
    }
    
    private func decodeJson(path: String) -> FileContents {
        var result = FileContents()
        
        do {
            let fileUrl = URL(fileURLWithPath: path)
            let contents = try String(contentsOf: fileUrl)
            
            let jsonData = contents.data(using: .utf8)!
            let decoder = JSONDecoder()

            result = try decoder.decode(FileContents.self, from: jsonData)
        } catch let error as NSError {
            print("Failed decoding the contents of file: \(path), Error: " + error.localizedDescription)
        }
        
        return result
    }
    
    internal func save(contents: FileContents) {
        for (destination, data) in contents {
            do {
                let fileUrl = URL(fileURLWithPath: destination)

                try data.write(to: fileUrl, atomically: true, encoding: String.Encoding.utf8)

                print("Success. Files are unpacked.")
            } catch let error as NSError {
                print("Failed writing to URL: \(destination), Error: " + error.localizedDescription)
            }
        }
    }
}
