//
//  MemorizeTests.swift
//  MemorizeTests
//
//  Created by Ederson Machado Berti on 06/06/21.
//

import XCTest
@testable import Memorize

class MemorizeTests: XCTestCase {

    var memoryGame: MemoryGame<String>!
    
    override func setUp() {
        memoryGame = MemoryGame(of: ["A"])
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_shouldGameFinishWhenMatchedAllCards() {
        memoryGame.chooseCard(at: 0)
        memoryGame.chooseCard(at: 1)
        
        XCTAssertTrue(memoryGame.cards[0].isFaceUp)
        XCTAssertTrue(memoryGame.cards[1].isFaceUp)
        XCTAssertTrue(memoryGame.finish)
    }
    
    func test_shouldKeepChosenCardFaceUpIfCardAlreadyFaceUp() {
        memoryGame.chooseCard(at: 0)
        
        XCTAssertTrue(memoryGame.cards[0].isFaceUp)
        
        memoryGame.chooseCard(at: 0)
        XCTAssertTrue(memoryGame.cards[0].isFaceUp)
    }
    
    func test_shouldCreateCorrectPairsWhenInit() {
        XCTAssertEqual(memoryGame.cards.count, 2)
        
        memoryGame = MemoryGame(of: ["a", "b"])
        XCTAssertEqual(memoryGame.cards.count, 4)
        
        memoryGame = MemoryGame(of: ["a", "b", "c"])
        XCTAssertEqual(memoryGame.cards.count, 6)

        memoryGame = MemoryGame(of: ["a", "b", "c", "d"])
        XCTAssertEqual(memoryGame.cards.count, 8)
        
        memoryGame = MemoryGame(of: ["a", "b", "c", "d", "e"])
        XCTAssertEqual(memoryGame.cards.count, 10)
    }
    
    func test_shouldIncreaseAttemptsWhenChooseTwoCards() {
        memoryGame.chooseCard(at: 0)
        memoryGame.chooseCard(at: 1)
        
        XCTAssertEqual(memoryGame.attempts, 1)
    }
    
    func test_shouldKeepJustOneCardFaceUpWhenChooseThreeCards() {
        memoryGame = MemoryGame(of: ["a", "b"])
        
        memoryGame.chooseCard(at: 0)
        memoryGame.chooseCard(at: 1)
        memoryGame.chooseCard(at: 2)
        
        XCTAssertFalse(memoryGame.cards[0].isFaceUp)
        XCTAssertFalse(memoryGame.cards[1].isFaceUp)
        XCTAssertTrue(memoryGame.cards[2].isFaceUp)
    }
    
    func test_shouldDoNothingWhenChooseAnInvalidIndex() {
        memoryGame.chooseCard(at: 10)
        memoryGame.chooseCard(at: 11)
        memoryGame.chooseCard(at: 12)
        memoryGame.chooseCard(at: 13)
        
        XCTAssertFalse(memoryGame.cards[0].isFaceUp)
        XCTAssertFalse(memoryGame.cards[1].isFaceUp)
    }
}
