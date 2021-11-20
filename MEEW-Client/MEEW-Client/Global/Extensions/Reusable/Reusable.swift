//
//  Reusable.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/20.
//

import UIKit

// MARK: - Reusable 프로토콜, 클래스의 이름을 String으로 반환
public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - TableViewCell
// ex. TestTVC.reuseIdentifier로 클래스 이름에 접근
extension UITableViewCell: Reusable {}

// MARK: - CollectionViewCell
// ex. TestCVC.reuseIdentifier로 클래스 이름에 접근
extension UICollectionViewCell: Reusable {}
