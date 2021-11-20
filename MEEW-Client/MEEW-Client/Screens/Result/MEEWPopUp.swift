//
//  MEEWPopUp.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

class MEEWPopUp: UIView {
    // MARK: - IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!

    // MARK: - Event
    
    private var eventHandler: ((_ type: EventType) -> Void)?

    enum EventType {
        case close
    }
    
    // MARK: - Life cycles

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.isHidden = true
        descriptionLabel.isHidden = true
        setup()
    }
    
    // MARK: - Setups
    
    func setup() {
        containerView.layer.cornerRadius = 16
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }

    func setTitle(_ text: String) -> Self {
        titleLabel.isHidden = false
        titleLabel.text = text
        return self
    }

    func setDescription(_ text: String) -> Self {
        descriptionLabel.isHidden = false
        descriptionLabel.text = text
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
            self.containerView.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }

    private func moveIn() {
        self.alpha = 0.0
        self.containerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        self.containerView.alpha = 0.0

        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        } completion: { _ in
            UIView.animate(withDuration: 0.05) {
                self.containerView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                self.containerView.alpha = 1.0
            } completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.containerView.transform = CGAffineTransform.identity
                }
            }
        }
    }
}
