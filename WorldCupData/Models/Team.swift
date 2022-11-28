//
//  Team.swift
//  WorldCupData
//
//  Created by Leonardo Armelin on 24/11/22.
//

import Foundation

struct Team : Equatable, Decodable, Identifiable {
    var id: String? = nil
    var groups: String? = nil
    var fifa_code: String? = nil
    var flag: String? = nil
    var name_en: String? = nil
}
