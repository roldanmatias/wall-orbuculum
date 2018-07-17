import Foundation
import UIKit

protocol GameDelegate: class {
    func gameSpriteWalk(position: BoardPosition)
    func gameShotResult(points: Int, win: Bool)
    func gameOver()
}

protocol Game {
    var delegate: GameDelegate? {get set}
    var board: Board {get set}
    var comunicationChannel: Repository {get set}
    func connect(onSuccess: @escaping() -> Void, onError: @escaping(String) -> Void)
    func setupPlayer(name: String)
    func setupBoard(frame: CGRect) -> Board
    func start(onSuccess: @escaping() -> Void, onError: @escaping(String) -> Void)
}
