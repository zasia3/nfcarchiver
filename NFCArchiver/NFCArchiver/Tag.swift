//
//  Tag.swift
//  NFCArchiver
//
//  Created by MacBook Pro on 26/01/2021.
//

import Foundation

struct Tag {
    let id: UUID
    var description: String?
    var items: [Item] = []
    
    init(id: UUID? = nil) {
        self.id = id ?? UUID()
    }
}
