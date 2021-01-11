//
//  ContentView.swift
//  NFCArchiver
//
//  Created by Joanna Zatorska on 04/01/2021.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
        WriterView()
            .tabItem {
              VStack {
                Image(systemName: "")
                Text("Visitors")
              }
            }
          ReaderView()
            .tabItem {
              VStack {
                Image(systemName: "lock")
                Text("Admin")
              }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
