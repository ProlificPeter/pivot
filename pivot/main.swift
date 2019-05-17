//
//  main.swift
//  pivot
//
//  Created by Peter Granlund on 5/14/19.
//  Copyright © 2019 Peter Granlund. All rights reserved.
//

import Foundation

let pivot = Pivot()
if CommandLine.argc < 2 {
    //TODO: Handle interactive mode
} else {
    pivot.staticMode()
}

