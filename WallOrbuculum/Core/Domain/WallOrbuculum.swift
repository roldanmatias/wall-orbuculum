import Foundation
import UIKit

class WallOrbuculum: Game {
    weak var delegate: GameDelegate?
    var board: Board
    var comunicationChannel: Repository
    
    private var playerName: String?
    
    init(comunicationChannel: Repository, board: Board) {
        self.comunicationChannel = comunicationChannel
        self.board = board
        self.board.delegate = self
    }
    
    func connect(onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        comunicationChannel.connect(onSuccess: onSuccess, onError: onError)
    }
    
    func setupPlayer(name: String) {
        playerName = name
    }
    
    func setupBoard(frame: CGRect) -> Board {
        if board.isBoardCreated {
            board.reset()
        }
        else {
            board.create(frame: frame)
        }
        
        return board
    }
    
    func start(onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        if let playerName = playerName {
            comunicationChannel.start(name: playerName, onSuccess: {
                onSuccess()
            }, onMessageReceived: { (message) in
                self.messageReceived(message: message)
            }, onError: onError)
        } else {
            onError("Missing player name")
        }
    }
    
    private func messageReceived(message: ServerMessage) {
        switch message.action {
        case .Boom:
            delegate?.gameShotResult(points: message.points, win: message.win)
        case .Lose:
            comunicationChannel.close()
            delegate?.gameOver()
        case .Unknown:
            print("Message unknown")
        case .Walk:
            let position = BoardPosition(x: message.x ?? 0, y: message.y ?? 0)
            walkSprite(name: message.zombie, position: position)
        }
    }
    
    private func walkSprite(name: String?, position: BoardPosition) {
        if let name = name {
            if board.isSpriteOnBoard(name: name) {
                board.moveSprite(name: name, toPosition: position)
                delegate?.gameSpriteWalk(position: position)
            }
            else {
                addSpriteToBoard(name: name, position: position)
            }
        }
    }
    
    private func addSpriteToBoard(name: String, position: BoardPosition) {
        let sprite = Zombie(name: name, frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        board.add(sprite: sprite, inPosition: position)
    }
}

extension WallOrbuculum: BoardDelegate {
    func boardDidSelectPosition(position: BoardPosition) {
        comunicationChannel.shoot(position: position)
    }
}
