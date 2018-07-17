import UIKit

class ViewController: UIViewController {
    private let messageTitle = "Wall Orbuculum"
    
    func showErrorMessage(error: String) {
        let alertController = UIAlertController(title: messageTitle, message: error, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showMessage(message: String, withAction action: UIAlertAction) {
        let alertController = UIAlertController(title: messageTitle, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
