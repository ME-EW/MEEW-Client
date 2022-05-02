//
//  NicknameVC.swift
//  MEEW-Client
//
//  Created by 안현주 on 2022/05/02.
//

import UIKit

class NicknameVC: UIViewController {
  
  private var nicknameValid: Bool = false {
    didSet {
      setSuccessbtnStatus()
    }
  }
  
  @IBOutlet weak var nicknameInputTextField: UITextField!
  @IBOutlet weak var nicknameUnderBar: UIView!
  @IBOutlet weak var countNickname: UILabel!
  @IBOutlet weak var checkNicknameLabel: UILabel!{
    didSet {
      checkNicknameLabel.isHidden = true
    }
  }
  @IBOutlet weak var successBtn: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
  }
  
  private func setUI() {
    successBtn.layer.cornerRadius = 8
    successBtn.backgroundColor = UIColor.grey600
    successBtn.titleLabel?.tintColor = UIColor.grey400
    
  }
  
  private func setBtnStatus() {
    successBtn.isEnabled = false
    
  }
  
  private func setSuccessbtnStatus() {
    
  }
  
  @IBAction func gotoTodoView(_ sender: Any) {
    
  }
  
  
  
}
