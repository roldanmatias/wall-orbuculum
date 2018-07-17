import Foundation
import UIKit

public struct BoardPosition {
    let x: Int
    let y: Int
}

protocol BoardDelegate: class {
    func boardDidSelectPosition(position: BoardPosition)
}

protocol Board {
    var delegate: BoardDelegate? {get set}
    var horizontalCells: Int {get set}
    var verticalCells: Int {get set}
    var isBoardCreated: Bool {get set}
    func create(frame: CGRect)
    func createCell(_ cellSize: CGSize, _ indexX: Int, _ indexY: Int) -> UIView
    func add(sprite: Sprite, inPosition position: BoardPosition)
    func moveSprite(name: String, toPosition position: BoardPosition)
    func removeSprite(name: String)
    func isSpriteOnBoard(name: String) -> Bool
    func reset()
}
