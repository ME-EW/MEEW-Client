//
//  NicknameVC.swift
//  MEEW-Client
//
//  Created by 안현주 on 2022/05/02.
//

import UIKit

private class nicknameStatusClass{
	enum nicknameStatus{
		case specialCharErr
		case strangeCharErr
		case countLetterErr
		case normal
	}
}

class NicknameVC: UIViewController {
	
	let socialToken: String = "" // 소셜 토큰(accessToken)
	let socialType: String = "" // 소셜 타입
	let personalityId: Int = 1 // 캐릭터 id
	
	private var isNicknameValid: Bool = false {
		didSet {
			setSuccessBtnStatus()
		}
	}
	
	//  private var loadingView: LoadingView?
	
	// MARK: - UI Component Part
	
	
	@IBOutlet weak var nicknameInputTextField: UITextField!{
		didSet{
			nicknameInputTextField.delegate = self
		}
	}
	@IBOutlet weak var nicknameUnderBar: UIView!
	@IBOutlet weak var countNicknameLabel: UILabel!
	@IBOutlet weak var checkNicknameLabel: UILabel!{
		didSet {
			checkNicknameLabel.isHidden = true
		}
	}
	@IBOutlet weak var successBtn: UIButton!
	
	@IBOutlet weak var loadingView: UIView!{
		didSet{
			loadingView.isHidden = true
		}
	}
	
	@IBOutlet var dots: [UIView]! {
		didSet {
			dots[0].layer.cornerRadius = 7/2
			dots[1].layer.cornerRadius = 7/2
			dots[2].layer.cornerRadius = 7/2
		}
	}
	
	// MARK: - Life Cycle Part
	override func viewDidLoad() {
		super.viewDidLoad()
		setUI()
		setTextField()
		setSuccessBtnStatus()
		registerDelegate()
		hideKeyboard()
	}
	
	// MARK: - Custom Method Part
	func startAnimation() {
		loadingView.isHidden = false
		for index in 0..<dots.count {
			dots[index].transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
			UIView.animate(withDuration: 0.6, delay: Double(index+1) * 0.2, options: [.repeat, .autoreverse], animations: {self.dots[index].transform = CGAffineTransform.identity}, completion: nil)
		}
	}
	
	
	private func registerDelegate() {
		nicknameInputTextField.delegate = self
	}
	
	private func setUI() {
		successBtn.layer.cornerRadius = 8
		successBtn.backgroundColor = UIColor.grey600
		successBtn.titleLabel?.tintColor = UIColor.grey400
		
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
	
	private func setBtnStatus() {
		successBtn.isEnabled = false
	}
	
	private func setTextField() {
		nicknameInputTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
		nicknameInputTextField.setClearButton(with: UIImage(named:"btn_delete")!, mode: .whileEditing)
	}
	
	
	private func setCountLabel(){
		if let count = nicknameInputTextField.text?.count{
			countNicknameLabel.text = String(count) + "/10"
		}
	}
	
	
	private func cutMaxLabel() {
		if let text = nicknameInputTextField.text {
			if text.count > 10{
				let maxIndex = text.index(text.startIndex, offsetBy: 10)
				let newString = String(text[text.startIndex..<maxIndex])
				nicknameInputTextField.text = newString
			}
		}
	}
	
	
	private func isValidNickname(nickname: String?) -> nicknameStatusClass.nicknameStatus {
		if !checkMaxLabelCount(nickname: nickname) { //글자수
			return .countLetterErr
		} else if !checkSpecialChar(nickname: nickname){ //특수 문자 있으면 true
			return .specialCharErr
		} else if !checkNormalChar(nickname: nickname) { //정규식에 안 맞으면 !false ㅇㄹ
			return .strangeCharErr
		} else {
			return .normal
		}
	}
	
	private func checkSpecialChar(nickname: String?) -> Bool {
		guard nickname != nil else { return false }
		
		let nickRegEx = "[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]{2,10}"
		
		let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
		return pred.evaluate(with: nickname) //특수문자는 false
	}
	
	private func checkNormalChar(nickname: String?) -> Bool {
		guard nickname != nil else { return false }
		
		let nickRegEx = "[가-힣A-Za-z0-9]{2,10}"
		
		let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
		return pred.evaluate(with: nickname) //정규식에 맞으면 true
	}
	
	private func checkMaxLabelCount(nickname: String?) -> Bool {
		if let text = nicknameInputTextField.text {
			if text.count > 10 || text.count < 2{ //문제 있으면 false
				return false
			} else{
				return true
			}
		}
		return false
	}
	
	
	//토탈로 검사하는 함수 구현
	private func alertNicknameStatus(){
		if let nickname = nicknameInputTextField.text {
			switch(isValidNickname(nickname: nickname)){
			case .countLetterErr:
				//글자수 문제 있을 경우
				print("글자수")
				self.successBtn.isEnabled = false
				countNicknameLabel.textColor = UIColor.white
				nicknameUnderBar.backgroundColor = UIColor.white
				isNicknameValid = false
				self.checkNicknameLabel.isHidden = true
				break
				
			case .specialCharErr:
				self.successBtn.isEnabled = true
				checkNicknameLabel.textColor = UIColor.red
				checkNicknameLabel.text = "특수문자를 사용할 수 없습니다."
				countNicknameLabel.textColor = UIColor.grey500
				
				nicknameUnderBar.backgroundColor = UIColor.red
				isNicknameValid = false
				self.checkNicknameLabel.isHidden = false
				break
				
			case .strangeCharErr:
				self.successBtn.isEnabled = true
				checkNicknameLabel.textColor = UIColor.red
				//        nicknameCheckLabel.text = I18N.SignUp.StrangeChar.errorAlert
				checkNicknameLabel.text = "닉네임형식이 올바르지 않습니다."
				countNicknameLabel.textColor = UIColor.grey500
				
				nicknameUnderBar.backgroundColor = UIColor.red
				isNicknameValid = false
				self.checkNicknameLabel.isHidden = false
				break
				
				
			case .normal :
				//세팅들
				self.successBtn.isEnabled = true
				isNicknameValid = true
				
				countNicknameLabel.textColor = UIColor.white
				nicknameUnderBar.backgroundColor = UIColor.white
				
				//        nicknameUnderBar.backgroundColor = UIColor.grey500
				
				self.checkNicknameLabel.isHidden = true
				break
				
			}
		}
	}
	
	private func pushTodoView() {
		//    guard let todoVC = self.storyboard?.instantiateViewController(identifier: "ToDoVC") as? ToDoVC else {return}
		//    self.navigationController?.pushViewController(todoVC, animated: true)
	}
	
	private func postNickNameData(nickName: String) {
		SignUpService.shared.signUp(socialToken: socialToken, socialType: socialType, nickname: nicknameInputTextField.text ?? "", personalityId: personalityId) { responseData in
			switch responseData {
			case .success(let successResponse):
				guard let response = successResponse as? SignUpData else {
					return
				}
				
				//닉네임 중복 여부 확인 -> ?
				self.pushTodoView()
				
//				if !data.duplicated { // w
//
//					self?.pushSignUpEmailVC()
//					self?.nextBtn.isEnabled = true //되돌아왔을때 pop 했을때 버튼 비활되어 있어서 다시 true해주기
//
//				} else { //중복 돠면 중복된 멘트 뜨게 해야하는데
//					// 빨간 테투리 뜨는 걸로
//					self?.nicknameCheckLabel.isHidden = false
//					//회원가입 버튼 비활
//					self?.setBtnStatus()
//					self?.nicknameCheckLabel.text = I18N.SignUp.NickName.errorAlert
//					self?.nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
//				}
				
			case .requestErr(let msg):
				print("requestERR \(msg)")
			case .pathErr:
				print("pathErr")
			case .serverErr:
				print("serverErr")
			case .networkFail:
				print("networkFail")
			}
		}
	}
	
	
	// MARK: - IBAction
	@IBAction func gotoTodoView(_ sender: Any) {
		startAnimation()
		
		successBtn.isEnabled = false //버튼 여러번 눌리는거 해결
		
		if let nicknameInputTextField = self.nicknameInputTextField.text {
			//      self.postNickNameData(nickName: nicknameInputTextField) // 서버 통신해서 중복 여부 체크 함수
			self.pushTodoView()
		}
		
	}
	
	
	// MARK: - @objc Function Part
	@objc func textFieldDidChange() {
		//10개 이상 입력 안되도록
		cutMaxLabel()
		//case나눈것
		alertNicknameStatus()
		//    checkMaxLabelCount() //글자수 체크 , 한글이나 이것저것
		setCountLabel() //글자수 값 바뀌는거 실시간으로
	}
	
}

// MARK: - Extension Part
extension NicknameVC : UITextFieldDelegate{
	internal func textFieldDidBeginEditing(_ textField: UITextField) {
		//텍스트가 있을 경우
		if textField.text == "ex. 딱새우회"{
			nicknameInputTextField.text = ""
			nicknameInputTextField.textColor = .black
			countNicknameLabel.textColor = UIColor.white
			nicknameUnderBar.backgroundColor = UIColor.white
		}
		nicknameUnderBar.backgroundColor = UIColor.white
		countNicknameLabel.textColor = UIColor.white
		
		
	}
	
	internal func textFieldDidEndEditing(_ textField: UITextField) {
		//비어있을 경우 --> 아무것도 뭐 없는디 ..
		if textField.text == nil {
			textField.text = "ex. 딱새우회"
			textField.textColor = .black
		}
		nicknameUnderBar.backgroundColor = UIColor.grey500
		countNicknameLabel.textColor = UIColor.grey500
	}
}

extension UITextField {
	func setClearButton(with image: UIImage, mode: UITextField.ViewMode) {
		let clearButton = UIButton(type: .custom)
		clearButton.setImage(image, for: .normal)
		clearButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
		clearButton.contentMode = .scaleAspectFit
		clearButton.addTarget(self, action: #selector(UITextField.clear(sender:)), for: .touchUpInside)
		self.addTarget(self, action: #selector(UITextField.displayClearButtonIfNeeded), for: .editingDidBegin)
		self.addTarget(self, action: #selector(UITextField.displayClearButtonIfNeeded), for: .editingChanged)
		self.rightView = clearButton
		self.rightViewMode = mode
	}
	
	@objc
	private func displayClearButtonIfNeeded() {
		self.rightView?.isHidden = (self.text?.isEmpty) ?? true
	}
	
	@objc
	private func clear(sender: AnyObject) {
		self.text = ""
		sendActions(for: .editingChanged)
	}
}

extension UIViewController {
	func hideKeyboard() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self,
																  action: #selector(UIViewController.dismissKeyboard))
		view.addGestureRecognizer(tap)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}
