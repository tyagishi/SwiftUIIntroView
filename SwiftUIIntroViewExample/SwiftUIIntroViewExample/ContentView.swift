//
//  ContentView.swift
//  IntroView
//
//  Created by Tomoaki Yagishita on 2020/10/18.
//

import SwiftUI
import SwiftUIIntroView


struct ContentView: View {
  // for demo
  @AppStorage(wrappedValue: "", SwiftUIIntroView.AppStorageKey.lastShownPage.rawValue) var lastShownPageName: String

  @State var index:Int = 5
  @State private var present:Bool = false
  
  @StateObject var introPages = SwiftIntroPages( [
    SwiftIntroPage(name: "page1") {
      AnyView(
        ZStack {
          Color.red
          Text("Page1")
        }
      )},
    SwiftIntroPage(name: "page2") { AnyView(
      ZStack {
        Color.green
        Text("Page2")
      }
    ) },
    SwiftIntroPage(name: "page3") { AnyView( Image(systemName: "gear").resizable().scaledToFit())},
    SwiftIntroPage(name: "page4", content: {
      AnyView(
        ZStack {
          Color.gray
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
          Text("existing intro pages")
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
        Text("Start IntroView")
          .font(.largeTitle)
          .padding()
          .background(RoundedRectangle(cornerRadius: 25)
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

