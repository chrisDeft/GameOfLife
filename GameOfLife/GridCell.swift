//
//  GridCell.swift
//  GameOfLife
//
//  Created by Matrix on 04/03/2023.
//

import SwiftUI

struct GridCell: View {

    @EnvironmentObject var model: Model

    var row: Int
    var col: Int

    //@State var size = 10

    var body: some View {
        Group {
            let isAlive = model.cellForPosition(position: Position(row: row, col: col))
            if isAlive {
                Image(systemName: "squareshape.fill")
            } else {
                Image(systemName: "squareshape")
            }
        }
        .onTapGesture {
            if model.canEdit {
                model.toggleCellAtPosition(position: Position(row: row, col: col))
            }
        }
    }
}

//struct GridCell_Previews: PreviewProvider {
//    static var previews: some View {
//        let model = Model()
//        GridCell(row: 0, col: 0)
//            .environmentObject(model)
//    }
//}
