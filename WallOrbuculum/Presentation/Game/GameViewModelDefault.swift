import Foundation
import UIKit

class GameViewModelDefault {
    weak var view: GameView?
    var game: Game?
}

extension GameViewModelDefault: GameViewModel {
    func viewDidLoad(withBoardContainer boardContainer: UIView) {
        if let game = game {
            self.game?.delegate = self
            
            let board = game.setupBoard(frame: boardContainer.bounds)
            boardContainer.addSubview(board as! UIView)
            
            game.start(onSuccess: {
                
            }) { (error) in
                self.view?.showGameError(error: error)
            }
        }
    }
}

extension GameViewModelDefault: GameDelegate {
    func gameSpriteWalk(position: BoardPosition) {
        //This event is just for testing purpose
    }
    
    func gameShotResult(points: Int, win: Bool) {
        if win {
            view?.showGameWin(with: points)
        }
    }
    
    func gameOver() {
        self.view?.showGameOver()
    }
}
