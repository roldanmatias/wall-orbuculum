import Foundation
import UIKit
@testable import WallOrbuculum

class BoardSpy: Board {
    var isBoardCreated: Bool = false
    var horizontalCells: Int = 0
    var verticalCells: Int = 0
    var delegate: BoardDelegate?
    var createCalledCount = 0
    var createCellCalledCount = 0
    var addCalledCount = 0
    var moveSpriteCalledCount = 0
    var removeSpriteCalledCount = 0
    var resetCalledCount = 0
    var isSpriteOnBoardCalledCount = 0
    
    init(WithHorizontalCells horizontalCells: Int, andVerticalCells verticalCells: Int) {
        self.horizontalCells = horizontalCells
        self.verticalCells = verticalCells
    }
    
    func create(frame: CGRect) {
        createCalledCount += 1
    }
    
    func createCell(_ cellSize: CGSize, _ indexX: Int, _ indexY: Int) -> UIView {
        createCellCalledCount += 1
        return UIView(frame: CGRect.zero)
    }
    
    func add(sprite: Sprite, inPosition position: BoardPosition) {
        addCalledCount += 1
    }
    
    func moveSprite(name: String, toPosition position: BoardPosition) {
        moveSpriteCalledCount += 1
    }
    
    func removeSprite(name: String) {
        removeSpriteCalledCount += 1
    }
    
    func isSpriteOnBoard(name: String) -> Bool {
        isSpriteOnBoardCalledCount += 1
        return false
    }
    
    func reset() {
        resetCalledCount += 1
    }
}
