import Foundation

enum MessageAction: String {
    case Walk = "WALK"
    case Boom = "BOOM"
    case Lose = "LOSE"
    case Unknown = "Unknown"
}

class ServerMessage {
    var action = MessageAction.Unknown
    var zombie: String?
    var x: Int?
    var y: Int?
    var points = 0
    var win = false
    
    convenience init(messageData: [UInt8]) {
        let message = String(bytes: messageData, encoding: .utf8)
        self.init(message: message ?? "")
    }
    
    init(message: String) {
        print("response: " + message)
        let messageComponents = message.replacingOccurrences(of: "\n", with: " ").split(separator: " ")
        if messageComponents.count > 1 {
            
            if let messageAction = MessageAction(rawValue: String(messageComponents[0])) {
                action = messageAction
                switch action {
                    
                case .Walk:
                    if messageComponents.count == 4 {
                        zombie = String(messageComponents[1])
                        x = Int(messageComponents[2]) ?? 0
                        y = Int(messageComponents[3]) ?? 0
                    }
                    
                case .Boom:
                    if messageComponents.count > 3 {
                        points = Int(messageComponents[2]) ?? 0
                        zombie = String(messageComponents[3])
                        
                        win = messageComponents.count > 4 && messageComponents[4] == "WIN"
                    }
                    
                case .Lose:
                    if messageComponents.count > 1 {
                        zombie = String(messageComponents[1])
                    }
                    
                case .Unknown:
                    print("Unknown message")
                }
            }
        }
    }
}
