import Foundation
import UIKit

protocol GameViewModel: class {
    var view: GameView? {get set}
    func viewDidLoad(withBoardContainer boardContainer: UIView)
}
