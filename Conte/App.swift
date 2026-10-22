//
//  App.swift
//  Liceu
//
//  Created by Thiago Campos on 18/10/26.
//

import SwiftData
import SwiftUI

@main struct Conte: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Counter.self])
    }
}
