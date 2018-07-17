import Foundation

protocol StartGameViewModel {
    var view: StartGameView? {get set}
    func connect()
    func start(name: String?)
}
