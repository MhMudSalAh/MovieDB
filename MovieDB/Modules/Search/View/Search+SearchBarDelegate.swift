//
//  Search+SearchBarDelegate.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit

extension SearchController {
    
    func setupSearhController() {
        navigationItem.searchController = searchController
        searchController.isActive = true
    }
    
    func setupSearchTextField(_ searchController: UISearchController) {
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.accessibilityIdentifier = localizedText("search_here")
            searchController.searchBar.tintColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            let searchField = searchController.searchBar.value(forKey: "searchField") as! UITextField
            searchField.attributedPlaceholder = NSAttributedString(string: localizedText("search_here"), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
}

extension SearchController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            if !text.isEmpty {
                presenter.doSearch(1, text)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presentSeacrhScreen()
            movies.removeAll()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty ?? true {
            searchController.isActive = false
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if !movies.isEmpty {
            movies.removeAll()
        }
    }
}
