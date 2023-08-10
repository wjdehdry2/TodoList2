//
//  TodoViewController.swift
//  todoList2
//
//  Created by 정동교 on 2023/08/11.
//

import UIKit

class TodoViewController : UIViewController {
    
    var index : Int!
    @IBOutlet weak var TodoView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButtonAction(_ sender: Any) {
        let alertCon = UIAlertController(title: "할일 추가", message: nil , preferredStyle: .alert)
        let close = UIAlertAction(title: "닫기", style: .destructive, handler: nil)
        let check = UIAlertAction(title: "확인", style: .default){ (ok) in
            self.TodoView.reloadSections(IndexSet(0...0), with: .automatic)
            todoData.append(ListData(content: (alertCon.textFields?[0].text)!, wDate: (alertCon.textFields?[1].text)! ,isComplete: false))
        }
        
        alertCon.addTextField{ (myTextField) in
            myTextField.placeholder = "할일을 입력해주세요"
        }
        alertCon.addTextField{ (myTextField) in
            myTextField.placeholder = "목표 날짜를 입력(2023-08-11)"
        }
        
        alertCon.addAction(check)
        alertCon.addAction(close)
        present(alertCon, animated: true, completion: nil)
    }
    
    func goal (_ tableViewController: TodoViewController, _ index : Int) {
        completeData.append(todoData[index])
        todoData.remove(at: index)
        tableViewController.TodoView.reloadSections(IndexSet(0...0), with: .automatic)
    }
    func todoDelete (_ tableViewController: TodoViewController, _ index : Int) {
        todoData.remove(at: index)
        tableViewController.TodoView.reloadSections(IndexSet(0...0), with: .automatic)
    }
    override func viewWillAppear(_ animated: Bool) {
        TodoView.reloadSections(IndexSet(0...0), with: .automatic)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension Date{
    
    func toString() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            return dateFormatter.string(from: self)
        }
}


extension TodoViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath : IndexPath){
        index = indexPath.row
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: "삭제하기", style: .destructive) { [self]
            (delete) in
            TodoViewController().todoDelete(self, index)
        }
        
        let correction = UIAlertAction(title: "수정하기", style: .default) { [self]
            (modify) in
            performSegue(withIdentifier: "TableToDetail", sender: self)
        }
        
        let pass = UIAlertAction(title: "완료목록으로 보내기", style: .default) { [self]
            (pass) in
            TodoViewController().goal(self, index)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        
        if todoData[index].isComplete == true {
            alert.addAction(pass)

        }
        alert.addAction(correction)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true)
        super.viewDidLoad()
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "TableToDetail" {
            let dViewCon = segue.destination as! DetailViewController
            dViewCon.index = index
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let today = Date()
        let index = indexPath.row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        cell.customSwitch.addTarget(self, action: #selector(self.tSwitch(sender:)), for: .valueChanged)
        cell.customLable.text = todoData[index].content
        cell.dateLabel.text = todoData[index].wDate
        cell.customSwitch.isOn = todoData[index].isComplete
        cell.customSwitch.tag = indexPath.row
        
        if cell.customSwitch.isOn {
            cell.customLable?.attributedText = cell.customLable.text?.strikeThrough()
            cell.dateLabel?.attributedText = cell.dateLabel.text?.strikeThrough()
        }
        
        if today.toString() > cell.dateLabel.text! {
            cell.dateLabel.textColor = .red
        }
        return cell
    }
    
    @objc func tSwitch (sender : UISwitch)  {
        
        let index = sender.tag
        
        if todoData[index].isComplete == false {
            todoData[index].isComplete = true
            todoData[index].completeDate = Date().toString()
        }
        else {
            if todoData[index].wDate! != "" {
                if todoData[index].wDate! > todoData[index].completeDate! {
                    todoData[index].indate = true
                }
                else {
                    todoData[index].indate = false
                }
            }
            completeData.append(todoData[index])
            todoData.remove(at: index)
        }
        TodoView.reloadSections(IndexSet(0...0), with: .automatic)
    }
    
}
