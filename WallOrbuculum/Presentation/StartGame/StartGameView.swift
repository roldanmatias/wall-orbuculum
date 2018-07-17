import Foundation

protocol StartGameView: class {
    func showConnectionError(error: String)
    func showStartOption()
    func showStartError(error: String)
    func showNewGame(game: Game)
}
