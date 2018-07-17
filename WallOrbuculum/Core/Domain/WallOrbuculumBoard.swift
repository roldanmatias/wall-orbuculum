import Foundation
import UIKit

class WallOrbuculumBoard: UIView {
    weak var delegate: BoardDelegate?
    var horizontalCells: Int = 0
    var verticalCells: Int = 0
    var sprites = [String: Sprite]()
    var isBoardCreated = false
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(WithHorizontalCells horizontalCells: Int, andVerticalCells verticalCells: Int) {
        super.init(frame: CGRect.zero)
        self.horizontalCells = horizontalCells
        self.verticalCells = verticalCells
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
    }
    
    private func transform(boardPosition: BoardPosition) -> CGPoint {
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        
        if horizontalCells > 0 {
            x = CGFloat(boardPosition.x)*frame.width/CGFloat(horizontalCells)
        }
        
        if verticalCells > 0 {
            y = CGFloat(boardPosition.y)*frame.height/CGFloat(verticalCells)
        }
        
        return CGPoint(x: x, y: y)
    }
    
    private func transform(point: CGPoint) -> BoardPosition {
        if frame.width > 0 && frame.height > 0 {
            let horizontal = Int(point.x*CGFloat(horizontalCells)/frame.width)
            let vertical = Int(point.y*CGFloat(verticalCells)/frame.height)
            
            return BoardPosition(x: horizontal, y: vertical)
        }
        else {
            return BoardPosition(x: 0, y: 0)
        }
    }
    
    @objc private func tapped(sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self)
        let position = transform(point: tapLocation)
        delegate?.boardDidSelectPosition(position: position)
    }
}

extension WallOrbuculumBoard: Board {
    func create(frame: CGRect) {
        self.frame = frame
        isBoardCreated = true
        let cellSize = CGSize(width: frame.width/CGFloat(horizontalCells), height: frame.height/CGFloat(verticalCells))
        
        for indexVertical in 0...verticalCells {
            for indexHorizontal in 0...horizontalCells {
                addSubview( createCell(cellSize, indexHorizontal, indexVertical) )
            }
        }
    }
    
    func createCell(_ cellSize: CGSize, _ indexX: Int, _ indexY: Int) -> UIView {
        let cell = UIView(frame: CGRect(x: CGFloat(indexX) * cellSize.width,
                                        y: CGFloat(indexY) * cellSize.height,
                                        width: cellSize.width,
                                        height: cellSize.height))
        
        if (indexY + indexX) % 2 == 0 {
            cell.backgroundColor = UIColor.white
        }
        else {
            cell.backgroundColor = UIColor.lightGray
        }
        
        return cell
    }
    
    func add(sprite: Sprite, inPosition position: BoardPosition) {
        if let sprite = sprite as? UIView {
            let transformedPosition = transform(boardPosition: position)
            sprite.frame = CGRect(x: transformedPosition.x, y: transformedPosition.y, width: sprite.frame.width, height: sprite.frame.height)
            addSubview(sprite)
        }
        
        sprites[sprite.name] = sprite
    }
    
    func moveSprite(name: String, toPosition position: BoardPosition) {
        if let sprite = sprites[name] {
            sprite.move(to: transform(boardPosition: position))
        }
    }
    
    func isSpriteOnBoard(name: String) -> Bool {
        return sprites[name] != nil
    }
    
    func removeSprite(name: String) {
        if let sprite = sprites[name] {
            if let sprite = sprite as? UIView {
                sprite.removeFromSuperview()
            }
            sprites.removeValue(forKey: name)
        }
    }
    
    func reset() {
        _ = sprites.mapValues {
            if let sprite = $0 as? UIView {
                sprite.removeFromSuperview()
            }
        }
        sprites.removeAll()
    }
}
