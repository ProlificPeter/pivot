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
    case unknown
    
    init(value: String) {
        switch value {
        case "s": self = .story
        case "e": self = .epic
        case "p": self = .product
        case "h": self = .help
        default: self = .unknown
        }
    }
}

class Pivot {
    
    let consoleIO = ConsoleIO()
    
    func staticMode() {
        //1
        let argCount = CommandLine.argc
        //2
        let argument = CommandLine.arguments[1]
        //3
        let (option, value) = getOption(argument.substring(from: argument.index(argument.startIndex, offsetBy: 1)))
        //4
        consoleIO.writeMessage("Argument count: \(argCount) Option: \(option) value: \(value)")
    }
    
    func getOption(_ option: String) -> (option:OptionType, value: String) {
        return (OptionType(value: option), option)
    }
    
}
