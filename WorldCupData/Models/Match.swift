//
//  Match.swift
//  WorldCupData
//
//  Created by Leonardo Armelin on 27/11/22.
//

import Foundation

struct Match: Equatable, Identifiable, Codable {
    var id: String? = nil
    var away_team_id: String? = nil
    var away_score: Int? = nil
    var away_team_en: String? = nil
    var away_flag: String? = nil
    var home_team_id: String? = nil
    var home_score: Int? = nil
    var home_team_en: String? = nil
    var home_flag: String? = nil
    var finished: String? = nil
    var group: String? = nil
    var matchday: String? = nil
    var stadium_id: String? = nil
    var local_date: String? = nil
}
