import Foundation
import UIKit

protocol GameView: class {
    func showGameError(error: String)
    func showGameOver()
    func showGameWin(with points: Int)
}
