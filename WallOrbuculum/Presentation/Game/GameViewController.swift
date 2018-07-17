import UIKit

class GameViewController: ViewController {
    let viewModel = GameViewModelDefault()
    var game: Game?
    
    @IBOutlet weak var boardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.game = game
        viewModel.viewDidLoad(withBoardContainer: boardView)
    }
}

extension GameViewController: GameView {
    func showGameWin(with points: Int) {
        showMessage(message: "You won \(points) points", withAction: UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
    }
    
    func showGameError(error: String) {
        showErrorMessage(error: error)
    }
    
    func showGameOver() {
        showMessage(message: "Game Over", withAction: UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
    }
}
