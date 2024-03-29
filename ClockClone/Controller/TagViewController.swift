//
//  TagViewController.swift
//  ClockClone
//
//  Created by 黃士軒 on 2019/10/24.
//  Copyright © 2019 Lacie. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {

    var tagText: String?
    weak var getTagDelegate: GetTagData?
    
    @IBOutlet weak var tagTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagTextField.text = tagText
        reviseBackButtonNameAndColor()
        reviseClearButtonColor()
        reviseTextFieldLeftPadding()
        
        // 開啟讀取 tagTextField 裡如果沒字，就不能按 Done
        tagTextField.enablesReturnKeyAutomatically = true
    }
    
    // 一進畫面則選到 TextField 且鍵盤隨後彈出
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tagTextField.becomeFirstResponder()
    }
    
    // 離開畫面時使用 Delegate 傳值到上一頁
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if tagTextField.text?.count == 0 {
            getTagDelegate?.receiveTagData(tag: "鬧鐘")
        } else {
            getTagDelegate?.receiveTagData(tag: tagTextField.text!)
        }
    }
    
    func reviseBackButtonNameAndColor() {
        
        let backButton = UIBarButtonItem()
        backButton.title = "返回"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.view.tintColor = UIColor.orange
    }
    
    func reviseClearButtonColor() {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(named: "clearButton"), for: .normal)
        clearButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        clearButton.addTarget(self, action: #selector(clearAllText(sender:)), for: .touchUpInside)

        tagTextField.rightView = clearButton
        tagTextField.rightViewMode = .whileEditing
    }
    
    @objc func clearAllText(sender : AnyObject) {
        tagTextField.text = ""
    }
    
    func reviseTextFieldLeftPadding() {
        tagTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tagTextField.frame.height))
        tagTextField.leftViewMode = .always
    }
}

extension TagViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.navigationController?.popViewController(animated: true)
        return true
    }
}
