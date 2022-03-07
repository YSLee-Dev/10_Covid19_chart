//
//  CovidDetailViewController.swift
//  10_Covid19_chart
//
//  Created by 이윤수 on 2022/02/24.
//

import UIKit

class CovidDetailViewController: UITableViewController {
    
    var newCaseText : CUILabel = {
        let label = CUILabel()
        label.text = "신규 확진자"
        return label
    }()
    
    var totalCaseText : CUILabel = {
        let label = CUILabel()
        label.text = "전체 확진자"
        return label
    }()
    
    var recoveredText : CUILabel = {
        let label = CUILabel()
        label.text = "완치자"
        return label
    }()
    
    var deathText : CUILabel = {
        let label = CUILabel()
        label.text = "사망자"
        return label
    }()
    
    var percentageText : CUILabel = {
        let label = CUILabel()
        label.text = "발생률"
        return label
    }()
    
    var overseasInflowText : CUILabel = {
        let label = CUILabel()
        label.text = "해외유입 신규 확진자"
        return label
    }()
    
    var regionalOutbreakText : CUILabel = {
        let label = CUILabel()
        label.text = "지역발생 신규 확진자"
        return label
    }()
    
    var stackView : UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var covidOverview: CovidOverView?
    
    override func viewDidLoad() {
        self.viewSet()
    }
    
    func viewSet(){
        guard let covidOverview = self.covidOverview else {return}
        guard let margin = self.navigationController?.systemMinimumLayoutMargins.leading else{return}
        
        self.title = "\(covidOverview.countryName)의 확진 현황"
        self.newCaseText.text = "신규 확진자: \(covidOverview.newCase)명"
        self.totalCaseText.text = "전체 확진자: \(covidOverview.totalCase)명"
        self.recoveredText.text = "완치자: \(covidOverview.recovered)명"
        self.deathText.text = "사망자: \(covidOverview.death)명"
        self.percentageText.text = "발생률: \(covidOverview.percentage)명"
        self.overseasInflowText.text = "해외유입 신규 확진자: \(covidOverview.newFcase)명"
        self.regionalOutbreakText.text = "지역발생 신규 확진자: \(covidOverview.newCcase)명"
        
        self.view.addSubview(self.stackView)
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        self.stackView.addArrangedSubview(self.newCaseText)
        self.stackView.addArrangedSubview(self.totalCaseText)
        self.stackView.addArrangedSubview(self.recoveredText)
        self.stackView.addArrangedSubview(self.deathText)
        self.stackView.addArrangedSubview(self.percentageText)
        self.stackView.addArrangedSubview(self.overseasInflowText)
        self.stackView.addArrangedSubview(self.regionalOutbreakText)
    }
}
