//
//  FollowingPresenterTests.swift
//  SafeBoda
//
//  Created by Jalal on 10/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import SafeBoda
import XCTest

class FollowingPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: FollowingPresenter!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupFollowingPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupFollowingPresenter() {
        sut = FollowingPresenter()
    }

    // MARK: - Test doubles

    class FollowingDisplayLogicSpy: FollowingDisplayLogic {
        var displaySomethingCalled = false
        
        func displayResults(viewModel: Following.GetFollowing.ViewModel) {
          displaySomethingCalled = true
        }
    }

    // MARK: - Tests

    func testPresentSomething() {
        // Given
        let spy = FollowingDisplayLogicSpy()
        sut.viewController = spy
        let response = Following.GetFollowing.Response()

        // When
        sut.presentSomething(response: response)

        // Then
        XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
}