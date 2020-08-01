//
//  Texts.swift
//  MemoryApp
//
//  Created by Valerie 👩🏼‍💻 on 27/07/2020.
//

import Foundation

class Texts: ObservableObject {
    @Published var memoryItems: [MemoryItem]
    
    init() {
        memoryItems = []
        
        if let data = loadFile() {
            let decoder = JSONDecoder()
            
            guard let savedItems = try? decoder.decode([MemoryItem].self, from: data) else {
                fatalError("Failed to decode JSON")
            }
            memoryItems = savedItems
        }
    }
    
    private func loadFile() -> Data? {
        guard let url = Bundle.main.url(forResource: "MemoryItems", withExtension: "json") else {
            fatalError("Can't find JSON")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Unable to load JSON")
        }
        return data
    }
}
