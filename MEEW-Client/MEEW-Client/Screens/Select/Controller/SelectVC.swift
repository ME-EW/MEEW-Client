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
            SelectCharacterDataModel(image: "img_banghyang_select", name: "방향이", info: "방향이도 기여웡!"),
            SelectCharacterDataModel(image: "img_kotnim_select", name: "꽃님이", info: "꽃님이도 기여웡!")
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedIndexPath = indexPath
        
            
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }
    
    //indexPath에 어떤 cell 데이터를 넣을 지 결정하는 메소드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCharacterCVC.identifier, for: indexPath) as? SelectCharacterCVC else {return UICollectionViewCell()}
        
//        if indexPath.item == 0 {
//            cell.isSelected = true
//        }
        
        cell.setData(appData: characterList[indexPath.row])
        // switch case 써서 indexPath 0이면 빨간 체크 그거 , 1이면 노란놈체크로 이런식..? 아우씨 귀찮네
        // 저거 체크 빨간거 노란거 다 이미지로 달라고 해야겠다
        //맞지 저게 흠냐링 그냥 ㄷ그러게 근데 그러게
        //ㅇㅇㅇㅇ 그러고 데이터 전달 그런식으로 근데그걸 처리하기 편할라면
        //VC에서 하면 좋자나 어디에 didSelectRowat
        //extension 새로 만들어야함??? 잠만 찾아보고 올께링 저거 선언 ㅇㅇㅇ 아항 ㅇㅇ 근게 그거 선언을
        //ㅏㅇ니 지금 가이드가 안나와 개빡쳐 보봐 왜 가이드 안뜨지
        //그 함 찾아보께링....  감사 감사 근데 내일할래..ㅎ.ㅎ...하~ ㅋㅋㅋㅋㅋㅋ바이바이 감사링!
        //https://velog.io/@cooo002/ios-특정-collectionViewCell를-선택한-상태로-cell-생성하기
        
        return cell
    }
    
}

extension SelectVC: UICollectionViewDelegateFlowLayout {
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
