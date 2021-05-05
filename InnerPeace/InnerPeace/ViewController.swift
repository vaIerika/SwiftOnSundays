//
//  ViewController.swift
//  InnerPeace
//
//  Created by Valerie 👩🏼‍💻 on 05/05/2021.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var quote: UIImageView!

    let quotes = Bundle.main.decode([Quote].self, from: "quotes.json")
    let images = Bundle.main.decode([String].self, from: "pictures.json")
    
    var shareQuote: Quote!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { allowed, error in
            if allowed {
                self.configureAlerts()
            }
        }
    }
    
    func updateQuote() {
        guard let bgImageName = images.randomElement() else {
            fatalError("Unable to read an image.")
        }
        
        background.image = UIImage(named: bgImageName)
        
        guard let selectedQuote = quotes.randomElement() else {
            fatalError("Unable to read an quote.")
        }
        
        shareQuote = selectedQuote
     
        quote.image = render(selectedQuote: selectedQuote)
    }
    
    
    func render(selectedQuote: Quote) -> UIImage {
        let insetAmount: CGFloat = 250
        let drawBounds = quote.bounds.inset(by: UIEdgeInsets(top: insetAmount, left: insetAmount, bottom: insetAmount, right: insetAmount))
        
        /// as large as possible
        var quoteRect = CGRect(
            x: 0,
            y: 0,
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude)
        
        var fontSize: CGFloat = 120
        var font: UIFont!
        
        var attributes: [NSAttributedString.Key: Any]!
        var str: NSAttributedString!
        
        while true {
            font = UIFont(name: "Georgia-Bold", size: fontSize) ?? UIFont.systemFont(ofSize: 120)
            attributes = [.font: font!, .foregroundColor: UIColor.white]
            
            str = NSAttributedString(string: selectedQuote.text, attributes: attributes)
            
            /// `.usesLineFragmentOrigin` - multiple-line alignment
            quoteRect = str.boundingRect(with: CGSize(width: drawBounds.width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
            
            if quoteRect.height > drawBounds.height {
                fontSize -= 4
            } else {
                break
            }
        }
         
        let format = UIGraphicsImageRendererFormat()
        format.opaque = false
        
        let renderer = UIGraphicsImageRenderer(bounds: quoteRect.insetBy(dx: -30, dy: -30), format: format)
        
        return renderer.image { ctx in
            for i in 1...5 {
                ctx.cgContext.setShadow(offset: .zero, blur: CGFloat(i) * 2, color: UIColor.black.cgColor)
                str.draw(in: quoteRect)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateQuote()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateQuote()
    }
    
    func configureAlerts() {
        let center = UNUserNotificationCenter.current()
        
        /// 1. Remove all delivered notifications, and requests
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        
        let shuffled = quotes.shuffled()
        
        for i in 1...7 {
            let content = UNMutableNotificationContent()
            content.title = "Inner Peace"
            content.body = shuffled[i].text
            
            /*
            var dateComponents = DateComponents()
            dateComponents.day = i
            
            if let alertDate = Calendar.current.date(byAdding: dateComponents, to: Date()) {
             */
            
            let alertDate = Date().byAdding(days: i)
            
            var alertComponents = Calendar.current.dateComponents([.day, .month, .year], from: alertDate)
            alertComponents.hour = 10

            /// Good for the real case
            //let trigger = UNCalendarNotificationTrigger(dateMatching: alertComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(i) * 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            //  }
        }
    }
    
    @IBAction func shareTapped(_ sender: UIButton) {
        guard let quote = shareQuote else {
            fatalError("Attempting to share a non-existing quote.")
        }
        
        let ac = UIActivityViewController(activityItems: [quote.shareMessage], applicationActivities: nil)
        ac.popoverPresentationController?.sourceView = sender
        
        present(ac, animated: true)
    }
}

