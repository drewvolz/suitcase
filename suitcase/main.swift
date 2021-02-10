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
        abstract: "Packing or unpacking a directory into a single file and back.",
        subcommands: [Pack.self, Unpack.self]
    )
}

extension Suitcase {

    struct Pack: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Pack a directory of files into a single file.")
        
        @Argument(help: ArgumentHelp("The directory that will be parsed."))
        public var directory = ""
        
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
    
    struct Unpack: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Unpack a packed file back into a directory.")
        
        @Argument(help: ArgumentHelp("The packed file that will be unpacked."))
        public var infile = ""
        
        @Option(name: .shortAndLong, help: "Filter out hidden files.")
        var filter = true
        
        func validate() throws {
            guard !infile.isEmpty else {
                throw ValidationError("Missing expected argument '<infile>'")
            }
        }
        
        func run() {
            let data = getPackedContents(path: infile)
            save(contents: data)
        }
    }
}


Suitcase.main()
