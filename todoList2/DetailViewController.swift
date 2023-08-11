//
//  DetailViewController.swift
//  todoList2
//
//  Created by 정동교 on 2023/08/11.
//

import UIKit

class DetailViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTextfield1.text = content
        customTextfield2.text = date
    }
    
    

    var content : String!
    var index : Int!
    var date : String!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var DetailView: UIView!
    @IBOutlet weak var customTextfield1: UITextField!
    @IBOutlet weak var customTextfield2: UITextField!
    @IBAction func Save(_ sender: Any) {
        
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        let alert = UIAlertController(title: nil, message: "수정하시겠습니까?" , preferredStyle: .alert)
        let check = UIAlertAction(title: "확인", style: .default) { [self] (ok) in
            todoData[self.index].content = self.customTextfield1.text!
            if(customTextfield2.text! == ""){
                todoData[self.index].wDate = Date().toString()
            }else{
                todoData[self.index].wDate = self.customTextfield2.text!
            }
            self.navigationController?.popViewController(animated: true)
        }
        
        
        alert.addAction(check)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
}
