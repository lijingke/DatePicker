//
//  ViewController.swift
//  DatePicker
//
//  Created by 李京珂 on 2024/11/27.
//

import UIKit

class ViewController: UIViewController {
    lazy var txtShowDate: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.textColor = UIColor(named: "textColor")
        field.backgroundColor = UIColor(named: "backColor")
        field.layer.cornerRadius = 10
        return field
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.backgroundColor = UIColor.systemBackground
        self.txtShowDate.textColor = UIColor(named: "textColor")
        self.txtShowDate.backgroundColor = UIColor(named: "backColor")

        view.addSubview(self.txtShowDate)
        self.txtShowDate.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func showPicker() {
        var style = DefaultStyle()
        style.pickerColor = StyleColor.colors([style.textColor, .red, .blue])
        style.pickerMode = .date
        style.titleString = "This is Date Picker"
        style.returnDateFormat = .d_m_yyyy
        style.titleFont = UIFont.systemFont(ofSize: 25, weight: .bold)

        let pick = PresentedViewController()
        pick.style = style
        pick.block = { [weak self] date in
            self?.txtShowDate.text = date
        }
        self.present(pick, animated: true, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        self.showPicker()
    }
}
