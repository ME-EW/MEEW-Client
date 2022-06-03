//
//  LoadingView.swift
//  MEEW-Client
//
//  Created by 안현주 on 2022/06/03.
//

import UIKit

class LoadingView: UIView {

  @IBOutlet var dots : [UIView]! {
    didSet {
      dots[0].layer.cornerRadius = 7/2
      dots[1].layer.cornerRadius = 7/2
      dots[2].layer.cornerRadius = 7/2
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initXIB()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    initXIB()
  }
  
  func initXIB() {
    guard let view = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as? UIView else {return}
    
    view.frame = self.bounds
    self.addSubview(view)
    
  }
  
  func startAnimation() {
    for index in 0..<dots.count {
      dots[index].transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
      UIView.animate(withDuration: 0.6, delay: Double(index+1) * 0.2, options: [.repeat, .autoreverse], animations: {self.dots[index].transform = CGAffineTransform.identity}, completion: nil)
    }
  }
  
}
