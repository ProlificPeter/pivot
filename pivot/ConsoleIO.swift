//
//  ConsoleIO.swift
//  pivot
//
//  Created by Peter Granlund on 5/14/19.
//  Copyright © 2019 Peter Granlund. All rights reserved.
//

import Foundation

enum OutputType {
    case error
    case standard
}


class ConsoleIO {
    
    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\(message)")
        case .error:
            fputs("Error: \(message)\n", stderr)
        }
    }
    
    func printUsage() {
        //Write out the error/help message
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        writeMessage("usage:")
        writeMessage("\(executableName) -e string")
        writeMessage("or")
        writeMessage("\(executableName) -p string")
        writeMessage("or")
        writeMessage("\(executableName) -j string")
        writeMessage("or")
        writeMessage("\(executableName) -c to open interactive configuration)")
        writeMessage("or")
        writeMessage("\(executableName) -h to show usage information")
        writeMessage("Type \(executableName) without an option to enter interactive mode.")
    }
    
    func getInput() -> String {
        // 1
        let keyboard = FileHandle.standardInput
        // 2
        let inputData = keyboard.availableData
        // 3
        let strData = String(data: inputData, encoding: String.Encoding.utf8)!
        // 4
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
    
    func readShell(_ command: String) -> String {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        
        return output
    }
    
    func shell(_ command: String) -> Int32 {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
}

