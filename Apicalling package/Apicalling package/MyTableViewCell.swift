//
//  MyTableViewCell.swift
//  Apicalling package
//
//  Created by Droadmin on 7/14/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var fatchNameLbl: UILabel!
    @IBOutlet weak var fatchImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
