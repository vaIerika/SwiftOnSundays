//
//  MemoryItem.swift
//  MemoryApp
//
//  Created by Valerie 👩🏼‍💻 on 27/07/2020.
//

import Foundation

struct MemoryItem: Codable, Identifiable {
    var id: String { title }
    var title: String
    var text: String
}
