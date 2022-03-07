//
//  CUILabel.swift
//  10_Covid19_chart
//
//  Created by 이윤수 on 2022/03/07.
//

import UIKit

class CUILabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.labelSet()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func labelSet(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.boldSystemFont(ofSize: 16)
        self.textAlignment = .left
    }
}
