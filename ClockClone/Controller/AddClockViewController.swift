//
//  AddClockViewController.swift
//  ClockClone
//
//  Created by 黃士軒 on 2019/10/22.
//  Copyright © 2019 Lacie. All rights reserved.
//

import UIKit

class AddClockViewController: UIViewController {

    var nowMode = Mode.Add
    var clockVC: ClockTableViewController!
    lazy var time = timePicker.date
    var gettedTags: String! = "鬧鐘"
    var indexPath: IndexPath!
    let dateFormatter = DateFormatter()
    
    enum Mode {
        case Add
        case Edit
        
        var navigationTitle: String {
            switch self {
            case .Add:
                return "加入鬧鐘"
            case .Edit:
                return "編輯鬧鐘"
            }
        }
    }
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = nowMode.navigationTitle
        revisePickerTextColorAndLineColor()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @IBAction func cancelAndBackToMainView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAndAddNewClock(_ sender: UIBarButtonItem) {
        
        switch nowMode {
            case .Add:
                if getPickerHour() >= 13 && getPickerHour() <= 23 {
                    AlarmData.timePointArray.append("下午")
                    AlarmData.hourArray.append(String(getPickerHour() - 12))
                    AlarmData.minuteArray.append(getPickerMinute())
                    AlarmData.toggleArray.append(true)
                    AlarmData.tagArray.append(gettedTags)
                } else if getPickerHour() == 0 {
                    AlarmData.timePointArray.append("上午")
                    AlarmData.hourArray.append(String(getPickerHour() + 12))
                    AlarmData.minuteArray.append(getPickerMinute())
                    AlarmData.toggleArray.append(true)
                    AlarmData.tagArray.append(gettedTags)
                } else if getPickerHour() == 12 {
                    AlarmData.timePointArray.append("下午")
                    AlarmData.hourArray.append(String(getPickerHour()))
                    AlarmData.minuteArray.append(getPickerMinute())
                    AlarmData.toggleArray.append(true)
                    AlarmData.tagArray.append(gettedTags)
                } else {
                    AlarmData.timePointArray.append("上午")
                    AlarmData.hourArray.append(String(getPickerHour()))
                    AlarmData.minuteArray.append(getPickerMinute())
                    AlarmData.toggleArray.append(true)
                    AlarmData.tagArray.append(gettedTags)
            }
            case .Edit:
                let index = indexPath.row
                
                if getPickerHour() >= 13 && getPickerHour() <= 23 {
                    AlarmData.timePointArray[index] = "下午"
                    AlarmData.hourArray[index] = String(getPickerHour() - 12)
                    AlarmData.minuteArray[index] = getPickerMinute()
                    AlarmData.toggleArray[index] = true
                    AlarmData.tagArray[index] = gettedTags
                } else if getPickerHour() == 0 {
                    AlarmData.timePointArray[index] = "上午"
                    AlarmData.hourArray[index] = String(getPickerHour() + 12)
                    AlarmData.minuteArray[index] = getPickerMinute()
                    AlarmData.toggleArray[index] = true
                    AlarmData.tagArray[index] = gettedTags
                } else if getPickerHour() == 12 {
                    AlarmData.timePointArray[index] = "下午"
                    AlarmData.hourArray[index] = String(getPickerHour())
                    AlarmData.minuteArray[index] = getPickerMinute()
                    AlarmData.toggleArray[index] = true
                    AlarmData.tagArray[index] = gettedTags
                } else {
                    AlarmData.timePointArray[index] = "上午"
                    AlarmData.hourArray[index] = String(getPickerHour())
                    AlarmData.minuteArray[index] = getPickerMinute()
                    AlarmData.toggleArray[index] = true
                    AlarmData.tagArray[index] = gettedTags
                }
        }
        UserDefaultsWrapper.manager.store(timePoint: AlarmData.timePointArray)
        UserDefaultsWrapper.manager.store(hour: AlarmData.hourArray)
        UserDefaultsWrapper.manager.store(minute: AlarmData.minuteArray)
        UserDefaultsWrapper.manager.store(toggle: AlarmData.toggleArray)
        UserDefaultsWrapper.manager.store(tag: AlarmData.tagArray)
        dismiss(animated: true, completion: nil)
    }
    
    func getPickerHour() -> Int {
        dateFormatter.dateFormat = "H"
        let hour = dateFormatter.string(from: time)
        return Int(hour)!
    }
    
    func getPickerMinute() -> String {
        dateFormatter.dateFormat = "mm"
        let minute = dateFormatter.string(from: time)
        return minute
    }
    
    func revisePickerTextColorAndLineColor() {
        
        if let pickerView = timePicker.subviews.first {
            
            for subView in pickerView.subviews {
                
                if subView.frame.height <= 5 {
                    subView.backgroundColor = UIColor.lightGray
                }
            }
            self.timePicker.setValue(UIColor.white, forKey: "textColor")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let settingTableViewController = segue.destination as? SettingTableViewController
        settingTableViewController?.passTagToAddVcDelegate = self
    }
}

extension AddClockViewController: GetTagData {
    
    func receiveTagData(tag: String) {
        gettedTags = tag
    }
    
}
