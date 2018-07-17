import Foundation
import UIKit

class Zombie: UIView {
    var name: String
    
    private let animationDuration = 1.0
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(name: String, frame: CGRect) {
        self.name = name
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        let zombieImageView = UIImageView(frame: bounds)
        zombieImageView.image = UIImage(named: "zombie")
        zombieImageView.contentMode = .scaleAspectFit
        addSubview(zombieImageView)
    }
}

extension Zombie: Sprite {
    func move(to position: CGPoint) {
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.frame = CGRect(x: position.x, y: position.y, width: self.frame.width, height: self.frame.height)
        },completion: nil)
    }
}
