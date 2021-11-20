//
//  CompletePopUp.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

class CompletePopUp: UIView {
    @IBOutlet weak var completeContainerView: UIView!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var completeDescriptionLabel: UILabel!
    
    // MARK: - Event
    
    private var eventHandler: ((_ type: EventType) -> Void)?

    enum EventType {
        case close
    }
    
    // MARK: - Life cycles

    override func awakeFromNib() {
        super.awakeFromNib()
        completeDescriptionLabel.isHidden = true
        setup()
    }
    
    // MARK: - Setups
    
    func setup() {
        completeContainerView.layer.cornerRadius = 16
    }


    func setDescription(_ text: String) -> Self {
        completeDescriptionLabel.isHidden = false
        completeDescriptionLabel.text = text
        return self
    }
    
    // MARK: - Actions

    @objc private func closeAction(_ sender: UIButton) {
        closeView(.close)
    }


    // MARK: - Animations
    func present() {
        DispatchQueue.main.async {
            self.frame = UIScreen.main.bounds
            AppDelegate.currentKeyWindow?.addSubview(self)
            UIApplication.topViewController()?.view.endEditing(false)
            self.moveIn()
        }
    }
    
    private func closeView(_ type: EventType) {
        eventHandler?(type)
        moveOut()
    }

    private func moveOut() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 0
            self.completeContainerView.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }

    private func moveIn() {
        self.alpha = 0.0
        self.completeContainerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        self.completeContainerView.alpha = 0.0

        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        } completion: { _ in
            UIView.animate(withDuration: 0.05) {
                self.completeContainerView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                self.completeContainerView.alpha = 1.0
            } completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.completeContainerView.transform = CGAffineTransform.identity
                }
            }
        }
    }
}
