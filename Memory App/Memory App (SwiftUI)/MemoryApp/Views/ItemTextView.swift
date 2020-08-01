//
//  ItemTextView.swift
//  MemoryApp
//
//  Created by Valerie 👩🏼‍💻 on 27/07/2020.
//

import SwiftUI

struct ItemTextView: View {
    @State private var blankCounter = 0
    @State private var containerHeight: CGFloat = 0
    var item: MemoryItem
    
    var text: String {
        item.text
    }
    
    var maxHeight: CGFloat = 0
    
    var body: some View {
            ScrollView(.vertical) {
                VStack {
                    TextView(itemText: text, height: $containerHeight, blankCounter: $blankCounter)
                        .padding(.horizontal, 15)
                        .frame(height: max(containerHeight, 200))
                        .onTapGesture {
                            blankCounter += 1
                        }
                    Text("Good job!")
                        .font(.headline)
                }
                .padding(.bottom, 30)
                .padding(.top, 20)
                .navigationBarTitle(item.title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(false)
                .navigationBarItems(trailing: Button(action: { blankCounter = 0 },
                                                     label: { Text("Restart") })
                )
        }
    }
}

struct ItemTextView_Previews: PreviewProvider {
    static var previews: some View {
        let item = MemoryItem(
            title: "Pledge of Allegiance",
            text: "I pledge allegiance to the flag of the United States of America, and to the republic for which it stands, one nation under God, indivisible, with liberty and justice for all.")
        
        ItemTextView(item: item)
    }
}
