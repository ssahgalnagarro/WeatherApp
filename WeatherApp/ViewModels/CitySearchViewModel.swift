//
//  CitySearchViewModel.swift
//  WeatherApp
//
//  Created by Shubham Sahgal on 20/09/24.
//
import Foundation
import UIKit
class CitySearchViewModel{
    
    var apiService: APIServiceProtocol
    
    private var cellViewModels: [CityCellViewItemModel] = [CityCellViewItemModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }

    var reloadTableViewClosure: (()->())?
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func getCities(searchQuery : String)
    {
        apiService.getCities(forSearch: searchQuery) { [weak self] (success, results, error) in
            if let error = error {
              
            } else {
                self?.processCitySearchData(cityDetail: results);
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> CityCellViewItemModel {
            return cellViewModels[indexPath.row]
        }
    
    private func processCitySearchData( cityDetail: CityDetail? ) {
        guard let cityDetail = cityDetail else {
            return;
        }
        
        var cityTableViewModel : [CityCellViewItemModel] = []
        for city in cityDetail
        {
            let cityName = city.name;
            cityTableViewModel.append(CityCellViewItemModel(name: cityName ?? "",latitude: city.lat ?? 0.0,longitude: city.lon ?? 0.0))
        }
        cellViewModels = cityTableViewModel;
    }
}

struct CityCellViewItemModel
{
    var name :String
    var latitude : Double
    var longitude : Double
}
