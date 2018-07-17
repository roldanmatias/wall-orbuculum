import Foundation
import UIKit

class StartGameViewModelDefault {
    weak var view: StartGameView?
    private var game: Game
    private var horizontalCells = 30
    private var verticalCells = 10
    
    init() {
        let comunicationChannel = CommunicationChannel()
        let board = WallOrbuculumBoard(WithHorizontalCells: horizontalCells, andVerticalCells: verticalCells)
        game = WallOrbuculum(comunicationChannel: comunicationChannel, board: board)
    }
}

extension StartGameViewModelDefault: StartGameViewModel {
    func connect() {
        game.connect(onSuccess: {
            self.view?.showStartOption()
        }) { (error) in
            self.view?.showConnectionError(error: error)
        }
    }
    
    func start(name: String?) {
        guard let name = name, name.count > 0 else {
            view?.showStartError(error: "Missing player name")
            return
        }
        self.game.setupPlayer(name: name)
        self.view?.showNewGame(game: self.game)
    }
}
