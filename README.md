# SwiftUIIntroView

SwiftUI view for showing introduction views for new users/update users.

this is very small enhancement for storing viewed page information with using AppStorage.

## SwiftIntroView in 30 sec.
gif will be added

## How to install
use Swift Package manager with URL: https://github.com/tyagishi/SwiftUIIntroView

For the moment, please specify "main" branch

## How to use
minimum example (which is used for above gif file).
~~~
//
//  ContentView.swift
//  IntroView
//
//  Created by Tomoaki Yagishita on 2020/10/18.
//

import SwiftUI
import SwiftIntroView

struct ContentView: View {
  // for demo
  @AppStorage(wrappedValue: "", SwiftUIIntroView.AppStorageKey.lastShownPage.rawValue) var lastShownPageName: String

  @State var index:Int = 5
  @State private var present:Bool = false
  
  @StateObject var introPages = SwiftIntroPages( [
    SwiftIntroPage(name: "page1") { AnyView(Text("Page1")) },
    SwiftIntroPage(name: "page2") { AnyView(Text("Page2")) },
    SwiftIntroPage(name: "page3") { AnyView( Image(systemName: "gear").resizable().scaledToFit())},
    SwiftIntroPage(name: "page4", content: {
      AnyView(
        ZStack {
          Color.green
          VStack {
            Image(systemName: "gear")
            Text("page4")
          }
        }
      )
    })
  ])

  var body: some View {
    VStack {
      List {
        HStack {
          Text("prepared intro pages")
          Button(action: {self.addNewPage()}
                 , label: {
                  Text("Add")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5)
                              .fill(Color.gray)
                    )
          })
        }
        HStack {
          ForEach(introPages.introPages) { pageInfo in
            Text("\(pageInfo.id)")
              .font(.footnote)
              .padding(5)
          }
        }
      }
      Spacer()
      
      Button(action: {
              present.toggle()
      }, label: {
        Text("start intro")
          .padding()
          .background(RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray)
          )
      })
      .disabled(introPages.validViewInfoExist == false)
      .padding()


      Spacer()
      
      List {
        Text("stored page info : \(lastShownPageName)")
        Button("reset appStorage") {
          lastShownPageName = ""
        }
      }
      .padding(.bottom, 50)
    }
    .fullScreenCover(isPresented: $present, content: {
      SwiftUIIntroView(isPresented: $present, introPages)
    })
  }
  
  func addNewPage() {
    let swiftIntroPage = SwiftIntroPage(name: "page\(index)", content: { AnyView( Text("page\(index)") ) } )
    introPages.addIntroPage(swiftIntroPage)
    index = index + 1
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
~~~


## reserved resource
- Key "SwiftUIIntroViewLastShownPage" for AppStorage is used.

## comments are appreciated
comments are really appreciated.

