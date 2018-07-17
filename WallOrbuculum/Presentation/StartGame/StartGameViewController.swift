import UIKit

class StartGameViewController: ViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var connectToServerButton: UIButton!
    @IBOutlet weak var startView: UIView!
    
    let startGameViewModel = StartGameViewModelDefault()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startView.isHidden = true
        connectToServerButton.isHidden = false
        nameField.text = ""
        startGameViewModel.view = self
    }
    
    @IBAction func connectToServer(_ sender: Any) {
        startGameViewModel.connect()
    }
    
    @IBAction func startGame(_ sender: Any) {
        startGameViewModel.start(name: nameField.text!)
    }
}

extension StartGameViewController: StartGameView {
    func showConnectionError(error: String) {
        showErrorMessage(error: error)
    }
    
    func showStartOption() {
        startView.isHidden = false
        connectToServerButton.isHidden = true
    }
    
    func showStartError(error: String) {
        showErrorMessage(error: error)
    }
    
    func showNewGame(game: Game) {
        let gameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameViewController") as! GameViewController
        gameViewController.game = game
        self.navigationController?.show(gameViewController, sender: nil)
    }
}
