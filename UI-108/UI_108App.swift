//
//  UI_108App.swift
//  UI-108
//
//  Created by にゃんにゃん丸 on 2021/01/22.
//

import SwiftUI

@main
struct UI_108App: App {
    var body: some Scene {
        #if os(iOS)
        WindowGroup {
            ContentView()
        }
        
        #else
        WindowGroup {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        
        #endif
    }
}
