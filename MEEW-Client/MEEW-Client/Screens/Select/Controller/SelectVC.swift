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
        registerCVC()
        initEventDataList()
        setUI()
        
        
        
    }
    
    
    func setUI(){
        backgroundView.layer.cornerRadius = 8
        selectCV.backgroundColor = .clear
//        selectCV.isPagingEnabled = true
        
          
          let screenWidth = UIScreen.main.bounds.width
//          let cellWidth = (290/375) * screenWidth
//          let cellHeight = cellWidth * (366/290)
//
          let insetX = (20/375) * screenWidth
          let layout = selectCV.collectionViewLayout as! UICollectionViewFlowLayout
          
          layout.itemSize = CGSize(width: 290, height: 366)
          layout.minimumLineSpacing = 12
          
          layout.scrollDirection = .horizontal
            selectCV.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
            selectCV.decelerationRate = .fast

    }
    
    
    func registerCVC() {
        selectCV.dataSource = self
        selectCV.delegate = self
        
        let xib = UINib(nibName: SelectCharacterCVC.identifier, bundle: nil)
        selectCV.register(xib, forCellWithReuseIdentifier: SelectCharacterCVC.identifier)
    }
    
    func initEventDataList(){
        characterList.append(contentsOf: [
            SelectCharacterDataModel(image: "img_1", name: "귀여운 캐릭터 이름", info: "캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다."),
            SelectCharacterDataModel(image: "img_2", name: "귀여운 캐릭터 이름", info: "캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다."),
            SelectCharacterDataModel(image: "img_3", name: "귀여운 캐릭터 이름", info: "캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다."),
            SelectCharacterDataModel(image: "img_4", name: "귀여운 캐릭터 이름", info: "캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다."),
            SelectCharacterDataModel(image: "img_5", name: "귀여운 캐릭터 이름", info: "캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다. 캐릭터설명 입니다.")
        ])
     }
    
    
    @IBAction func touchUpToGoToDoView(_ sender: Any) {
        //데이터 전달하면서 화면 전환
        
    }
    
    
    
}


// MARK: - Extension Part
extension SelectVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return characterList.count
  }

  //indexPath에 어떤 cell 데이터를 넣을 지 결정하는 메소드
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCharacterCVC.identifier, for: indexPath) as? SelectCharacterCVC else {return UICollectionViewCell()}

      cell.setData(appData: characterList[indexPath.row])
      return cell
  }
}

extension SelectVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let screenWidth = UIScreen.main.bounds.width
      let cellWidth = screenWidth * (290/375)
      let cellHeight = cellWidth * (366/290)
      return CGSize(width: cellWidth, height: cellHeight)
//        return CGSize(width: 290, height: 366)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      let screenWidth = UIScreen.main.bounds.width
      let cellWidth = screenWidth * (290/375)

      let cellInset = (screenWidth - cellWidth)/4

      if section == 0 {
          return UIEdgeInsets(top: 0, left: cellInset, bottom: 0, right: 0)
      }
      else if section == (characterList.count - 1) {
          return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cellInset)
      }
      else {
          return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      }
      
      
      
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      16
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      16
  }
}



extension SelectVC : UIScrollViewDelegate {

  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//    let page = Int(targetContentOffset.pointee.x / self.frame.width)
    let layout = selectCV.collectionViewLayout as! UICollectionViewFlowLayout
    let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

    var offSet = targetContentOffset.pointee
    let index = (offSet.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
    let roundedIndex = round(index)

    offSet = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
                     y: -scrollView.contentInset.top)
    targetContentOffset.pointee = offSet
//    self.pageControl.currentPage = Int(roundedIndex)
  }


}
