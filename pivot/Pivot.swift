//
//  Pivot.swift
//  pivot
//
//  Created by Peter Granlund on 5/14/19.
//  Copyright © 2019 Peter Granlund. All rights reserved.
//

import Foundation

enum OptionType: String {
    case story = "s"
    case epic = "e"
    case product = "p"
    case help = "h"
    case project = "j"
    case configure = "c"
    case key = "k"
    case unknown
    
    init(value: String) {
        switch value {
        case "s": self = .story
        case "e": self = .epic
        case "p": self = .product
        case "h": self = .help
        case "j": self = .project
        case "c": self = .configure
        case "k": self = .key
        default: self = .unknown
        }
    }
}

class Pivot {
    
    let consoleIO = ConsoleIO()
    let tokenHandler: TokenHandler
    let tokenKey: TokenKey
    
    init() {
        self.tokenHandler = TokenHandler(consoleIO: consoleIO)
        self.tokenKey = TokenKey(key: tokenHandler.retrieveToken())
    }
    
    
    func staticMode() {
        //1
        let argCount = CommandLine.argc
        //2
        let argument = CommandLine.arguments[1]
        //TODO: Update this to not use deprecated function
        let (option, value) = getOption(argument.substring(from: argument.index(argument.startIndex, offsetBy: 1)))
        //4
        switch option {
        case .story:
            //2
            if argCount != 3 {
                if argCount > 3 {
                    consoleIO.writeMessage("Too many arguments for option \(option.rawValue)", to: .error)
                } else {
                    consoleIO.writeMessage("Too few arguments for option \(option.rawValue)", to: .error)
                }
                consoleIO.printUsage()
            } else {
                //3
                let storyTitle = CommandLine.arguments[2]
                consoleIO.writeMessage("Story to Create: \(storyTitle)")
            }
        case .epic:
            //4
            if argCount != 2 {
                if argCount > 2 {
                    consoleIO.writeMessage("Too many arguments for option \(option.rawValue)", to: .error)
                } else {
                    consoleIO.writeMessage("Too few arguments for option \(option.rawValue)", to: .error)
                }
                consoleIO.printUsage()
            } else {
                //5
                consoleIO.writeMessage("Epic Selected")
            }
        //6
        case .help:
            consoleIO.printUsage()
        case .unknown:
            //7
            consoleIO.writeMessage("Unknown option \(value)")
            consoleIO.printUsage()
        case .product:
            consoleIO.writeMessage("Product Selected")
        case .project:
            consoleIO.writeMessage("Project Selected")
        case .configure:
            consoleIO.writeMessage("Configuration selected")
            configurationProcess()
        case .key:
            consoleIO.writeMessage("Key Selected")
            keyDump()
        }
        
    }
    
    func getOption(_ option: String) -> (option:OptionType, value: String) {
        return (OptionType(value: option), option)
    }
 
    func configurationProcess() {
        tokenHandler.configurationMode()
    }
    
    func keyDump() {
        consoleIO.writeMessage("Key: \(tokenKey.getTokenKey())")
    }
    
    func projectProcess() {
        
    }
    
}
