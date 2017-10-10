//
//  CustomCell.swift
//  SwipeableCell_Leon
//
//  Created by lai leon on 2017/9/13.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func buildInterface(model: CellModel) {
        imageView?.image = UIImage(named: model.imageName)
        textLabel?.text = model.title
        textLabel?.textAlignment = .center
    }

}

struct CellModel {
    let imageName: String
    var title: String
}