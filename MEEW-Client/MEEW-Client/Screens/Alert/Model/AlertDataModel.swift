//
//  AlertDataModel.swift
//  MEEW-Client
//
//  Created by 안현주 on 2022/08/18.
//

import Foundation
import UIKit

struct AlertDataModel{
	
	var alertImage : UIImage?
	var alertMessage : String
	var alertDate : String
	
}

extension AlertDataModel{
	static let sampleData: [AlertDataModel] = [
		AlertDataModel(alertImage: UIImage(named: "logo_new"), alertMessage: "보민님, 아직 2개의 미션이 남았어요! 어서 완료해주세요.", alertDate: "08월 17일"),
		AlertDataModel(alertImage: UIImage(named: "logo_new"), alertMessage: "새로운 캐릭터가 추가되었어요! 확인해보러 갈까요?", alertDate: "08월 17일"),
		AlertDataModel(alertImage: UIImage(named: "logo_new"), alertMessage: "오늘의 캐릭터 리포트를 읽어보세요.", alertDate: "08월 17일"),
		AlertDataModel(alertImage: UIImage(named: "logo_new"), alertMessage: "보민님, 아직 2개의 미션이 남았어요! 어서 완료해주세요.", alertDate: "08월 17일"),
		AlertDataModel(alertImage: UIImage(named: "logo_new"), alertMessage: "보민님, 아직 2개의 미션이 남았어요! 어서 완료해주세요.", alertDate: "08월 17일"),
		AlertDataModel(alertImage: UIImage(named: "logo_new"), alertMessage: "보민님보민님보민님보민님, 아직 2개의 미션이 남았어요! 어서 완료해주세요.", alertDate: "08월 17일")
	]
}
