//
//  DoneViewController.swift
//  todoList2
//
//  Created by 정동교 on 2023/08/11.
//

import UIKit

class DoneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var DoneView: UITableView!
    @IBAction func deleteAction(_ sender: Any) {
        let index = DoneView.indexPathForSelectedRow?.row ?? -1
        if index != -1 {
            let alert = UIAlertController(title: completeData[index].content, message: "삭제하시겠습니까?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "삭제", style: .destructive){
                (ok) in
                completeData.remove(at: index)
                self.DoneView.reloadSections(IndexSet(0...0), with: .automatic)
            }
            let cancel = UIAlertAction(title: "취소", style: .default)
            alert.addAction(ok)
            alert.addAction(cancel)
            present(alert, animated: true)
        }
        else{
            let alert = UIAlertController(title: nil, message: "항목을 선택해주세요!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
        }
    }
}
extension DoneViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completeData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.customLable.text = completeData[indexPath.row].content
        cell.dateLabel.text = completeData[indexPath.row].wDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
