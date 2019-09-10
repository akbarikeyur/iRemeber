//
//  CustomQueAnsTVC.swift
//  iRemeber
//
//  Created by PC on 09/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

protocol AddQueAnsChalangeTVCDelegate {
    func updateQueAnsChalangeText(_ text : String, _ index : Int)
    func updateAnsChalangeText(_ text : String, _ index : Int)
}


class CustomQueAnsTVC: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var queTxt: TextField!
    @IBOutlet weak var ansTxt: TextField!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    var index : Int = 0
    var delegate : AddQueAnsChalangeTVCDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == queTxt
        {
            delegate?.updateQueAnsChalangeText(textField.text ?? "", index)
        }
        else if textField == ansTxt
        {
            delegate?.updateAnsChalangeText(textField.text ?? "", index)
        }
        return true
    }
    
    
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == queTxt {
//            delegate?.updateQueAnsChalangeText(textField.text ?? "", index)
//        }
//        else {
//            delegate?.updateAnsChalangeText(textField.text ?? "", index)
//        }
//    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
