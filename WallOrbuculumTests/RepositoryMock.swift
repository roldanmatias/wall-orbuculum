import Foundation
@testable import WallOrbuculum

class RepositoryMock: Repository {
    var connectCalledCount = 0
    var startCalledCount = 0
    var shotCalledCount = 0
    var closeCalledCount = 0
    var isError = false
    var message: ServerMessage?
    
    func connect(onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        connectCalledCount += 1
        
        if isError {
            onError("Error")
        }
        else {
            onSuccess()
        }
    }
    
    func start(name: String, onSuccess: @escaping () -> Void, onMessageReceived: @escaping (ServerMessage) -> Void, onError: @escaping (String) -> Void) {
        startCalledCount += 1
        
        if isError {
            onError("Error")
        }
        else {
            onSuccess()
        }
        
        if let message = message {
            onMessageReceived(message)
        }
    }
    
    func shoot(position: BoardPosition) {
        shotCalledCount += 1
    }
    
    func close() {
        closeCalledCount += 1
    }
    
}
