//
//  Store.swift
//  NFCArchiver
//
//  Created by MacBook Pro on 04/03/2021.
//

import Foundation

protocol TagsStore {
    func saveTag(_tag: Item)
    func getTag(uuid: UUID) -> Item?
}

class SimpleStore: TagsStore {
    func saveTag(_tag: Item) {
        
    }
    
    func getTag(uuid: UUID) -> Item? {
        return nil
    }

}
