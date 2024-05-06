//
//  HelloCoreDataApp.swift
//  HelloCoreData
//
//  Created by Pedro Acevedo on 06/05/24.
//

import SwiftUI

@main
struct HelloCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
