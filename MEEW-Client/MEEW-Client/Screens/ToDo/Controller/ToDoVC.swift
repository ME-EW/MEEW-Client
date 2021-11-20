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
    
    @IBAction func touchUpToGoResult(_ sender: Any) {
        guard let vc = UIStoryboard(name: "ResultVC", bundle: nil).instantiateViewController(withIdentifier: "ResultVC") as? ResultVC else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func againButton(_ sender: Any) {
        requestData()
    }
    
    @IBAction func inforButtonTapped(_ sender: Any) {
        MEEWPopUp.loadFromXib()
            .setTitle("귀여운 캐릭터 이름")
            .setDescription("캐릭터 설명, 캐릭터 설명, 캐릭터 설명, 캐릭터 설명")
            .present()
    }
    
    @IBAction func originalButtonTapped(_ sender: Any) {
        //오늘은나로살게요 버튼 - 수정하기
        guard let vc = UIStoryboard(name: "ToDoVC", bundle: nil).instantiateViewController(withIdentifier: "VCVC") as? VCVC else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
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
        requestData()
    }
    override func viewWillAppear(_ animated: Bool) {
        //
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
    
    func requestData() {
        GetToDoService.shared.getToDoInfo { (response) in
            switch(response) {
            case .success(let todoData):
                if let data = todoData as? DataClass {
                    //라벨 - for문 수정
                    self.missionLabel1.text = data.todoLists[0].todo
                    self.missionLabel2.text = data.todoLists[1].todo
                    self.missionLabel3.text = data.todoLists[2].todo
                    self.missionLabel4.text = data.todoLists[3].todo
                    //이미지
                    let url = URL(string: data.images[1])
                    do {
                        let data = try Data(contentsOf: url!)
                        self.imageView.image = UIImage(data: data)
                    }
                    catch{
                    }
                    //캐릭터이름
                    let name = ["성실한 정직이", "적극적인 태양이", "참을성있는 하늘이", "즉흥적인 바림이"].randomElement()
                    self.inforButton.setTitle(name, for: .normal)
                }
            case .requestErr(let message):
                print("requestErr", message)
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
