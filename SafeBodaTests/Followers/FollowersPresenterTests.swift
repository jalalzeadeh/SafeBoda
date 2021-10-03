//
//  FollowersPresenterTests.swift
//  SafeBoda
//
//  Created by Jalal on 10/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import SafeBoda
import XCTest

class FollowersPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: FollowersPresenter!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupFollowersPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupFollowersPresenter() {
        sut = FollowersPresenter()
    }

    // MARK: - Test doubles

    class FollowersDisplayLogicSpy: FollowersDisplayLogic {
        var displaySomethingCalled = false

        
        func displayResults(viewModel: Followers.getFollowers.ViewModel) {
          displaySomethingCalled = true
        }
    }

    // MARK: - Tests

    func testPresentSomething() {
        // Given
        let spy = FollowersDisplayLogicSpy()
        sut.viewController = spy
        let response = Followers.getFollowers.Response()

        // When
        sut.presentSomething(response: response)

        // Then
        XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
}
