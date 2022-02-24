//
//  ViewController.swift
//  10_Covid19_chart
//
//  Created by 이윤수 on 2022/02/23.
//

import UIKit

class ViewController: UIViewController {

    var totalLabel : UILabel = {
        let label = UILabel()
        label.text = "전체 확진자"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    var todayLabel : UILabel = {
        let label = UILabel()
        label.text = "금일 확진자"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    var labelStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    var totalCovid : UILabel = {
        let label = UILabel()
        label.text = "0명"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hue: 0, saturation: 0.57, brightness: 0.98, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    var todayCovid : UILabel = {
        let label = UILabel()
        label.text = "0명"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    var covidStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    var mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.borderColor = UIColor.gray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    var chartView : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        viewSet()
    }

    private func viewSet(){
        self.view.backgroundColor = .white
        
        self.title = "COVID19 국내 현황"
        self.navigationItem.largeTitleDisplayMode = .always
        
        guard let margin = self.navigationController?.systemMinimumLayoutMargins.leading else{return}
        
        self.view.addSubview(self.mainStackView)
        NSLayoutConstraint.activate([
            self.mainStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            self.mainStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.mainStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        self.labelStackView.addArrangedSubview(self.totalLabel)
        self.labelStackView.addArrangedSubview(self.todayLabel)
        self.mainStackView.addArrangedSubview(self.labelStackView)
        
        self.covidStackView.addArrangedSubview(self.todayCovid)
        self.covidStackView.addArrangedSubview(self.totalCovid)
        self.mainStackView.addArrangedSubview(self.covidStackView)
        
        
        self.view.addSubview(self.chartView)
        NSLayoutConstraint.activate([
            self.chartView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            self.chartView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            self.chartView.topAnchor.constraint(equalTo: self.mainStackView.bottomAnchor, constant: 10),
            self.chartView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

