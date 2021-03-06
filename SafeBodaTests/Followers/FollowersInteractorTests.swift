//
//  FollowersInteractorTests.swift
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

class FollowersInteractorTests: XCTestCase
{
    // MARK: Subject under test

    var sut: FollowersInteractor!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupFollowersInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupFollowersInteractor() {
        sut = FollowersInteractor()
    }

    // MARK: - Test doubles

    class FollowersPresentationLogicSpy: FollowersPresentationLogic
    {
        var presentSomethingCalled = false

        func presentSomething(response: Followers.getFollowers.Response) {
            presentSomethingCalled = true
        }
    }

    // MARK: - Tests

    func testDoSomething() {
        // Given
        let spy = FollowersPresentationLogicSpy()
        sut.presenter = spy
        let request = Followers.getFollowers.Request()

        // When
        sut.getFollowers(request: request)

        // Then
        XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
    }
}
