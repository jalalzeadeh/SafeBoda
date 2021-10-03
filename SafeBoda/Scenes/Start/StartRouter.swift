//
//  StartRouter.swift
//  SafeBoda
//
//  Created by Jalal on 10/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol StartRoutingLogic {
    func routeToHome(segue: UIStoryboardSegue?)
    func routeToDetails(segue: UIStoryboardSegue?)
}

protocol StartDataPassing {
    var dataStore: StartDataStore? { get }
}

class StartRouter: NSObject, StartRoutingLogic, StartDataPassing {
    weak var viewController: StartViewController?
    var dataStore: StartDataStore?

// MARK: Routing (navigating to other screens)


    func routeToHome(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! HomeViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToHome(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard.mainStoryboard
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            var destinationDS = destinationVC.router!.dataStore!
            destinationVC.modalPresentationStyle = .fullScreen
            passDataToHome(source: dataStore!, destination: &destinationDS)
            navigateToHome(source: viewController!, destination: destinationVC)
        }
    }
    
    func routeToDetails(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! DetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetails(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard.mainStoryboard
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            let destinationNav = UINavigationController(rootViewController: destinationVC)
            destinationNav.modalPresentationStyle = .fullScreen
            passDataToDetails(source: dataStore!, destination: &destinationDS)
            navigateToDetails(source: viewController!, destination: destinationNav)
        }
    }

// MARK: Navigation to other screen


    func navigateToHome(source: StartViewController, destination: HomeViewController) {
        source.show(destination, sender: nil)
    
    }
    
    func navigateToDetails(source: StartViewController, destination: UINavigationController) {
        source.show(destination, sender: nil)
    }

// MARK: Passing data to other screen

    func passDataToHome(source: StartDataStore, destination: inout HomeDataStore) {
        
    }
    
    func passDataToDetails(source: StartDataStore, destination: inout DetailsDataStore) {
        destination.user = source.user ?? AppUser()
    }
}