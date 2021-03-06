//
//  DetailsPresenter.swift
//  SafeBoda
//
//  Created by Jalal on 9/22/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailsPresentationLogic {
    func presentUser(response: Details.GetUser.Response)
}

class DetailsPresenter: DetailsPresentationLogic {
    weak var viewController: DetailsDisplayLogic?

    // MARK: Parse and calc respnse from DetailsInteractor and send simple view model to DetailsViewController to be displayed

    func presentUser(response: Details.GetUser.Response) {
        let viewModel = Details.GetUser.ViewModel(user: response.user)
        viewController?.displayUserInfo(viewModel: viewModel)
    }
//
//    func presentSomethingElse(response: Details.SomethingElse.Response) {
//        let viewModel = Details.SomethingElse.ViewModel()
//        viewController?.displaySomethingElse(viewModel: viewModel)
//    }
}
