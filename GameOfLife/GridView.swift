//
//  GridView.swift
//  GameOfLife
//
//  Created by Matrix on 04/03/2023.
//

import SwiftUI

struct GridView: View {

    @EnvironmentObject var model: Model

    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        GridStack(grid: model.grid) { row, col in
            GridCell(row: row, col: col)
                //.frame(width: 10, height: 10)
        }
        .onReceive(timer) { _ in
            print("Timer fired")
            if model.isRunning {
                model.gameOfLife(&model.grid)
            }
        }
    }
}

struct GridStack<Content: View>: View {

    @EnvironmentObject var model: Model

    @State var grid: [[Int]]
    let content: (Int, Int) -> Content

    var body: some View {
        ScrollView([.vertical,.horizontal]) {
            VStack(spacing: 0) {
                ForEach(0 ..< grid.count, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< grid[0].count, id: \.self) { column in
                            content(row, column)
                        }
                    }
                }
            }
        }
    }

    init(grid: [[Int]], @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.grid = grid
        self.content = content
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Model(rows: 20, columns: 20)
        GridView()
            .environmentObject(model)
    }
}
