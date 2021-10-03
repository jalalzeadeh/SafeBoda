//
//  FollowersViewController.swift
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

protocol FollowersDisplayLogic: AnyObject
{
    func displayResults(viewModel: Followers.getFollowers.ViewModel)
//    func displaySomethingElse(viewModel: Followers.SomethingElse.ViewModel)
}

class FollowersViewController: MainViewController, FollowersDisplayLogic {
    var interactor: FollowersBusinessLogic?
    var router: (NSObjectProtocol & FollowersRoutingLogic & FollowersDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup Clean Code Design Pattern 

    private func setup() {
        let viewController = self
        let interactor = FollowersInteractor()
        let presenter = FollowersPresenter()
        let router = FollowersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell
        let nib = UINib(nibName: cellId, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.cellId)
        // empty view
        self.emptyview.fillInfo(parent: self.emptyView, type: .following)
        // loader
        self.startActivityIndicator()
        self.footerView.frame.size.height = 0
        // call api
        self.getFollowers()
        
//        doSomethingElse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // status bar
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        renderUIComponents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var displayedUsers = Followers.getFollowers.ViewModel()
    private let cellId = "FollowersTableViewCell"
    private let emptyview = EmptyView()
    private var apiPage: Int = 1
    private var canResend: Bool = true
    
    
    //MARK: - receive events from UI
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var footerView: UIView!
    
    
    func renderUIComponents() {
        // setup navigation theme
        navigationController?.navigationBar.barTintColor = Colors.mainColor
        navigationController?.navigationBar.tintColor = Colors.white
        navigationController?.navigationBar.backgroundColor = Colors.clear
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.white]
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "FOLLOWERS_SCREEN_TITLE".localized
        self.navigationController?.navigationBar.layoutIfNeeded()
        
    }
    
    // MARK: - request data from FollowersInteractor

    func getFollowers() {
        let request = Followers.getFollowers.Request()
        // call view model to get data
        interactor?.getFollowers(request: request)
    }
    
    
    // MARK: - display view model from FollowersInteractor

    func displayResults(viewModel: Followers.getFollowers.ViewModel) {
        // go to personal details screen
        //router?.routeToPersonalInfo(segue: nil)
        self.stopActivityIndicator()
        displayedUsers.list += viewModel.list
        if viewModel.list.count < ApiManager.apiPageCount {
            canResend = false
        }
        self.footerView.frame.size.height = 0
        if displayedUsers.list.count > 0 {
            self.tableView.isHidden = false
            self.emptyView.isHidden = true
        } else {
            self.tableView.isHidden = true
            self.emptyView.isHidden = false
        }
        self.tableView.reloadData()
        
    }
}


// MARK:- table view delegate & data source
extension FollowersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int
    {
      return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return displayedUsers.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let user = displayedUsers.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! FollowersTableViewCell
        cell.selectionStyle = .none
        cell.setData(user: user)
        // get another page
        if (indexPath.row >= displayedUsers.list.count - 1 && displayedUsers.list.count > 9 && canResend) {
            self.footerView.frame.size.height = 44
            apiPage += 1
            let request = Followers.getFollowers.Request(page: apiPage)
            // call view model to get data
            interactor?.getFollowers(request: request)
        }
        return cell
    }
}