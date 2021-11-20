//
//  ResultVC.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

class ResultVC: BaseVC {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setCV()
    }
    
    private func setup() {
        resultImageView.layer.masksToBounds = true
        resultImageView.layer.cornerRadius = 8
    }
    
    private func setCV() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: ArchiveCVC.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ArchiveCVC.reuseIdentifier)
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
    }
}

extension ResultVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArchiveCVC.reuseIdentifier, for: indexPath) as? ArchiveCVC else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

extension ResultVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 117)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
    }
}
