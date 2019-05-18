//
//  TokenKey.swift
//  pivot
//
//  Created by Peter Granlund on 5/16/19.
//  Copyright © 2019 Peter Granlund. All rights reserved.
//

import Foundation

class TokenKey {
    
    var key: String
    
    init(key: String) {
        self.key = key
    }
    
    func setTokenKey(tokenKey: String) {
        key = tokenKey
    }
    
    func getTokenKey() -> String {
        return key
    }
}
