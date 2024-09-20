//
//  CitySearchViewController.swift
//  WeatherApp
//
//  Created by Shubham Sahgal on 20/09/24.
//
import Foundation
import UIKit
class CitySearchViewController: UIViewController {
    
    @IBOutlet weak var cityTableView: UITableView!
    
    @IBOutlet weak var citySearchBar: UISearchBar!
    
    lazy var viewModel: CitySearchViewModel = {
        return CitySearchViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    private func initView()
    {
        self.cityTableView.delegate = self;
        self.cityTableView.dataSource = self;
        self.citySearchBar.delegate = self;
    }
    
    private func initViewModel()
    {
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.cityTableView.reloadData()
            }
        }
    }
}

extension CitySearchViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell" , for: indexPath) as? CityTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        
        cell.cityNameLabel.text = cellVM.name
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let city =  self.viewModel.getCellViewModel(at: indexPath)
        UserDefaults.standard.setValue(city.latitude, forKey: UserDefaultKeys.CityLatitude)
        UserDefaults.standard.setValue(city.longitude, forKey: UserDefaultKeys.CityLongitute)
        UserDefaults.standard.setValue(city.name, forKey: UserDefaultKeys.CityName)
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
}

extension CitySearchViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count > 2)
        {
            viewModel.getCities(searchQuery: searchText);
        }
    }
}
