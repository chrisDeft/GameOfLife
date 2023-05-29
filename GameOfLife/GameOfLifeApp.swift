//
//  GameOfLifeApp.swift
//  GameOfLife
//
//  Created by Matrix on 04/03/2023.
//

import SwiftUI

@main
struct GameOfLifeApp: App {

    @StateObject var model = Model(rows: 30, columns: 30)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
