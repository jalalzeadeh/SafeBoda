//
//  DetailsModels.swift
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

enum Details
{
    // MARK: Use cases

    enum GetUser
    {
        struct Request
        {

        }

        struct Response
        {
           var user: AppUser?
        }

        struct ViewModel
        {
           var user: AppUser?
        }
    }
    
}
