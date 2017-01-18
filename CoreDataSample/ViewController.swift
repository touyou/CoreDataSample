//
//  ViewController.swift
//  CoreDataSample
//
//  Created by 藤井陽介 on 2017/01/15.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // senderでもらったものを渡す
        switch (segue.destination ,segue.identifier) {
        case (let controller as EditViewController, "toEditView"?):
            controller.date = (sender as? Date) ?? Date()
        default:
            break
        }
    }

    @IBAction func pushOpenBtn() {
        // senderを使う例
        // 別に変数を用意しても可能
        performSegue(withIdentifier: "toEditView", sender: datePicker.date)
    }
}

