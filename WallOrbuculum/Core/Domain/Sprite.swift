import Foundation
import UIKit

protocol Sprite {
    var name: String {get set}
    func move(to position: CGPoint)
}
