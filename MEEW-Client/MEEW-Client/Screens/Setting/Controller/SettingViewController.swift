//
//  SettingViewController.swift
//  MEEW-Client
//
//  Created by taehy.k on 2022/06/08.
//

import UIKit

final class SettingViewController: BaseVC {
    
    let navigationBarView = NavigationBarView()
    let profileView = ProfileView()
    let notiSettingRow = SettingRow()
    let infoView = InfoView()
    let versionInfoRow = SettingRow(isVersionRow: true)
    let logoutButton = UIButton().then {
        $0.setTitleColor(.grey400, for: .normal)
        $0.setTitle("로그아웃", for: .normal)
        $0.titleLabel?.font = UIFont.body1
    }
    let withdrawalMessageLabel = UILabel().then {
        $0.text = "미우를 탈퇴하려면 여기를 눌러주세요."
        $0.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 12)!
        $0.textColor = .grey400
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
        configureNaivagtion()
    }
    
    private func setStyle() {
        view.backgroundColor = .grey700
        profileView.name = "이보민 님"
        profileView.email = "meew@sopt.com"
        notiSettingRow.rowTitle = "알림 설정"
        versionInfoRow.rowTitle = "버전 정보"
        
        let attributedString = NSMutableAttributedString(string: withdrawalMessageLabel.text!)
        attributedString.addAttribute(.foregroundColor, value: UIColor.orange, range: (withdrawalMessageLabel.text! as NSString).range(of: "여기"))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: (withdrawalMessageLabel.text! as NSString).range(of: "여기"))
        withdrawalMessageLabel.attributedText = attributedString
    }
    
    private func setLayout() {
        view.addSubviews([navigationBarView, profileView, notiSettingRow, infoView, versionInfoRow, logoutButton, withdrawalMessageLabel])
        navigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(116)
        }
        
        notiSettingRow.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(84)
        }
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(notiSettingRow.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(242)
        }
    
        versionInfoRow.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(versionInfoRow.snp.bottom).offset(99)
            $0.centerX.equalToSuperview()
        }
        
        withdrawalMessageLabel.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func configureNaivagtion() {
        profileView.manageButtonClosure = {
            let profileEditViewController = ProfileEditViewController()
            self.navigationController?.pushViewController(profileEditViewController, animated: true)
        }
        
        navigationBarView.dismissClosure = {
            self.dismiss(animated: true)
        }
    }
}
