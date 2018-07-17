import XCTest
@testable import WallOrbuculum

class WallOrbuculumTests: XCTestCase {
    
    let repository = RepositoryMock()
    var game: Game!
    var isSuccess = false
    var isError = false
    var points = 0
    var isWin = false
    var isGameOver = false
    var isWalking = false
    
    var boardContainer = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let board = BoardSpy(WithHorizontalCells: 10, andVerticalCells: 30)
    
    //MARK: Tests
    
    func test_Game_Connect_Success_shouldCallOnSuccess() {
        givenAGame()
        
        whenConnect()
        
        XCTAssertTrue(isSuccess)
        XCTAssertFalse(isError)
        XCTAssertTrue(repository.connectCalledCount == 1)
    }
    
    func test_Game_Connect_Error_shouldCallOnError() {
        givenAGameWithErrorRepository()
        
        whenConnect()
        
        XCTAssertTrue(isError)
        XCTAssertFalse(isSuccess)
        XCTAssertTrue(repository.connectCalledCount == 1)
    }
    
    func test_Game_SetupBoard_shouldCallBoardCreate() {
        givenAGame()
        
        whenSetupBoard()
        
        XCTAssertTrue(board.createCalledCount == 1)
    }
    
    func test_Game_Start_Success_shouldCallOnSuccess() {
        givenAGame()
        
        whenStart()
        
        XCTAssertTrue(isSuccess)
        XCTAssertFalse(isError)
        XCTAssertTrue(repository.startCalledCount == 1)
    }
    
    func test_Game_Start_Error_shouldCallOnError() {
        givenAGameWithErrorRepository()
        
        whenStart()
        
        XCTAssertTrue(isError)
        XCTAssertFalse(isSuccess)
        XCTAssertTrue(repository.startCalledCount == 1)
    }
    
    func test_Game_WalkMessage_shouldWalk() {
        givenAGameWithWalkMessage()
        
        whenStart()
        
        XCTAssertFalse(isWin)
        XCTAssertFalse(isGameOver)
        XCTAssertTrue(isWalking)
    }
    
    func test_Game_Shot_Not_Accurate_shouldNotGetPoints() {
        givenAGameWithShotNotAccurateMessage()
        
        whenShoot()
        
        XCTAssertTrue(points == 0)
        XCTAssertFalse(isWin)
        XCTAssertFalse(isGameOver)
    }
    
    func test_Game_Shot_Accurate_shouldGetPointsAndWin() {
        givenAGameWithShotAccurateMessage()
        
        whenShoot()
        
        XCTAssertTrue(points > 0)
        XCTAssertTrue(isWin)
        XCTAssertFalse(isGameOver)
    }
    
    func test_Game_Lose_shouldGameOver() {
        givenAGameWithLoseMessage()
        
        whenStart()
        
        XCTAssertFalse(isWin)
        XCTAssertTrue(isGameOver)
    }
    
    //MARK: Given
    
    private func givenAGame() {
        isSuccess = false
        isError = false
        points = 0
        isWin = false
        isGameOver = false
        repository.isError = false
        
        game = WallOrbuculum(comunicationChannel: repository, board: board)
        game.delegate = self
        game.setupPlayer(name: "john")
    }
    
    private func givenAnErrorRepository() {
        givenAGame()
        repository.isError = true
    }
    
    private func givenAGameWithErrorRepository() {
        givenAGame()
        repository.isError = true
    }
    
    private func givenAGameWithShotNotAccurateMessage() {
        givenAGame()
        repository.message = ServerMessage(message: "BOOM john 0")
    }
    
    private func givenAGameWithShotAccurateMessage() {
        givenAGame()
        repository.message = ServerMessage(message: "BOOM john 1 night-king\nWIN")
    }
    
    private func givenAGameWithLoseMessage() {
        givenAGame()
        repository.message = ServerMessage(message: "LOSE night-king")
    }
    
    private func givenAGameWithWalkMessage() {
        givenAGame()
        repository.message = ServerMessage(message: "WALK night-king 0 0")
    }
    
    //MARK: When
    
    private func whenConnect() {
        game.connect(onSuccess: {
            self.isSuccess = true
        }) { (error) in
            self.isError = true
        }
    }
    
    private func whenSetupBoard() {
        _ = game.setupBoard(frame: CGRect.zero)
    }
    
    private func whenStart() {
        game.start(onSuccess: {
            self.isSuccess = true
        }) { (error) in
            self.isError = true
        }
    }
    
    private func whenShoot() {
        game.start(onSuccess: {
            self.isSuccess = true
        }) { (error) in
            self.isError = true
        }
    }
}

extension WallOrbuculumTests: GameDelegate {
    func gameSpriteWalk(position: BoardPosition) {
        isWalking = true
    }
    
    func gameShotResult(points: Int, win: Bool) {
        self.points = points
        self.isWin = win
    }
    
    func gameOver() {
        self.isGameOver = true
    }
}
