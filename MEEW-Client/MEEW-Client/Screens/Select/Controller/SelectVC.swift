//
//  SelectVC.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

class SelectVC: BaseVC {
    
    
    @IBOutlet weak var selectCV: UICollectionView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    var characterList:[SelectCharacterDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        initEventDataList()
        
    }
    
    
    func setUI(){
        backgroundView.layer.cornerRadius = 8
    }
    
//    func registerCVC() {
//        selectCV.dataSource = self
//        selectCV.delegate = self
//
//        let  = UINib(nibName: HomeEventItemCVC.identifier, bundle: nil)
//        eventCV.register(eventitemCVC, forCellWithReuseIdentifier: HomeEventItemCVC.identifier)
//    }
    
    func initEventDataList(){
        characterList.append(contentsOf: [
            SelectCharacterDataModel(image: "img_1", name: "귀여운 캐릭터 이름", info: "캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다."),
            SelectCharacterDataModel(image: "img_2", name: "귀여운 캐릭터 이름", info: "캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다."),
            SelectCharacterDataModel(image: "img_3", name: "귀여운 캐릭터 이름", info: "캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다."),
            SelectCharacterDataModel(image: "img_4", name: "귀여운 캐릭터 이름", info: "캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다."),
            SelectCharacterDataModel(image: "img_5", name: "귀여운 캐릭터 이름", info: "캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다.")
        ])
     }
    
    
}


// MARK: - Extension Part
//extension SelectVC: UICollectionViewDataSource {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//      return imgName.count
//  }
//
//  //indexPath에 어떤 cell 데이터를 넣을 지 결정하는 메소드
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeEventItemCVC.identifier, for: indexPath) as? HomeEventItemCVC else {return UICollectionViewCell()}
//
//      cell.setData(appData: imgName[indexPath.row])
//      return cell
//  }
//}
//
//extension SelectVC: UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      let screenWidth = UIScreen.main.bounds.width
//      let cellWidth = screenWidth
//      let cellHeight = cellWidth * (200/375)
//      return CGSize(width: cellWidth, height: cellHeight)
////        return CGSize(width: 375, height: 200)
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//      UIEdgeInsets.zero
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//      0
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//      0
//  }
//}
