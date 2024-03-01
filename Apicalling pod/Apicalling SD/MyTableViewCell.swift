//
//  MyTableViewCell.swift
//  Apicalling SD
//
//  Created by Droadmin on 7/14/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var fatchImage: UIImageView!
    
    @IBOutlet weak var fatchNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
