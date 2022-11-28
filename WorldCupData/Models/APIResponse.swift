//
//  APIResponse.swift
//  WorldCupData
//
//  Created by Leonardo Armelin on 24/11/22.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    var status: String? = nil
    var data: T? = nil
}
