//
//  CaptureTVC.swift
//  iRemeber
//
//  Created by PC on 09/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class CaptureTVC: UITableViewCell {

    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var timeLbl: Label!
    @IBOutlet weak var captureImg: UIImageView!
    @IBOutlet weak var videoImg: UIImageView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var cancelBtnWidthConstraint: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
