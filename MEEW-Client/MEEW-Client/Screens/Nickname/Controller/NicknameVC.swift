//
//  NicknameVC.swift
//  MEEW-Client
//
//  Created by 안현주 on 2022/05/02.
//

import UIKit

class NicknameVC: UIViewController {
  
  private var isNicknameValid: Bool = false {
    didSet {
      setSuccessBtnStatus()
    }
  }
  
  // MARK: - UI Component Part
  @IBOutlet weak var nicknameInputTextField: UITextField!
  @IBOutlet weak var nicknameUnderBar: UIView!
  @IBOutlet weak var countNickname: UILabel!
  @IBOutlet weak var checkNicknameLabel: UILabel!{
    didSet {
      checkNicknameLabel.isHidden = true
    }
  }
  @IBOutlet weak var successBtn: UIButton!
  
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    setTextField()
    setSuccessBtnStatus()
  }
  
  // MARK: - Custom Method Part
  private func setUI() {
    successBtn.layer.cornerRadius = 8
    successBtn.backgroundColor = UIColor.grey600
    successBtn.titleLabel?.tintColor = UIColor.grey400
    
  }
  
  private func setTextField() {
    nicknameInputTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
  }
  
  private func setBtnStatus() {
    successBtn.isEnabled = false
  }
  
  private func setSuccessBtnStatus(){
    if isNicknameValid{
      successBtn.backgroundColor = UIColor.white
      successBtn.titleLabel?.tintColor = UIColor.black
      successBtn.isEnabled = true
    } else {
      successBtn.backgroundColor = UIColor.grey600
      successBtn.titleLabel?.tintColor = UIColor.grey400
      successBtn.isEnabled = false
    }
  }
  
  //정규식
  private func isValidNickname(nickname: String?) -> Bool {
    guard nickname != nil else { return false }
    
    let nicknameRegEx = "[가-힣A-Za-z0-9]{2,10}"
    
    let pred = NSPredicate(format:"SELF MATCHES %@", nicknameRegEx)
    return pred.evaluate(with: nickname)
  }
  
  private func checkMaxLabelCount(){
    if let text = nicknameInputTextField.text {
      //닉네임 정규식에 맞으면
      if isValidNickname(nickname: nicknameInputTextField.text){
        isNicknameValid = true //successBtn관련
        nicknameInputTextField.layer.borderColor = UIColor.grey400.cgColor
        checkNicknameLabel.isHidden = true
        
      }else{ //문제 있음 중복임
        checkNicknameLabel.text = "닉네임 형식이 올바르지 않습니다."
        nicknameInputTextField.layer.borderColor = UIColor.red.cgColor
        isNicknameValid = false //successBtn관련
        checkNicknameLabel.isHidden = false
        
      }
    }
  }
  
  private func pushTodoView() {
    guard let todoVC = self.storyboard?.instantiateViewController(identifier: "ToDoVC") as? ToDoVC else {return}
    self.navigationController?.pushViewController(todoVC, animated: true)
  }
  
  
  // MARK: - IBAction
  @IBAction func gotoTodoView(_ sender: Any) {
    successBtn.isEnabled = false //버튼 여러번 눌리는거 해결
    if let nicknameInputTextField = self.nicknameInputTextField.text {
      //        self.postEmailData(email: emailInputTextField)
      //이거를 TOSVC에 전달하기만 하면 될듯? 서버 연결 할거 없음 중복 검사도 안하니까?
      
      self.pushTodoView()
      self.successBtn.isEnabled = true //되돌아왔을때 pop 했을때 버튼 비활되어 있어서 다시 true해주기
    }
  }
  
  
  // MARK: - @objc Function Part
  @objc func textFieldDidChange() {
    checkMaxLabelCount()
  }
  
}

// MARK: - Extension Part
extension NicknameVC : UITextFieldDelegate{
  private func textViewDidBeginEditing(_ textField: UITextField) {
    //텍스트가 있을 경우
    if textField.text == "ex. 딱새우회"{
      nicknameInputTextField.text = ""
      nicknameInputTextField.textColor = .black
    }
    nicknameUnderBar.layer.borderColor = UIColor.red.cgColor
  }
  
  private func textViewDidEndEditing(_ textField: UITextField) {
    //비어있을 경우 --> 아무것도 뭐 없는디 ..
    if textField.text == nil {
      textField.text = "ex. 딱새우회"
      textField.textColor = .black
    }
    nicknameUnderBar.layer.borderColor = UIColor.grey500.cgColor
  }
  
  
}
