//
//  ToDoVC.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

class ToDoVC: BaseVC {
    
    // MARK: - var & let
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
          .foregroundColor: UIColor.lightGrey1,
          .underlineStyle: NSUnderlineStyle.single.rawValue
      ]
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var originalButton: UIButton!
    @IBOutlet weak var archiveButton: UIButton!
    @IBOutlet weak var inforButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var checkBoxButton1: UIButton!
    @IBOutlet weak var checkBoxButton2: UIButton!
    @IBOutlet weak var checkBoxButton3: UIButton!
    @IBOutlet weak var checkBoxButton4: UIButton!
    
    @IBOutlet weak var missionLabel1: UILabel!
    @IBOutlet weak var missionLabel2: UILabel!
    @IBOutlet weak var missionLabel3: UILabel!
    @IBOutlet weak var missionLabel4: UILabel!
    
    // MARK: - @IBAction
    
    //메뉴 버튼
    @IBAction func touchUpToGoArchive(_ sender: Any) {
    }
    //오늘캐릭터끝내기 버튼
    @IBAction func touchUpToGoResult(_ sender: Any) {
        guard let vc = UIStoryboard(name: "ResultVC", bundle: nil).instantiateViewController(withIdentifier: "ResultVC") as? ResultVC else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    //새로고침 버튼
    @IBAction func againButton(_ sender: Any) {
        viewWillAppear(true)
    }
    //정보창 버튼
    @IBAction func inforButtonTapped(_ sender: Any) {
        MEEWPopUp.loadFromXib()
            .setTitle("귀여운 캐릭터 이름")
            .setDescription("캐릭터 설명, 캐릭터 설명, 캐릭터 설명, 캐릭터 설명")
            .present()
    }
    //오늘은나로살게요 버튼
    @IBAction func originalButtonTapped(_ sender: Any) {
    }
    
    // MARK: - 체크박스 구현
    
    @IBAction func checkBox1Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    @IBAction func checkBox2Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    @IBAction func checkBox3Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    @IBAction func checkBox4Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    // MARK: - Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("새로고침")
    }
    
    // MARK: - Custom Method
    
    func setView() {
        view.backgroundColor = .bgDarkgrey
        doneButton.layer.cornerRadius = 10
        originalButton.titleLabel?.textColor = .lightGrey1
        let attributeString = NSMutableAttributedString(
            string: "오늘은 원래의 나로 살게요",
            attributes: yourAttributes
        )
        originalButton.setAttributedTitle(attributeString, for: .normal)
        inforButton.layer.cornerRadius = 16
    }
}
