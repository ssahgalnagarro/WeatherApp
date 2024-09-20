//
//  ViewController.swift
//  WeatherApp
//
//  Created by Shubham Sahgal on 19/09/24.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBOutlet weak var humidity: UILabel!
    
    @IBOutlet weak var windSpeed: UILabel!
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    var userLocation: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0);
    
    lazy var viewModel: ForecastViewModel = {
        return ForecastViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let cityLatitude = UserDefaults.standard.value(forKey: UserDefaultKeys.CityLatitude),let cityLongitute = UserDefaults.standard.value(forKey: UserDefaultKeys.CityLongitute) {
            
            viewModel.getCurrentWeatherConditionAndForecast(lat: UserDefaults.standard.double(forKey: UserDefaultKeys.CityLatitude), long: UserDefaults.standard.double(forKey: UserDefaultKeys.CityLongitute))
            
        } else {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    private func initView()
    {
        self.forecastTableView.delegate = self;
        self.forecastTableView.dataSource = self;
        
        let cityTapGesture = UITapGestureRecognizer(target: self, action: #selector(ForecastViewController.cityTapped(sender:)))
        self.cityName.addGestureRecognizer(cityTapGesture)
    }
    
    @objc func cityTapped(sender:UITapGestureRecognizer) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CitySearchViewController") as? CitySearchViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        }
    
    private func initViewModel()
    {
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.forecastTableView.reloadData()
            }
        }
        
        viewModel.updateCurrentWeatherConditions = { [weak self] () in
            DispatchQueue.main.async {
                
                if let cityName = UserDefaults.standard.string(forKey: UserDefaultKeys.CityName) {
                    self?.cityName.text =  cityName;
                }
                else
                {
                    self?.cityName.text = self?.viewModel.currentWeather.cityName ?? ""
                }
                self?.cityName.text =  self?.viewModel.currentWeather.cityName ?? "";
                self?.temperature.text = "\(self?.viewModel.currentWeather.tempareture ?? 0.0)°";
                self?.windSpeed.text = "\(self?.viewModel.currentWeather.windSpeed ?? 0.0)";
                self?.humidity.text = "\(self?.viewModel.currentWeather.humidity ?? 0)";
                self?.weatherDescription.text = self?.viewModel.currentWeather.weatherDescription ?? "";
            }
        }
    }
}

extension ForecastViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell" , for: indexPath) as? ForecastTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        
        cell.dateLabel.text = cellVM.datetext
        cell.highTemperatureLabel.text = "\(cellVM.highTempareture)°"
        cell.lowTemperatureLabel.text = "\(cellVM.lowTempareture)°"
        cell.descriptionLabel.text = cellVM.forecastDescription
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
extension ForecastViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newUserLocation = locations[0]
        if(userLocation.coordinate.latitude != newUserLocation.coordinate.latitude || userLocation.coordinate.longitude != newUserLocation.coordinate.longitude)
        {
            print("location: \(newUserLocation.coordinate.latitude), \(newUserLocation.coordinate.longitude)")
            viewModel.getCurrentWeatherConditionAndForecast(lat: newUserLocation.coordinate.latitude, long: newUserLocation.coordinate.longitude)
            userLocation = newUserLocation;
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
    }
}

