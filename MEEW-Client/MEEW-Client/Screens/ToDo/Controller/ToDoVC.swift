//
//  ToDoVC.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/05/08.
//

import UIKit
import Alamofire

class ToDoVC: UIViewController {
  
  // MARK: - Properties
  let NickNameLabel = UILabel()
  let againButton = UIButton()
  let againLabel = UILabel()
  let imageView = UIImageView()
  let levelLabel = UILabel()
  let characterLabel = UILabel()
  let inforButton = UIButton()
  let doneButton = UIButton()
  let originalButton = UIButton()
  let checkBoxView = UIView()
  let backRectangle = UIView()
  var checkBoxButtons = [UIButton]()
  var missionLabels = [UILabel]()
  var lineViews = [UIView]()
  var levelViews = [UIView]()
  var backCheckboxViews = [UIView]()
  var todayCharacterInfo = TodayCharacterData(nickname: "", dataEnum: 0, name: "", level: 0, imageURL: "", chance: 0, finished: false, todo: [])
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    appendArrayUIProperties()
    layout()
    requestGetTodayCharacter()
    setNotification()
  }
  
  // MARK: - UI 구현
  func attributes() {
    layout()
    checkBoxLayout()
    missionsLayout()
    levelsLayout()
    lineLayout()
  }
  
  func layout() {
    view.backgroundColor = .grey700
    
    view.add(NickNameLabel) {
      $0.text = "오늘의 " + "\(self.todayCharacterInfo.nickname)" + "님"
      $0.font = .head3
      $0.textColor = .white
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(76)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
      }
    }
    view.add(againButton) {
      $0.setImage(UIImage(named: "ic_Refresh"), for: .normal)
      $0.addTarget(self, action: #selector(self.againButtonClicked(_:)), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(71)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-16)
      }
    }
    view.add(againLabel) {
      $0.text = "\(self.todayCharacterInfo.chance)" + "/3"
      $0.textColor = .grey400
      $0.font = .body6
      $0.snp.makeConstraints {
        $0.top.equalTo(self.againButton.snp.bottom).offset(5)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-22)
      }
    }
    view.add(imageView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.NickNameLabel.snp.bottom).offset(28)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.height.equalTo(168)
        $0.width.equalTo(168)
      }
    }
    let url = URL(string: self.todayCharacterInfo.imageURL)
    do {
      guard let url = url else { return }
      let data = try Data(contentsOf: url)
      imageView.image = UIImage(data: data)
    } catch { }
    view.add(characterLabel) {
      $0.text = self.todayCharacterInfo.name
      $0.textColor = .white
      $0.font = .head3
      $0.snp.makeConstraints {
        $0.top.equalTo(self.NickNameLabel.snp.bottom).offset(112)
        $0.leading.equalTo(self.view.snp.leading).offset(188)
      }
    }
    view.add(inforButton) {
      $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
      $0.tintColor = .white
      $0.addTarget(self, action: #selector(self.inforButtonClicked(_:)), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.characterLabel.snp.trailing).offset(10)
        $0.centerY.equalTo(self.characterLabel.snp.centerY)
        $0.width.equalTo(10)
        $0.height.equalTo(16)
      }
    }
    view.add(backRectangle) {
      $0.backgroundColor = .grey600
      $0.layer.cornerRadius = 8
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.characterLabel.snp.leading)
        $0.bottom.equalTo(self.characterLabel.snp.top).offset(-12)
        $0.width.equalTo(87)
        $0.height.equalTo(22)
      }
    }
    view.add(levelLabel) {
      $0.text = "Lv." + "\(self.todayCharacterInfo.level)"
      $0.textColor = Character.color[self.todayCharacterInfo.dataEnum]
      $0.font = .body3
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.backRectangle.snp.leading).offset(10)
        $0.centerY.equalTo(self.backRectangle.snp.centerY)
      }
    }
    view.add(checkBoxView) {
      $0.backgroundColor = .bgToDogrey
      $0.layer.cornerRadius = 7.93
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(322)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
        $0.height.equalTo(224)
      }
    }
    view.add(doneButton) {
      $0.setImage(UIImage(named: "btn_done"), for: .normal)
      $0.addTarget(self, action: #selector(self.doneButtonClicked(_:)), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.checkBoxView.snp.bottom).offset(68)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
        $0.width.equalTo(335)
      }
    }
    view.add(originalButton) {
      $0.setTitle("오늘은 원래의 나로 살게요", for: .normal)
      $0.setTitleColor(.grey400, for: .normal)
      $0.titleLabel?.font = .body3
      $0.setUnderline()
      $0.addTarget(self, action: #selector(self.originalButtonClicked(_:)), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.doneButton.snp.bottom).offset(16)
        $0.centerX.equalTo(self.view.snp.centerX)
      }
    }
  }
  
  func appendArrayUIProperties() {
    let level1Rectangle = UIView()
    let level2Rectangle = UIView()
    let level3Rectangle = UIView()
    let level4Rectangle = UIView()
    levelViews.append(level1Rectangle)
    levelViews.append(level2Rectangle)
    levelViews.append(level3Rectangle)
    levelViews.append(level4Rectangle)
    
    let missionLabel1 = UILabel()
    let missionLabel2 = UILabel()
    let missionLabel3 = UILabel()
    let missionLabel4 = UILabel()
    missionLabels.append(missionLabel1)
    missionLabels.append(missionLabel2)
    missionLabels.append(missionLabel3)
    missionLabels.append(missionLabel4)
    
    let checkBoxButton1 = UIButton()
    let checkBoxButton2 = UIButton()
    let checkBoxButton3 = UIButton()
    let checkBoxButton4 = UIButton()
    checkBoxButtons.append(checkBoxButton1)
    checkBoxButtons.append(checkBoxButton2)
    checkBoxButtons.append(checkBoxButton3)
    checkBoxButtons.append(checkBoxButton4)
    
    let lineView1 = UIView()
    let lineView2 = UIView()
    let lineView3 = UIView()
    lineViews.append(lineView1)
    lineViews.append(lineView2)
    lineViews.append(lineView3)
    
    let backCheckBoxView1 = UIView()
    let backCheckBoxView2 = UIView()
    let backCheckBoxView3 = UIView()
    let backCheckBoxView4 = UIView()
    backCheckboxViews.append(backCheckBoxView1)
    backCheckboxViews.append(backCheckBoxView2)
    backCheckboxViews.append(backCheckBoxView3)
    backCheckboxViews.append(backCheckBoxView4)
  }
  
  func levelsLayout() {
    for level in levelViews {
      let idx = levelViews.firstIndex(of: level) ?? 0
      view.add(level) {
        $0.layer.cornerRadius = 2
        $0.backgroundColor = (idx+1) <= self.todayCharacterInfo.level
        ? Character.color[self.todayCharacterInfo.dataEnum]
        : .grey700
        $0.snp.makeConstraints {
          $0.leading.equalTo(self.backRectangle.snp.leading).offset(41+(10*idx))
          $0.centerY.equalTo(self.backRectangle.snp.centerY)
          $0.width.equalTo(6)
          $0.height.equalTo(6)
        }
      }
    }
  }
  
  func checkBoxLayout() {
    for backView in backCheckboxViews {
      let idx = backCheckboxViews.firstIndex(of: backView) ?? 0
      view.add(backView) {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 6
        $0.snp.makeConstraints {
          $0.leading.equalTo(self.checkBoxView.snp.leading).offset(18)
          $0.top.equalTo(self.checkBoxView.snp.top).offset(18+56*idx)
          $0.width.equalTo(20)
          $0.height.equalTo(20)
        }
      }
    }
    for bt in checkBoxButtons {
      let idx = checkBoxButtons.firstIndex(of: bt) ?? 0
      view.add(bt) {
        $0.setImage(UIImage(named: "ic_uncheck"), for: .normal)
        $0.setImage(UIImage(named: "ic_check")?.withRenderingMode(.alwaysTemplate), for: .selected)
        $0.contentMode = .scaleToFill
        $0.tintColor = Character.color[self.todayCharacterInfo.dataEnum]
        $0.isSelected = self.todayCharacterInfo.todo[idx].complete
        $0.tag = self.todayCharacterInfo.todo[idx].taskID
        $0.addTarget(self, action: #selector(self.checkBoxClicked(_:)), for: .touchUpInside)
        $0.snp.makeConstraints {
          $0.leading.equalTo(self.checkBoxView.snp.leading).offset(18)
          $0.top.equalTo(self.checkBoxView.snp.top).offset(18+56*idx)
          $0.width.equalTo(20)
          $0.height.equalTo(20)
        }
      }
    }
  }
  
  func missionsLayout() {
    for mission in missionLabels {
      let idx = missionLabels.firstIndex(of: mission) ?? 0
      view.add(mission) {
        $0.text = self.todayCharacterInfo.todo[idx].content
        $0.textColor = .grey200
        $0.font = .body2
        $0.snp.makeConstraints {
          $0.leading.equalTo(self.checkBoxView.snp.leading).offset(48)
          $0.centerY.equalTo(self.checkBoxButtons[idx].snp.centerY)
        }
      }
    }
  }
  
  func lineLayout() {
    for line in lineViews {
      let idx = lineViews.firstIndex(of: line) ?? 0
      view.add(line) {
        $0.backgroundColor = .grey500
        $0.snp.makeConstraints {
          $0.top.equalTo(self.checkBoxView.snp.top).offset(56+56*idx)
          $0.leading.equalTo(self.checkBoxView.snp.leading).offset(8)
          $0.trailing.equalTo(self.checkBoxView.snp.trailing).offset(-8)
          $0.height.equalTo(0.5)
        }
      }
    }
  }
  
  // MARK: - Custom Method
  func changeFinishedView() {
    againButton.isHidden = true
    againLabel.isHidden = true
    checkBoxView.isHidden = true
    originalButton.isHidden = true
    doneButton.isUserInteractionEnabled = false
    doneButton.setImage(UIImage(named: "btn_finished"), for: .normal)
    for backView in backCheckboxViews {
      backView.isHidden = true
    }
    for bt in checkBoxButtons {
      if (bt.isSelected == false) {
        bt.layer.isHidden = true
      } else {
        bt.setImage(UIImage(named: "complete")?.withRenderingMode(.alwaysTemplate), for: .selected)
        bt.tintColor = Character.color[self.todayCharacterInfo.dataEnum]
        bt.isUserInteractionEnabled = false
      }
    }
  }
  
  func setNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(didReceiveYesButtonNotification(_:)), name: NSNotification.Name("didTapYesButton"), object: nil)
  }
  
  // MARK: - @objc
  @objc func againButtonClicked(_ sender: UIButton) {
    if todayCharacterInfo.chance != 0 {
      requestGetNewTodayCharacter()
    } else {
      print("새로고침 기회 모두 소진")
    }
  }
  
  @objc func originalButtonClicked(_ sender: UIButton) {
    requestGetOriginalMyTodayCharacter()
  }
  
  @objc func checkBoxClicked(_ sender: UIButton) {
    print(sender.tag)
    requestPatchTODO(taskId: sender.tag)
    sender.tintColor = Character.color[self.todayCharacterInfo.dataEnum]
    sender.isSelected.toggle()
  }
  
  @objc func doneButtonClicked(_ sender: UIButton) {
    if (todayCharacterInfo.level == 4) {
      postEndTodayCharacter()
      changeFinishedView()
    } else {
      let alertPopupVC = FinishedModalVC()
      alertPopupVC.modalPresentationStyle = .overCurrentContext
      alertPopupVC.modalTransitionStyle = .crossDissolve
      self.present(alertPopupVC, animated: true, completion: nil)
    }
  }
  
  @objc func didReceiveYesButtonNotification(_ notification: Notification) {
    changeFinishedView()
  }
  
  @objc func inforButtonClicked(_ sender: UIButton) {
    let bottomSheetVC = BottomSheetVC(contentViewController: ContentVC())
    bottomSheetVC.modalPresentationStyle = .overFullScreen
    self.present(bottomSheetVC, animated: false, completion: nil)
  }
}

extension ToDoVC {
  func requestGetTodayCharacter() {
    GetTodayCharacter.shared.getTodayCharacter { networkResult in
      switch networkResult {
      case .success(let result):
        guard let response = result as? TodayCharacterRequestModel else { return }
        if let userData = response.data {
          self.todayCharacterInfo = userData
          self.attributes()
          if userData.finished {
            self.changeFinishedView()
          }
        }
        print(response.message)
      case .requestErr(let msg):
        print("requestErr \(msg)")
      case .pathErr:
        print("pathErr")
      case .serverErr:
        print("serverErr")
      case .networkFail:
        print("networkFail")
      }
    }
  }
  
  func requestGetNewTodayCharacter() {
    GetTodayCharacter.shared.getNewTodayCharacter { networkResult in
      switch networkResult {
      case .success(let result):
        guard let response = result as? TodayCharacterRequestModel else { return }
        if let userData = response.data {
          self.todayCharacterInfo = userData
          self.attributes()
        }
        print(response.message)
      case .requestErr(let msg):
        print("requestErr \(msg)")
      case .pathErr:
        print("pathErr")
      case .serverErr:
        print("serverErr")
      case .networkFail:
        print("networkFail")
      }
    }
  }
  
  func requestGetOriginalMyTodayCharacter() {
    GetTodayCharacter.shared.getOriginalMyCharacter { networkResult in
      switch networkResult {
      case .success(let result):
        guard let response = result as? TodayCharacterRequestModel else { return }
        if let userData = response.data {
          self.todayCharacterInfo = userData
          self.attributes()
          self.originalButton.isHidden = true
          self.againButton.isHidden = true
          self.againLabel.isHidden = true
        }
        print(response.message)
      case .requestErr(let msg):
        print("requestErr \(msg)")
      case .pathErr:
        print("pathErr")
      case .serverErr:
        print("serverErr")
      case .networkFail:
        print("networkFail")
      }
    }
  }
  
  func requestPatchTODO(taskId: Int) {
    GetTodayCharacter.shared.patchToDo(taskId: taskId) { networkResult in
      switch networkResult {
      case .success(let result):
        guard let response = result as? TodayCharacterRequestModel else { return }
        if let userData = response.data {
          self.todayCharacterInfo = userData
          self.attributes()
        }
        print(response.message)
      case .requestErr(let msg):
        print("requestErr \(msg)")
      case .pathErr:
        print("pathErr")
      case .serverErr:
        print("serverErr")
      case .networkFail:
        print("networkFail")
      }
    }
  }
  
  func postEndTodayCharacter() {
    GetTodayCharacter.shared.postEndTodayCharacter { networkResult in
      switch networkResult {
      case .success(let result):
        guard let response = result as? TodayCharacterRequestModel else { return }
        print(response.message)
      case .requestErr(let msg):
        print("requestErr \(msg)")
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
