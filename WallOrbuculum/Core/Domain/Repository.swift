import Foundation

protocol Repository {
    func connect(onSuccess: @escaping() -> Void, onError: @escaping(String) -> Void)
    func start(name: String, onSuccess: @escaping() -> Void, onMessageReceived: @escaping(ServerMessage) -> Void, onError: @escaping(String) -> Void)
    func shoot(position: BoardPosition)
    func close()
}
