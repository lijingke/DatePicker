//
//  PIViewController.swift
//  PIDatePicker-Swift
//
//  Created by Jonathan on 4/17/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

import UIKit
import SnapKit

class PIViewController: UIViewController {
    @IBOutlet var datePicker: PIDatePicker!
    @IBOutlet var label: UILabel!
    
    let validPast: TimeInterval = -10000000000
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("SJDatePicker", for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.datePicker.minimumDate = Date().addingTimeInterval(self.validPast)
        self.datePicker.delegate = self
        
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }

    @IBAction func randomizeColor(_ sender: AnyObject) {
        let red = CGFloat(arc4random_uniform(255))
        let green = CGFloat(arc4random_uniform(255))
        let blue = CGFloat(arc4random_uniform(255))
        
        self.datePicker.textColor = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        self.datePicker.reloadAllComponents()
    }
    
    @IBAction func randomizeFont(_ sender: AnyObject) {
        let familyNames = UIFont.familyNames
        let randomNumber = Int(arc4random_uniform(UInt32(familyNames.count)))
        let familyName: String = familyNames[randomNumber]
        let fontName: String = UIFont.fontNames(forFamilyName: familyName)[0]
        self.datePicker.font = UIFont(name: fontName, size: 14)!
        self.datePicker.reloadAllComponents()
    }
    
    @objc private func btnAction() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
//        let vc = PresentedViewController()
//        navigationController?.present(vc, animated: true)
    }
}

extension PIViewController: PIDatePickerDelegate {
    func pickerView(_ pickerView: PIDatePicker, didSelectRow row: Int, inComponent component: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        self.label.text = dateFormatter.string(from: pickerView.date)
    }
}
