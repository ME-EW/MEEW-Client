//
//  UIView+.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

// MARK: - load xib
extension UIView {
    static func loadFromXib(withOwner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> Self {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)

        guard let view = nib.instantiate(withOwner: withOwner, options: options).first as? Self else {
            fatalError("Could not load view from nib file.")
        }
        return view
    }
  func addSubviews(_ view: [UIView]) {
    view.forEach { self.addSubview($0) }
  }
  @discardableResult
  func add<T: UIView>(_ subview: T,
                      then closure: ((T) -> Void)? = nil) -> T {
    addSubview(subview)
    closure?(subview)
    return subview
  }
  func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
    clipsToBounds = true
    layer.cornerRadius = cornerRadius
    layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
  }
  func addGradientWithColor(color: UIColor) {
    let gradient = CAGradientLayer()
    gradient.frame = self.bounds
    gradient.colors = [UIColor.clear.cgColor, color.cgColor]
    
    self.layer.insertSublayer(gradient, at: 0)
  }
}
