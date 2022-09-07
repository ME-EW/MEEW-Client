//
//  SelectVC.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

class SelectVC: BaseVC {
	
	var characterList:[SelectCharacterDataModel] = []
	var characterName: String = "마음이"
	
	@IBOutlet weak var selectCV: UICollectionView!
	@IBOutlet weak var backgroundView: UIView!{
		didSet{
			backgroundView.layer.cornerRadius = 8
			backgroundView.backgroundColor = .grey600
		}
	}
	@IBOutlet weak var nextBtn: UIButton!{
		didSet {
			nextBtn.isEnabled = false
			if nextBtn.isEnabled == false {
				nextBtn.titleLabel?.textColor = .grey400
			} else {
				nextBtn.titleLabel?.textColor = .grey700
			}
		}
	}
	@IBOutlet weak var SelectCVCHeightConstraint: NSLayoutConstraint!{
		didSet {
			updateConstraint()
		}
	}
	@IBOutlet weak var pager: UIPageControl!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		registerCVC()
		setUI()
		getCharacterData()
		setPager()
		addNotiObserver()
	}
	
	private func setPager() {
		pager.numberOfPages = 8
		pager.currentPage = 0
		pager.pageIndicatorTintColor = UIColor.grey500
		pager.currentPageIndicatorTintColor = UIColor.white
	}
	
	private func updateConstraint(){
		let screenWidth = UIScreen.main.bounds.width
		let cellWidth = (315/375) * screenWidth
		let cellHeight = cellWidth * (396/315)
		SelectCVCHeightConstraint.constant = cellHeight + 20
	}
	
	private func setUI(){
		selectCV.collectionViewLayout = SelectCarouselLayout()
		
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
	
	private func addNotiObserver() {
		print("11")
		NotificationCenter.default.addObserver(self, selector: #selector(alertCharacterName(_:)), name:  NSNotification.Name(rawValue: "characterName"), object: nil)
		print("22")
	}
	
	@IBAction func touchUpToGoToDoView(_ sender: Any) {
		//싹 다 닉네임뷰로 이동하는걸로 변경해야함
		
		CompletePopUp.loadFromXib()
			.setDescription("나의 캐릭터가 \(String(describing: characterName))로 선택되었어요!")
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
	
	@IBAction func pageChanged(_ sender: UIPageControl) {
		let indexPath = IndexPath(item: sender.currentPage, section: 0)
		// 인덱스패스위치로 컬렉션 뷰를 스크롤
		selectCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
	@objc func alertCharacterName(_ notification: NSNotification)  {
		print("33")
		if let text = notification.object as? String{
			characterName = text
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
		
		
		cell.active = { [weak self] in
			guard let self = self else {return}
			self.nextBtn.titleLabel?.textColor = .grey700
			self.nextBtn.isEnabled = true
			self.nextBtn.layer.cornerRadius = 8
			self.nextBtn.backgroundColor = .white
		}
		
		cell.setData(appData: characterList[indexPath.row])
		
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
		let width = scrollView.bounds.size.width
		let screenWidth = UIScreen.main.bounds.width
		
		// 좌표보정을 위해 절반의 너비를 더해줌
		let x = scrollView.contentOffset.x + (width/2)
		let newPage = Int(round(x / width))
		
		if pager.currentPage != newPage {
			pager.currentPage = newPage
		}
		if (x/screenWidth == 207/414) {
			pager.currentPage = 0
		}
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
					if let useData = userData.personalities {
						for charactor in useData{
							let charData = SelectCharacterDataModel(id: charactor.id, image: charactor.mainImg,
																name: charactor.name,
																description: charactor.description)
							self.characterList.append(charData)
						}
						self.selectCV.reloadData()
//						DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//							self.setPager()
//						}
					}
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
