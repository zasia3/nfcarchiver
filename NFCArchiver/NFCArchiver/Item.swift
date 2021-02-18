//
//  Item.swift
//  NFCArchiver
//
//  Created by MacBook Pro on 26/01/2021.
//

import Foundation

struct Item {
    let id: UUID
    var name: String
    var photoPath: String?
    
    init(id: UUID?, name: String, photoPath: String?) {
        self.id = id ?? UUID()
        self.name = name
        self.photoPath = photoPath
    }
}
