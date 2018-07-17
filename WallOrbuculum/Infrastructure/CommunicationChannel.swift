import Foundation
import SwiftSocket

class CommunicationChannel: Repository {
    let client = TCPClient(address: "winter-is-coming.mysterium.network", port: 8765)
    let connectionTimeout = 5
    var timer = Timer()
    
    func connect(onSuccess: @escaping() -> Void, onError: @escaping(String) -> Void) {
        switch client.connect(timeout: connectionTimeout) {
        case .success:
            onSuccess()
        case .failure(let error):
            onError(error.localizedDescription)
        }
    }
    
    func start(name: String, onSuccess: @escaping() -> Void, onMessageReceived: @escaping(ServerMessage) -> Void, onError: @escaping(String) -> Void) {
        switch client.send(string: "START \(name)\n" ) {
        case .success:
            onSuccess()
            listenServerResponse(onMessageReceived: onMessageReceived)
        case .failure(let error):
            onError(error.localizedDescription)
        }
    }
    
    func shoot(position: BoardPosition) {
        _ = client.send(string: "SHOOT \(position.x) \(position.y)\n" )
    }
    
    func close() {
        client.close()
    }
    
    private func listenServerResponse(onMessageReceived: @escaping(ServerMessage) -> Void) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            if let data = self.client.read(1024*10, timeout: self.connectionTimeout) {
                
                let serverResponse = ServerMessage(messageData: data)
                
                if serverResponse.action == .Lose || serverResponse.win {
                    timer.invalidate()
                }
                
                DispatchQueue.main.async {
                    onMessageReceived(serverResponse)
                }
            }
            else {
                timer.invalidate()
            }
        })
    }
}
