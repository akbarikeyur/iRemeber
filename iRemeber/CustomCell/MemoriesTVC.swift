//
//  MemoriesTVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

protocol AddMemoriesDelegate {
    func updateQueChalangeText(_ text : String, _ index : Int)
}

class MemoriesTVC: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    var index : Int = 0
    var delegate : AddMemoriesDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.updateQueChalangeText(textField.text ?? "", index)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
