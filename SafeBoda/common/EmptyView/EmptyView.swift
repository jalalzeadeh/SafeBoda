//
//  EmptyView.swift
//  SafeBoda
//
//  Created by Jalal on 10/2/21.
//

import Foundation
import UIKit

enum EmptyViewType {
    case none
    case following
    case followers
    
    var title: String {
        switch self {
        case .none:
            return ""
        case .following:
            return "EMPTY_VIEW_FOLLOWING_TITLE"
        case .followers:
            return "EMPTY_VIEW_FOLLOWERS_TITLE"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .none:
            return #imageLiteral(resourceName: "ic_empty")
        case .following:
            return #imageLiteral(resourceName: "ic_empty")
        case .followers:
            return #imageLiteral(resourceName: "ic_empty")
        }
    }
}

class EmptyView: MainView {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var emptyType = EmptyViewType.none
    
    override func awakeFromNib() {
        self.view.layoutIfNeeded()
        self.titleLabel.textColor = Colors.red
        self.titleLabel.font = Fonts.normalBold
        self.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
   
    /// Fill in pre defined types info
    func fillInfo(parent: UIView, type: EmptyViewType) {
        self.emptyType = type
        // add to parent
        self.view.backgroundColor = Colors.grayField
//        self.frame.origin.y = 0
//        self.frame.origin.x = 0
//        self.view.frame.origin.y = 0
//        self.view.frame.origin.x = 0
        parent.layoutIfNeeded()
        self.view.layoutIfNeeded()
        parent.addSubview(self.view)
        
        self.img.image = type.icon
        // set labels
        titleLabel.text = type.title.localized
        // set image
        img.image = type.icon
        self.view.layoutIfNeeded()
        parent.layoutIfNeeded()
       
        
    }
    
   
    
}
