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
          
          layout.itemSize = CGSize(width: 290, height: 370)
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
            SelectCharacterDataModel(image: "img_heart", name: "마음이", info: "마음이는 늘 상대방의 마음을 먼저 생각해요. \n항상 타인의 말에 웃어주고, 공감해주고, 양보할 줄 알아요."),
            SelectCharacterDataModel(image: "img_honest", name: "정직이", info: "정직이의 하루는 남들보다 빠르게 시작돼요. 건강하고, 규칙적이고, 계획적인 성격을 가지고 있죠."),
            SelectCharacterDataModel(image: "img_sun", name: "태양이", info: "태양이는 이름 그대로 늘 맑고 긍정적이에요. 덕분에 모든 일에 적극적으로 참여하고 도전하죠."),
            SelectCharacterDataModel(image: "img_sky", name: "하늘이", info: "하늘이는 넓은 마음씨를 가지고 있어요. 그래서 대부분의 상황에서 참을성있게 행동할 줄 알아요."),
            SelectCharacterDataModel(image: "img_wind", name: "바람이", info: "바람이는 어디로 불지 모르는 성격이에요. \n그래서 계획적이기보다는 마음가는 대로 즐겁게 살아가고 있죠.")
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
      let cellHeight = cellWidth * (370/290)
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
