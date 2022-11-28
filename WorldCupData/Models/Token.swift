//
//  Token.swift
//  WorldCupData
//
//  Created by Leonardo Armelin on 26/11/22.
//

import Foundation

struct Token : Decodable, Identifiable, Equatable {
    var token: String? = nil
    
    var id: String {
        token ?? ""
    }
}
