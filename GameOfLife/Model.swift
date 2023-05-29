//
//  Model.swift
//  GameOfLife
//
//  Created by Matrix on 04/03/2023.
//

import Foundation

struct Position: Hashable {
    let row: Int
    let col: Int
}

class Model: ObservableObject {

    @Published var rows: Int
    @Published var columns: Int

    @Published var canEdit = true
    @Published var isRunning = false

    @Published var grid: [[Int]]

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        var temp = [Int]()
        var temp2 = [[Int]]()
        for _ in 0..<columns {
            temp.append(0)
        }
        for _ in 0..<rows {
            temp2.append(temp)
        }
        grid = temp2
    }

    func startTapped() {
        canEdit = false
        isRunning = true
    }

    func stopTapped() {
        isRunning = false
        canEdit = true
    }

    func clearTapped() {
        isRunning = false
        for row in 0..<grid.count {
            for col in 0..<grid[0].count {
                let position = Position(row: row, col: col)
                setCellAtPosition(position: position, value: 0)
            }
        }
    }

    func cellForPosition(position: Position) -> Bool {
        return grid[position.row][position.col] == 1
    }

    func setCellAtPosition(position: Position, value: Int) {
        grid[position.row][position.col] = value
    }

    func toggleCellAtPosition(position: Position) {
        let value = grid[position.row][position.col]
        if value == 0 {
            grid[position.row][position.col] = 1
        } else {
            grid[position.row][position.col] = 0
        }
    }

    func gameOfLife(_ board: inout [[Int]]) {
        var changes = [Position: Int]()
        for row in 0..<board.count {
            for col in 0..<board[0].count {
                let position = Position(row: row, col: col)
                let isAlive = cellForPosition(position: position) == 1
                let liveNeighbourCount = numberOfLiveNeighbours(row: row, col: col)
                if liveNeighbourCount < 2 && isAlive {
                    // Cell dies
                    changes[Position(row: row, col: col)] = 0
                } else if liveNeighbourCount > 1 && liveNeighbourCount < 4 && isAlive {
                    // No change
                } else if liveNeighbourCount > 3 && isAlive {
                    // Cell dies
                    changes[Position(row: row, col: col)] = 0
                } else if liveNeighbourCount == 3 && !isAlive {
                    changes[Position(row: row, col: col)] = 1
                }
            }
        }
        applyChanges(changes: changes)

        func applyChanges(changes: [Position: Int]) {
            for change in changes {
                let position = change.key
                board[position.row][position.col] = change.value
            }
        }

        func cellForPosition(position: Position) -> Int {
            return board[position.row][position.col]
        }

        func numberOfLiveNeighbours(row r: Int, col c: Int) -> Int {
            var count = 0

            let topLeftIndex = Position(row: r - 1, col: c - 1)
            let topIndex = Position(row: r - 1, col: c)
            let topRightIndex = Position(row: r - 1, col: c + 1)
            let middleLeftIndex = Position(row: r, col: c - 1)
            let middleRightIndex = Position(row: r, col: c + 1)
            let bottomLeftIndex = Position(row: r + 1, col: c - 1)
            let bottomIndex = Position(row: r + 1, col: c)
            let bottomRightIndex = Position(row: r + 1, col: c + 1)

            for neighbour in [topLeftIndex, topIndex, topRightIndex, middleLeftIndex, middleRightIndex, bottomLeftIndex, bottomIndex, bottomRightIndex] {
                if neighbour.row >= 0 && neighbour.row < board.count && neighbour.col >= 0 && neighbour.col < board[0].count {
                    if cellForPosition(position: Position(row: neighbour.row, col: neighbour.col)) == 1 {
                        count += 1
                    }
                }
            }
            return count
        }
    }
}
