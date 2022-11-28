//
//  WrapperStruct.swift
//  WorldCupData
//
//  Created by Leonardo Armelin on 27/11/22.
//

import Foundation

class WrappedStruct<T>: ObservableObject {
    @Published var item: T
    
    init(withItem item:T) {
        self.item = item
    }
}
