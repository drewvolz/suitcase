//
//  main.swift
//  suitcase
//
//  Created by Drew Volz on 2/7/21.
//

import ArgumentParser
import Foundation

struct Suitcase: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Packs the contents of a directory into a single file."
    )
    
    @Argument(help: ArgumentHelp("The directory that will be parsed."))
    var directory = ""
    
    @Argument(help: ArgumentHelp("The name of the file that will be generated."))
    var outfile = "outfile.txt"
    
    @Option(name: .shortAndLong, help: "Filter out hidden files.")
    var filter = true

    func validate() throws {
        guard !directory.isEmpty else {
            throw ValidationError("Missing expected argument '<directory>'")
        }
    }
    
    func run() {
        removeOldFile(path: outfile)
        
        let files = getFileNames(path: directory, filter: filter)
        let contents = getContentsOfFiles(path: directory, fileNames: files)
        
        save(contents: contents, to: outfile)
    }
}

Suitcase.main()
