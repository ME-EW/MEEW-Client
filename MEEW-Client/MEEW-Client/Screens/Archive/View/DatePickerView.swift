//
//  DatePickerView.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/25.
//

import UIKit

import SnapKit
import Then

final class DatePickerView: UIView {
    
    static let shared = DatePickerView()
 
    private lazy var datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .inline
        $0.locale = Locale(identifier: "ko-KR")
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
        $0.overrideUserInterfaceStyle = .dark
        $0.backgroundColor = .grey500
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.hide()
    }
    
    func setupConstraints() {
        self.backgroundColor = .black.withAlphaComponent(0.5)
        self.addSubview(self.datePicker)

        self.datePicker.snp.makeConstraints {
            $0.center.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        datePicker.subviews.first?.subviews.first?.subviews.first?.tintColor = .white
    }
    
    func show() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        guard let sceneDelegate = windowScene?.delegate as? SceneDelegate else { return }

        guard !(sceneDelegate.window?.subviews.contains(where: { $0 is DatePickerView }))! else { return }
        sceneDelegate.window?.rootViewController?.view.addSubview(self)
        self.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.layoutIfNeeded()
    }
    
    func hide() {
        self.removeFromSuperview()
    }
}
