//
//  ResultVC.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

struct ArchiveDummyModel {
    var image: UIImage
    var day: String
    var characterName: String
    var percent: CGFloat
    
    static func loadDummy() -> [ArchiveDummyModel] {
        return [
            ArchiveDummyModel(image: UIImage(named: "img_wind")!,
                              day: "SAT",
                              characterName: "즉흥적인 바람이",
                              percent: 70),
            ArchiveDummyModel(image: UIImage(named: "img_sky")!,
                              day: "FRI",
                              characterName: "참을성 있는 하늘이",
                              percent: 50),
            ArchiveDummyModel(image: UIImage(named: "img_honest")!,
                              day: "THU",
                              characterName: "성실한 정직이",
                              percent: 30),
            ArchiveDummyModel(image: UIImage(named: "img_sun")!,
                              day: "WED",
                              characterName: "적극적인 태양이",
                              percent: 90),
        ]
    }
}

class ResultVC: BaseVC {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultDescriptionLabel: UILabel!
    
    var dummyData: [ArchiveDummyModel] = ArchiveDummyModel.loadDummy() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var images: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setCV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        dismiss(animated: true, completion: nil)
    }
}

extension ResultVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArchiveCVC.reuseIdentifier, for: indexPath) as? ArchiveCVC else {
            return UICollectionViewCell()
        }
        cell.configure(data: dummyData[indexPath.row])
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
