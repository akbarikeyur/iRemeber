//
//  ViewQuestionVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class ViewQuestionVC: UIViewController , UITableViewDelegate, UITableViewDataSource, AddQueAnsChalangeTVCDelegate {

    @IBOutlet weak var tblView: UITableView!

    
    var queDict : QuestionModel = QuestionModel()
    var dictArr : [QuestionModel] = [QuestionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib(nibName: "CustomQueAnsTVC", bundle: nil), forCellReuseIdentifier: "CustomQueAnsTVC")
        
        if let dict1 : [QuestionModel] = CoreDataUtility.shared.fatchQuestionAnswer(TableName: "ViewQuestion"), dict1.count != 0 {
            print(dict1)
            dictArr = dict1
            tblView.reloadData()
        } else {
            addDict()
        }
            
    }
    
    func addDict()  {
        self.view.endEditing(true)
        
        queDict = QuestionModel.init()
        queDict.id = getCurrentTimeStampValue()
        queDict.question = ""
        queDict.answer = ""
        dictArr.append(queDict)
        tblView.reloadData()
        
        let indexPath = NSIndexPath(item: dictArr.count - 1, section: 0)
        tblView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        
        print(dictArr)
    }
    
    //MARK: - TableView Delgate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "CustomQueAnsTVC", for: indexPath) as! CustomQueAnsTVC
        
        let dict : QuestionModel = dictArr[(indexPath.row)]
        cell.delegate = self
        
        cell.countLbl.text = String(indexPath.row + 1)
        cell.queTxt.text = dict.question
        cell.ansTxt.text = dict.answer
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(self.clickToDeleteQueAns), for: .touchUpInside)
        
        cell.index = indexPath.row
        return cell
    }
    
    func updateQueAnsChalangeText(_ text: String, _ index: Int) {
        self.view.endEditing(true)
        dictArr[(index)].question = text.trimmed
        print(dictArr)
      //  tblView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tblView.reloadData()
    }
    
    func updateAnsChalangeText(_ text: String, _ index: Int) {
        self.view.endEditing(true)
        dictArr[(index)].answer = text.trimmed
        print(dictArr)
        tblView.reloadData()
   //     tblView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    @objc func clickToDeleteQueAns(sender : UIButton)  {
        self.view.endEditing(true)
        showAlertWithOption("Confirmation", message: "Are you sure you want to delete this question.", completionConfirm: {
            CoreDataUtility.shared.deleteQuestion(order: self.dictArr[sender.tag], TableName: "ViewQuestion")
            self.dictArr.remove(at: sender.tag)
            
            if self.dictArr.count == 0 {
                self.addDict()
            }
            
            self.tblView.reloadData()
        }) {
            
        }
    }
    
    
    @IBAction func clicKToAdd(_ sender: Any) {
        self.view.endEditing(true)
        if dictArr[dictArr.count - 1].question == "" {
            displayToast("Please enter question.")
        }
        else if dictArr[dictArr.count - 1].answer == "" {
            displayToast("Please enter answer.")
        }
        else {
            addDict()
        }
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.view.endEditing(true)
        for item in dictArr {
            if item.answer != "" && item.question != "" {
                if let data : Bool =  CoreDataUtility.shared.selectQuestionAnswer(item: item, TableName: "ViewQuestion") , data == true {
                    CoreDataUtility.shared.updateItem(item: item, TableName: "ViewQuestion")
                }
                else {
                    CoreDataUtility.shared.saveQuestionAnswer(Model: item, TableName: "ViewQuestion")
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
