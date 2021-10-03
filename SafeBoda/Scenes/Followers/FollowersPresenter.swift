//
//  FollowersPresenter.swift
//  SafeBoda
//
//  Created by Jalal on 9/23/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FollowersPresentationLogic {
    func presentSomething(response: Followers.getFollowers.Response)
}

class FollowersPresenter: FollowersPresentationLogic {
    weak var viewController: FollowersDisplayLogic?

    // MARK: Parse and calc respnse from FollowersInteractor and send simple view model to FollowersViewController to be displayed

    func presentSomething(response: Followers.getFollowers.Response) {
        let viewModel = Followers.getFollowers.ViewModel(list: response.list)
        viewController?.displayResults(viewModel: viewModel)
    }
//
//    func presentSomethingElse(response: Followers.SomethingElse.Response) {
//        let viewModel = Followers.SomethingElse.ViewModel()
//        viewController?.displaySomethingElse(viewModel: viewModel)
//    }
}
