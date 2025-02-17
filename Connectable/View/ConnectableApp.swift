//
//  ConnectableApp.swift
//  Connectable
//
//  Created by 구태호 on 2/17/25.
//

import SwiftUI
import SoyBeanUI

@main
struct ConnectableApp: App {
    init() {
        print(Font.registerFonts())
    }
    
    var body: some Scene {
        WindowGroup {
            ClientView()
        }
    }
}
