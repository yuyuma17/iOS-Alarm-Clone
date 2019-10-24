//
//  SettingTableViewController.swift
//  ClockClone
//
//  Created by 黃士軒 on 2019/10/23.
//  Copyright © 2019 Lacie. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController, GetTagData, GetSelectedDaysData {
    
    @IBOutlet weak var repeatOptionCell: UITableViewCell!
    @IBOutlet weak var tagOptionCell: UITableViewCell!
    @IBOutlet weak var voiceOptionCell: UITableViewCell!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        repeatOptionCell.accessoryView = setAccessoryView() as? UIView
        tagOptionCell.accessoryView = setAccessoryView() as? UIView
        voiceOptionCell.accessoryView = setAccessoryView() as? UIView
    }

    func setAccessoryView() -> Any {
        let indicator = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 16))
        indicator.image = UIImage(named: "indicator")
        return indicator
    }
    
    func receiveTagData(tag: String) {
        tagLabel.text = tag
    }
    
    func receiveSelectedDaysData(days: String) {
        daysLabel.text = days
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let toRepeatViewController = segue.destination as? RepeatOptionViewController
        let toTagViewController = segue.destination as? TagViewController
        
        toTagViewController?.tagText = tagLabel.text!
        toRepeatViewController?.selectedDays = daysLabel.text
        toRepeatViewController?.getDaysDelegate = self
        toTagViewController?.getTagDelegate = self
    }
    

}
