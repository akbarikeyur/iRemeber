//
//  PracticeTVC.swift
//  iRemeber
//
//  Created by PC on 10/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

protocol AddPracticeTVCDelegate {
    func updateQueChalangeText(_ text : String, _ index : Int)
}


class PracticeTVC: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var questionLbl: Label!
    @IBOutlet weak var answerTxt: TextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var popUpBtn: UIButton!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var trueAnsLbl: Label!
    
    var index : Int = 0
    var delegate : AddPracticeTVCDelegate?
    
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
