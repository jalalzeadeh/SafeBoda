//
//  FollowersTableViewCell.swift
//  SafeBoda
//
//  Created by Jalal on 10/1/21.
//

import UIKit

class FollowersTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLabel.font = Fonts.small
        self.descLabel.font = Fonts.small
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(user: AppUser) {
        self.nameLabel.text = user.login ?? "-"
        self.descLabel.text = user.bio ?? "-"
        if let url = URL(string: user.avatarUrl ?? "") {
            self.img.sd_setImage(with: url, completed: nil)
        }
        self.img.layer.cornerRadius = 20
        self.layoutIfNeeded()
        
    }
    
}
