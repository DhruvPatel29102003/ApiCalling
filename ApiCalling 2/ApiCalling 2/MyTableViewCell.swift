//
//  MyTableViewCell.swift
//  ApiCalling 2
//
//  Created by Droadmin on 7/14/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var apiImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
