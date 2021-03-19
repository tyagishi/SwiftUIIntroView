//
//  SDSIntroPages.swift
//
//  Created by : Tomoaki Yagishita on 2020/10/21
//  © 2020  SmallDeskSoftware
//

import Foundation
import SwiftUI

public class SwiftIntroPages: ObservableObject {
  @AppStorage(wrappedValue: "", SwiftUIIntroView.AppStorageKey.lastShownPage.rawValue) var lastShownPageName: String
  @Published public var introPages:[SwiftIntroPage]
  
  public init(_ introViewInfoList: [SwiftIntroPage]) {
    self.introPages = introViewInfoList
  }
  
  public func addIntroPage(_ newPage: SwiftIntroPage) {
    self.introPages.append(newPage)
  }
  
  public var validViewInfoExist:Bool {
    return validViewInfoList.count > 0
  }
  
  public var validViewInfoList:[SwiftIntroPage] {
    if lastShownPageName == "" {
      return introPages
    }
    let retList = introPages.drop(while: {$0.id != lastShownPageName}).dropFirst()
    return Array(retList)
  }
}

public struct SwiftIntroPage : Identifiable {
  public let id: String // page name, should be unique
  let content: () -> AnyView

  public init(name: String, @ViewBuilder content: @escaping () -> AnyView) {
    self.id = name
    self.content = content
  }
}

