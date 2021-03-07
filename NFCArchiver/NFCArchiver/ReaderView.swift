//
//  ReaderView.swift
//  NFCArchiver
//
//  Created by Joanna Zatorska on 04/01/2021.
//

import SwiftUI

struct ReaderView: View {
    
    
    var items = [
        Item(name: "Książki", photoPath: nil),
        Item(name: "Zeszyty", photoPath: nil)
    ]
    var body: some View {
        VStack {
            Button("Edit items") {
                //TODO
            }
            Text("Tag id")
            Text("Tag description")
            List(items) { item in
                ItemRow(item: item)
            }
        }
    }
}

struct ItemRow: View {
    var item: Item

    var body: some View {
        Text(item.name)
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderView()
    }
}
