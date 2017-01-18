//
//  EditViewController.swift
//  CoreDataSample
//
//  Created by 藤井陽介 on 2017/01/18.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var date: Date!

    override func viewDidLoad() {
        super.viewDidLoad()

        // もしdateと同じ日のデータがあればそれを反映する
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<TYDiary> = TYDiary.fetchRequest()
        
        // targetでdateをその日の0時0分0秒にしている
        let calendar = Calendar(identifier: .gregorian)
        let target = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        
        // dateで指定した日の0時0分0秒から23時59分59秒の間にあるかどうかという検索条件
        fetchRequest.predicate = NSPredicate(format: "SELF.date BETWEEN {%@, %@}",
                                             argumentArray: [target, Date(timeInterval: 24*60*60-1, since: target)])
        let fetchData = try! context.fetch(fetchRequest)
        
        // 一日の記事は一個だけなので最初をとってきてあればUIに反映する
        if let data = fetchData.first {
            titleTextField.text = data.title
            bodyTextView.text = data.text
        }
    }
    
    @IBAction func pushCancelBtn() {
        // 何もせず画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pushSaveBtn() {
        // 内容をデータベースに保存する。
        // まず検索はviewDidLoadと同様に行う
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TYDiary> = TYDiary.fetchRequest()
        let calendar = Calendar(identifier: .gregorian)
        let target = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        fetchRequest.predicate = NSPredicate(format: "SELF.date BETWEEN {%@, %@}",
                                             argumentArray: [target, Date(timeInterval: 24*60*60-1, since: target)])
        let fetchData = try! context.fetch(fetchRequest)
        if !fetchData.isEmpty {
            // 検索してあれば見つかった最初のデータを今のデータで更新
            fetchData[0].title = titleTextField.text
            fetchData[0].text = bodyTextView.text
        } else {
            // 無ければつくる
            let diary = TYDiary(context: context)
            diary.date = date as NSDate
            diary.title = titleTextField.text
            diary.text = bodyTextView.text
        }
        // 最後にセーブ処理
        do {
            try context.save()
        } catch {
            print(error)
        }
        // 保存が終わったら画面を閉じる
        dismiss(animated: true, completion: nil)

    }
}
