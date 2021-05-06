//
//  Quote.swift
//  InnerPeace
//
//  Created by Valerie 👩🏼‍💻 on 05/05/2021.
//

import Foundation

struct Quote: Codable {
    var text: String
    var author: String
    
    var shareMessage: String {
       "\"\(text)\" - \(author)"
    }
}
