# Swift on Sundays 
> 
> Repo includes applications, games and editors for iOS & macOS written in Swift. Projects are based on [materials from Paul Hudson](https://www.youtube.com/playlist?list=PLuoeXyslFTuZNAZKB3FAYqiJZKigjC3VG).
>
> To impove skill of integration and have some fun I will write solutions of each project in UIKit and SwiftUI versions.
>

<br/>


## Completion status

Projects                            | UIKit  | SwiftUI
:---                                |  :---: |   :---:
Memory App (iOS)                    |    +   |     +
Inner Peace (iPad)                  |    +   |     +
to be continued...                  |    -   |     -




<br/>

## Inner Peace 

**Discussed topics:**
- Resizing text due to its length 
- Adding a shadow to the text (+ rendering an image)
- Sharing the chosen quote 
- Sending notifications 

<br/>

#### Sending notifications
The same for both frameworks.

#### Resizing Text View with SwiftUI + shadow
Text resizing and adding a shadow tasks are quite easier with SwiftUI then with UIKit.

```
Text(textQuote)
    .font(.system(size: 1000))
    .minimumScaleFactor(0.01)
    .shadow(color: .black, radius: 6, x: 0, y: 3)
```

#### Issue 1. Representable for UIActivityViewController
SwiftUI library doesn't have its own view for sharing activity yet.

> **Solution:** Use the functionality of the `UIActivityViewController` with a `UIViewControllerRepresentable`.


<br/>

## Memory App 

<br/>

#### Issue 1. Attributes of a String in SwiftUI
 SwiftUI's **Text** view doesn't `attributesText` 💔. That's why I had to use UIKit's **UITextView()**

> **Solution:** Thanks to the protocol `UIViewRepresentable` we can present UI elements from UIKit as views. It is a bridge between two frameworks.


#### Issue 2. Sizes of the new-born View 
A size of the new *View* made from UIKit cannot be recognized fast and automatically when it is used as a part of the view's body. Specially if it is inside the **ScrollView()**, it takes not the space it is needed. 
> **Solution:** If you need a specific size, just declare it with `.frame` modifier.  However if the size differs and depends on the content, use a `@Binding` property wrapper for the height of the *UIViewType*. It is important to assign it in the main thread. And then use its value for a `.frame` modifier.


<br/>

---



## Note
Since I am fascinated by SwiftUI and at the same time I understand an influence UIKit, I wrote projects [by Paul Hudson](https://www.youtube.com/playlist?list=PLuoeXyslFTuZNAZKB3FAYqiJZKigjC3VG) in both frameworks . I'd appreciate any features and improvement you have to share. Feel free to [reach me out](mailto:Valerika.Hello@gmail.com)  😊

<br/>

