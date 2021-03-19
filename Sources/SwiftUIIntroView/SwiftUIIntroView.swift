//
//  SwiftIntroView.swift
//
//  Created by : Tomoaki Yagishita on 2020/10/21
//  © 2020  SmallDeskSoftware
//

import SwiftUI


public struct SwiftUIIntroView : View {
    public enum AppStorageKey: String {
        case lastShownPage = "SwiftUIIntroViewLastShownPage"
    }
    
    @AppStorage(wrappedValue: "", AppStorageKey.lastShownPage.rawValue) var lastShownPageName: String
    @Binding var present:Bool
    
    public let introPages: SwiftIntroPages
    
    public init(isPresented: Binding<Bool>, _ introPages: SwiftIntroPages) {
        #if os(iOS)
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.3)
        #endif
        self._present = isPresented
        self.introPages = introPages
    }
    
    public var body: some View {
        ZStack {
            #if os(iOS)
            independentTabView
                .tabViewStyle(PageTabViewStyle())
            #elseif os(macOS)
            independentTabView
                .tabViewStyle(DefaultTabViewStyle())
            #endif
            VStack { // for later/close button
                Spacer()
                HStack {
                    Button("later") {
                        // user can come back to same intro
                        present.toggle()
                    }
                    .padding(.leading, 30)
                    Spacer()
                    Button("close") {
                        present.toggle()
                        // save the page info
                        lastShownPageName = introPages.validViewInfoList.last?.id ?? ""
                    }
                    .padding(.trailing, 20)
                }
                .padding(.bottom, 10)
            }
        }
    }
    
    var independentTabView: some View {
        TabView {
            ForEach(introPages.validViewInfoList) { viewInfo in
                viewInfo.content()
                    .tabItem { Text(viewInfo.id) }
            }
        }
    }
    
}

struct IntroViews_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIIntroView(isPresented: .constant(true),  SwiftIntroPages([SwiftIntroPage(name: "view1", content: { AnyView(Text("test"))})]))
    }
}
