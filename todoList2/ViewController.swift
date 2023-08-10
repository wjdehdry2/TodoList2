//
//  ViewController.swift
//  todoList2
//
//  Created by 정동교 on 2023/08/11.
//

import UIKit
import Foundation


var todoData : [ListData] = [ListData(content: "가슴 이두하는날", wDate: "2023-08-06" , isComplete: false)]
var completeData : [ListData] = []

class ListData {
    var content : String
    var wDate : String?
    var isComplete : Bool
    var completeDate : String?
    var indate : Bool?
    init(content: String, wDate: String? = nil, isComplete: Bool, completeDate: String? = nil, indate: Bool? = nil) {
        self.content = content
        self.wDate = wDate
        self.isComplete = isComplete
        self.completeDate = completeDate
        self.indate = indate
    }
}

class ViewController: UIViewController {
    
    class MainViewController: UIViewController {
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
        }
        
    }
}


extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}


