//
//  ContentView.swift
//  InnerPeace
//
//  Created by Valerie 👩🏼‍💻 on 06/05/2021.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    private let quotes = Bundle.main.decode([Quote].self, from: FileName.quotes.rawValue)
    private let images = Bundle.main.decode([String].self, from: FileName.pictures.rawValue)
    
    @State private var bgImageName: String
    @State private var textQuote: String
    @State private var shareQuote = false
    
    init() {
        _bgImageName = State(initialValue: images.shuffled()[0])
        _textQuote = State(initialValue: quotes.shuffled()[0].text)
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                
                Image(bgImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                Text(textQuote)
                    .font(.system(size: 1000))
                    .minimumScaleFactor(0.01)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 6, x: 0, y: 3)
                    .padding(40)
            }
        }
        .ignoresSafeArea()
        .overlay(
            Button(action: {
                shareQuote = true
            }) {
                Image(systemName: "square.and.arrow.up.on.square")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Circle().fill(Color.black.opacity(0.3)))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(40)
        )
        .sheet(isPresented: $shareQuote) {
            ShareSheetRepresentable(activityItems: [textQuote])
        }
        .onTapGesture { updateQuote() }
        .onAppear(perform: sendNotifications)
    }
    
    private func updateQuote() {
        bgImageName = images.randomElement() ?? images[0]
        textQuote = quotes.randomElement()?.text ?? quotes[0].text
    }
    
    private func sendNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { allowed, error in
            if allowed {
                configureAlerts()
            }
        }
    }
    
    private func configureAlerts() {
        let center = UNUserNotificationCenter.current()
        
        /// Remove all delivered notifications, and requests
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        
        let shuffled = quotes.shuffled()
        
        for i in 1...7 {
            let content = UNMutableNotificationContent()
            content.title = "Inner Peace"
            content.body = shuffled[i].text
            
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
        }
    }
}

fileprivate enum FileName: String {
    case quotes = "quotes.json"
    case pictures = "pictures.json"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
