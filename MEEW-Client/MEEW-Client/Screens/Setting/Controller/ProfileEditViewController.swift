//
//  ProfileEditViewController.swift
//  MEEW-Client
//
//  Created by taehy.k on 2022/06/10.
//

import UIKit

final class ProfileEditViewController: UIViewController {
    
    private let navigationBarView = NavigationBarView(hasDoneButton: true)
    private let nicknameTitleLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 12)!
        $0.textColor = .grey400
    }
    private let profileEditTextField = UITextField().then {
        $0.font = .body1
        $0.textColor = .white
    }
    
    private var nickname: String = "meew@sopt.com"
    let border = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavItem()
        configureHierarchy()
        configureLayout()
    }
    
    override func viewDidLayoutSubviews() {
        configureTextField()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func configureUI() {
        view.backgroundColor = .grey700
        profileEditTextField.text = nickname
    }
    
    private func configureNavItem() {
        navigationBarView.navigationTitleLabel.text = "내 프로필 설정"
    }
    
    private func configureHierarchy() {
        view.addSubviews([navigationBarView, nicknameTitleLabel, profileEditTextField])
    }
    
    private func configureLayout() {
        navigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        nicknameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        
        profileEditTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
    }
    
    private func configureTextField() {
        profileEditTextField.delegate = self
        profileEditTextField.setClearButton(with: UIImage(named:"btn_delete")!, mode: .whileEditing)
        profileEditTextField.layer.addSublayer(border)
        
        updateBorder(textField: profileEditTextField, color: UIColor.grey400, width: 1.0)
    }
    
    
    func updateBorder(textField: UITextField, color: UIColor, width: CGFloat) -> Void {
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0.0, y: textField.frame.size.height + width, width: textField.frame.size.width, height: width)
    }
}

extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateBorder(textField: textField, color: UIColor.white, width: 1.0)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateBorder(textField: textField, color: UIColor.grey400, width: 1.0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
