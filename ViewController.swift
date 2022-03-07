//
//  ViewController.swift
//  10_Covid19_chart
//
//  Created by 이윤수 on 2022/02/23.
//

import UIKit
import Charts
import Alamofire

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
        label.textAlignment = .center
        return label
    }()
    
    var todayCovid : UILabel = {
        let label = UILabel()
        label.text = "0명"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hue: 0, saturation: 0.57, brightness: 0.98, alpha: 1.0)
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
    
    var chartView : PieChartView = {
        let view = PieChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        viewSet()
        self.covidDataLoad(completionHandler: { [weak self] result in
            guard let self = self else{return}
            switch result {
            case let .success(data):
                self.totalCovid.text = data.korea.totalCase
                self.todayCovid.text = data.korea.newCase
                
                let list = self.covidOverviewList(cityCovidOverview: data)
                self.chatViewSet(covidOverviewList: list)
            case let .failure(error):
                print(error)
            }
        })
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
        
        self.covidStackView.addArrangedSubview(self.totalCovid)
        self.covidStackView.addArrangedSubview(self.todayCovid)
        self.mainStackView.addArrangedSubview(self.covidStackView)
        
        
        self.view.addSubview(self.chartView)
        self.chartView.delegate = self
        NSLayoutConstraint.activate([
            self.chartView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            self.chartView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            self.chartView.topAnchor.constraint(equalTo: self.mainStackView.bottomAnchor, constant: 10),
            self.chartView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func covidDataLoad(completionHandler:@escaping (Result<CityCovidOverView, Error>) -> Void){
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey" : "BJp5fNoPjOmiD4a9wSEcY8helrA2Q7UxR"
        ]
        
        AF.request(url, method: .get, parameters: param).responseData(completionHandler: { response in
            switch response.result{
            case let .success(data):
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CityCovidOverView.self, from: data)
                    completionHandler(.success(result))
                }catch{
                    completionHandler(.failure(error))
                }
                
            case let .failure(error):
                completionHandler(.failure(error))
            }
        })
    }
    
    private func covidOverviewList(cityCovidOverview:CityCovidOverView)-> [CovidOverView]{
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.jeonnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju,
        ]
    }
    
    private func chatViewSet(covidOverviewList:[CovidOverView]){
        let entries = covidOverviewList.compactMap{ [weak self] overview -> PieChartDataEntry? in
            guard let self = self else {return nil}
            return PieChartDataEntry(value: self.removeFormatString(string: overview.newCase), label: overview.countryName, data: overview)
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.valueTextColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        
        dataSet.colors = ChartColorTemplates.vordiplom() + ChartColorTemplates.joyful() + ChartColorTemplates.pastel() + ChartColorTemplates.material()
        
        self.chartView.data = PieChartData(dataSet: dataSet)
        self.chartView.spin(duration: 0.3, fromAngle: self.chartView.rotationAngle, toAngle: self.chartView.rotationAngle + 100)
    }
    
    private func removeFormatString(string:String)-> Double{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
    
}

extension ViewController : ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let covidDetailViewController = CovidDetailViewController()
        
        guard let covidOverView = entry.data as? CovidOverView else {return}
        covidDetailViewController.covidOverview = covidOverView
        
        self.navigationController?.pushViewController(covidDetailViewController, animated: true)
    }
}
