//
//  AlertViewController.swift
//  MEEW-Client
//
//  Created by 안현주 on 2022/08/18.
//

import UIKit

class AlertViewController: UIViewController {

	@IBOutlet weak var navigationBar: UINavigationBar!
	
	@IBOutlet weak var alertTableView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
		registerCells()
    }
	
	private func setUI(){
		navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		navigationBar.shadowImage = UIImage()
		alertTableView.backgroundColor = .grey700
		navigationBar.barTintColor = .grey700
		view.backgroundColor = .grey700
	}
	
	private func registerCells(){
		let nib = UINib(nibName: "AlertTableViewCell", bundle: nil)
		alertTableView.register(nib, forCellReuseIdentifier: "AlertTableViewCell")
		
		alertTableView.delegate = self
		alertTableView.dataSource = self
		
		
	}
    


}

extension AlertViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertTableViewCell", for: indexPath) as? AlertTableViewCell else {return 0}
//
//		if (cell.alertLabel.numberOfLines == 2) {
//			return 100
//		} else {
//			return 82
//		}
		return 82
		
	}
}

extension AlertViewController : UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return AlertDataModel.sampleData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertTableViewCell", for: indexPath) as? AlertTableViewCell else {return UITableViewCell()}
		
		cell.setData(appData: AlertDataModel.sampleData[indexPath.row])
		cell.selectionStyle = .none

		return cell
	}
}
