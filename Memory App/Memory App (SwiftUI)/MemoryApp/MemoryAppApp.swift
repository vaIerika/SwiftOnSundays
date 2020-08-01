//
//  MemoryAppApp.swift
//  MemoryApp
//
//  Created by Valerie 👩🏼‍💻 on 27/07/2020.
//

import SwiftUI

@main
struct MemoryAppApp: App {
    @StateObject var texts = Texts()
    
    var body: some Scene {
        WindowGroup {
            ContentView(items: texts.memoryItems)
        }
    }
}
