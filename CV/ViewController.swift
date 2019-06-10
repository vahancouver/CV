//
//  ViewController.swift
//  CV
//
//  Created by Vahan Harutyunyan on 2019-06-09.
//  Copyright © 2019 Vahan Harutyunyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var cv: CV?
    
    var vSpinner : UIView?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.cellId)
        tableView.register(ExperienceCell.self, forCellReuseIdentifier: ExperienceCell.cellId)
        tableView.register(EducationCell.self, forCellReuseIdentifier: EducationCell.cellId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Loading..."
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.bindFrameToSuperviewBounds()
        
        showSpinner()
        loadCV()
    }
    
    private func loadCV() {
        let urlAddress = "https://gist.githubusercontent.com/vahancouver/6cc6539d3df7526c57c3447eb3e8374a/raw/8011eb85f08c47d763bcd9c972c28dce8fc697bb/CV.json"
        
        guard let url = URL(string: urlAddress) else
        {
            showErrorAlert(withMessage: "Url conversion failed")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (jsonData, response, error) -> Void in
            guard error == nil, let jsonData = jsonData else {
                self.showErrorAlert(withMessage: "Loading json failed")
                return
            }
            do {
                let decoder = JSONDecoder()
                self.cv = try decoder.decode(CV.self, from: jsonData)
                self.removeSpinner()
                DispatchQueue.main.async {
                    self.title = self.cv?.name
                    self.tableView.reloadData()
                }
                
            } catch {
                self.showErrorAlert(withMessage: error.localizedDescription)
            }
            }.resume()
    }
    
    
}

extension ViewController: UITableViewDataSource {
    enum SectionType: Int, CaseIterable {
        case summary = 0
        case experience
        case eduacation
        case skills
        
        var sectionName: String {
            switch self {
            case .summary:
                return "Summary"
            case .experience:
                return "Experience"
            case .eduacation:
                return "Education"
            case .skills:
                return "Skills"
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cv == nil ? 0 : SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionType = SectionType(rawValue: section) else {
            return nil
        }
        
        return sectionType.sectionName.uppercased()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section), let cv = cv else {
            return 0
        }
        switch sectionType {
        case .summary:
            return cv.summary.count
        case .experience:
            return cv.experience.count
        case .eduacation:
            return cv.education.count
        case .skills:
            return cv.skills.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section), let cv = cv else {
            return UITableViewCell()
        }
        
        switch sectionType {
        case .summary:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.cellId, for: indexPath) as! ItemCell
            cell.item = Item(itemName: cv.summary[indexPath.row], itemImage: UIImage(named: "summary") )
            return cell
        case .experience:
            let cell = tableView.dequeueReusableCell(withIdentifier: ExperienceCell.cellId, for: indexPath) as! ExperienceCell
            cell.experience = cv.experience[indexPath.row]
            return cell
        case .eduacation:
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationCell.cellId, for: indexPath) as! EducationCell
            cell.education = cv.education[indexPath.row]
            return cell
        case .skills:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.cellId, for: indexPath) as! ItemCell
            cell.item = Item(itemName: cv.skills[indexPath.row], itemImage: UIImage(named: "skill") )
            return cell
        }
    }
}


extension ViewController {
    func showSpinner() {
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = UIColor.gray
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
    func showErrorAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
}



