//
//  ContentView.swift
//  MemoryApp
//
//  Created by Valerie 👩🏼‍💻 on 27/07/2020.
//

import SwiftUI

struct ContentView: View {
    var items: [MemoryItem]
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    NavigationLink(destination: ItemTextView(item: item)) {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.text)
                                .lineLimit(2)
                        }
                    }
                    .padding(.vertical, 10)

                }
            }
            .navigationTitle("Texts to Memorize")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(items: Texts.init().memoryItems)
    }
}
