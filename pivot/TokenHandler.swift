//
//  TokenHandler.swift
//  pivot
//
//  Created by Peter Granlund on 5/17/19.
//  Copyright © 2019 Peter Granlund. All rights reserved.
//

import Foundation

class TokenHandler {
    var consoleIO: ConsoleIO
    
    init(consoleIO: ConsoleIO) {
        self.consoleIO = consoleIO
    }
    
    func retrieveToken() -> String {
        let file = consoleIO.readShell("cat ~/Library/Application\\ Support/com.rldimensions.pivot/config")
        var token: String?
        if file != "" {
            let readfile = file.split(separator: "\n")
            for line in readfile {
                let keypair = line.split(separator: ":")
                if keypair.count == 2 {
                    if keypair[0] == "key" {
                        token = String(keypair[1])
                        consoleIO.writeMessage("Token value loaded as \(token)")
                        break
                    }
                }
            }
        }
        else
        {
            //TODO: go to Error
            return "empty"
        }
        if token != nil {
            return token!
        }
        else {
            //add a damned error function
            return "empty"
        }
    }
    
    func setToken(trackerKey: String) {
        consoleIO.writeMessage("Updating Key...")
        let directoryOutput = consoleIO.shell("mkdir -p ~/Library/Application\\ Support/com.rldimensions.pivot/")
        if directoryOutput != 0 {
            consoleIO.writeMessage("Writing unsuccessful with error \(directoryOutput). Make sure you have appropriate permissions while running.")
        }
        else {
            consoleIO.writeMessage("Folder structure in place.")
        }
        let fileOutput = (consoleIO.shell("echo \"key:\(trackerKey)\" >| ~/Library/Application\\ Support/com.rldimensions.pivot/config"))
        if (fileOutput != 0) {
            consoleIO.writeMessage("Writing unsuccessful with error \(fileOutput). Make sure you have appropriate permissions while running.")
        }
        else {
            consoleIO.writeMessage("Configuration Successful")
            
        }
    }
    
    func configurationMode() {
        consoleIO.writeMessage("To configure Pivot, please enter your Tracker API Key")
        let trackerKey = consoleIO.getInput()
        
        if trackerKey.count < 5 {
            consoleIO.writeMessage("Tracker Key is invalid.")
            configurationMode()
        }
        else {
            setToken(trackerKey: trackerKey)
        }
    }
}
