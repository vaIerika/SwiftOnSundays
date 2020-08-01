//
//  TextView+UIViewRepresentable.swift
//  MemoryApp
//
//  Created by Valerie 👩🏼‍💻 on 31/07/2020.
//

import UIKit
import SwiftUI

struct TextView: UIViewRepresentable {
    var itemText: String
    @Binding var height: CGFloat
    @Binding var blankCounter: Int
    
    var output = UITextView()
    
    private let visibleText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.black
    ]
    
    private let invisibleText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.clear,
        .strikethroughStyle: 1,
        .strikethroughColor: UIColor.black
    ]
    
    func makeUIView(context: Context) -> some UITextView {
        let view = UITextView()

        view.attributedText = showText(for: itemText)
        view.isEditable = false
        view.isUserInteractionEnabled = false
        
        // to communicate with the model
        view.delegate = context.coordinator

        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        output.text = itemText
        uiView.attributedText = showText(for: itemText)
        
        let fixedWidth = uiView.frame.size.width
        let newSize = uiView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))

        DispatchQueue.main.async {
            self.height = newSize.height
        }
    }
    
    // MARK: - For communication with data in SwiftUI
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var control: TextView
        
        init(_ control: TextView) {
            self.control = control
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.control.output.text = textView.text
                self.control.output.attributedText = textView.attributedText
            }
        }
    }
    
    private func showText(for text: String) -> NSAttributedString {
        let words = text.components(separatedBy: " ")
        let output = NSMutableAttributedString()
        
        let space = NSAttributedString(string: " ", attributes: visibleText)
        
        for (index, word) in words.enumerated() {
            if index < blankCounter {
                let attributedWord = NSAttributedString(string: word, attributes: visibleText)
                output.append(attributedWord)
            } else {
                var strippedWord = word
                var punctuation: String?
                
                if ".,;:-!?".contains(word.last!) {
                    punctuation = String(strippedWord.removeLast())
                }
                
                let attributedWord = NSAttributedString(string: strippedWord, attributes: invisibleText)
                output.append(attributedWord)
                
                if let symbol = punctuation {
                    let attributedPunctuation = NSAttributedString(string: symbol, attributes: visibleText)
                    output.append(attributedPunctuation)
                }
            }
            output.append(space)
        }
        return output
    }
}

