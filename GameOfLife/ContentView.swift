//
//  ContentView.swift
//  GameOfLife
//
//  Created by Matrix on 04/03/2023.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var model: Model

    var body: some View {
        VStack(spacing: 32) {
            GridView()
            Button(action: {
                model.startTapped()
            }, label: {
                Text("Start")
            })
            Button(action: {
                model.stopTapped()
            }, label: {
                Text("Stop")
            })
            Button(action: {
                model.clearTapped()
            }, label: {
                Text("Clear")
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Model(rows: 20, columns: 20)
        ContentView()
            .environmentObject(model)
    }
}
