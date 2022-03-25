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
    @IBOutlet weak var SelectCVCHeightConstraint: NSLayoutConstraint!{
        didSet {
            updateConstraint()
        }
    }
    
    var characterList:[SelectCharacterDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //✅ 서버연결 시 사용할 원래 코드
        //        getCharacterData()
        registerCVC()
        //❌ UI 점검용으로 사용할 코드
        initEventDataList()
        setUI()
    }
    
    private func updateConstraint(){
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (315/375) * screenWidth
        let cellHeight = cellWidth * (396/315)
        SelectCVCHeightConstraint.constant = cellHeight + 20
    }
    
    private func setUI(){
        selectCV.collectionViewLayout = SelectCarouselLayout()
        
        backgroundView.layer.cornerRadius = 8
        selectCV.backgroundColor = .clear
        
        let screenWidth = UIScreen.main.bounds.width

        let insetX = (20/375) * screenWidth
        let layout = selectCV.collectionViewLayout as! UICollectionViewFlowLayout
        
        
        //Fix 한거 수정하기..!
        let itemWidth = (315/375) * screenWidth
        let itemHeight = itemWidth * (396/315)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        

        layout.scrollDirection = .horizontal
        selectCV.decelerationRate = .fast
    }
    
    private func registerCVC() {
        selectCV.dataSource = self
        selectCV.delegate = self
        
        let xib = UINib(nibName: SelectCharacterCVC.identifier, bundle: nil)
        selectCV.register(xib, forCellWithReuseIdentifier: SelectCharacterCVC.identifier)
    }
    
    //❌ UI 점검용으로 사용할 코드
    private func initEventDataList(){
        characterList.append(contentsOf: [
            SelectCharacterDataModel(image: "img_taeyang_select", name: "태양이", info: "태양이는 이름 그대로 늘 맑고 긍정적이에요. 덕분에 모든 일에 적극적으로 참여하고 도전하죠."),
            SelectCharacterDataModel(image: "img_maeum_select", name: "마음이", info: "마음이는 기여웡!"),
            SelectCharacterDataModel(image: "img_jungjik_select", name: "정직이", info: "정직이도 기여웡!"),
            SelectCharacterDataModel(image: "img_haneul_select", name: "하늘이", info: "하늘이는 넓은 마음씨를 가지고 있어요. 그래서 대부분의 상황에서 참을성있게 행동할 줄 알아요."),
            SelectCharacterDataModel(image: "img_gureum_select", name: "구름이", info: "구름이도 기여웡!"),
            SelectCharacterDataModel(image: "img_baram_select", name: "바람이", info: "바람이는 어디로 불지 모르는 성격이에요. \n그래서 계획적이기보다는 마음가는 대로 즐겁게 살아가고 있죠."),
            SelectCharacterDataModel(image: "img_banghyang_select", name: "방향이", info: "방향이도 기여웡!")
        ])
    }
    
    @IBAction func touchUpToGoToDoView(_ sender: Any) {
        //싹 다 닉네임뷰로 이동하는걸로 변경해야함
        CompletePopUp.loadFromXib()
            .setDescription("나의 캐릭터가 마음이로 선택되었어요!")
            .present()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            //데이터 전달하면서 화면 전환 해야함..!
            guard let vc = UIStoryboard(name: "ToDoVC", bundle: nil).instantiateViewController(withIdentifier: "ToDoVC") as? ToDoVC else { return }
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
        
        
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
        
        if indexPath.item == 0 {
            cell.isSelected = true
        }
        
        cell.setData(appData: characterList[indexPath.row])
        return cell
    }
}

extension SelectVC: UICollectionViewDelegateFlowLayout {
    
//      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//          let screenWidth = UIScreen.main.bounds.width
//          let cellWidth = screenWidth * (315/375)
//          let cellHeight = cellWidth * (396/315)
//          return CGSize(width: cellWidth, height: cellHeight)
//      }
//
//      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//          let screenWidth = UIScreen.main.bounds.width
//          let cellWidth = screenWidth * (315/396)
//          let cellInset = (screenWidth - cellWidth)/2
//
//          return UIEdgeInsets(top: 0, left: cellInset, bottom: 0, right: cellInset)
          
//          if section == 0 {
//              return UIEdgeInsets(top: 0, left: cellInset, bottom: 0, right: 0)
//          }
//          else if section == (characterList.count ) {
//              return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cellInset)
//          }
//          else {
//              return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//          }
//      }
//
//      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//          10
//      }
//
//      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//          0
//      }
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let count = 5
        //cell의 x 값 / 우리의 기기의 *  count ==> 인덱스 번호
    }
}


extension SelectVC {
    func getCharacterData() {
        CharacterListService.shared.readCharacterData { responseData in
            switch  responseData {
            case .success(let successResponse):
                guard let response = successResponse as? CharacterRequestData else { return }
                self.characterList = []
                //설정해주는 부분
                if let userData = response.data {
                    for charactor in userData{
                        let charData = SelectCharacterDataModel(image: charactor.images[0],
                                                                name: charactor.name,
                                                                info: charactor.description)
                        self.characterList.append(charData)
                    }
                    
                    self.selectCV.reloadData()
                    print(userData)
                }
            case .requestErr(let msg):
                print("requestERR \(msg)")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
