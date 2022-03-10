//
//  Utility.swift
//  qmk-merge
//
//  Created by Jacob Jerrell on 3/5/22.
//

import Foundation

struct Utility {
    
    /// https://stackoverflow.com/a/50035059
    static func safeShell(_ command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")

        try task.run()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }
}

// Example usage:
do {
    safeShell("ls -la")
}
catch {
    print("\(error)") //handle or silence the error here
}
