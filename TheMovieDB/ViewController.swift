//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Dmitry Reshetnik on 02.10.2020.
//

import UIKit

class ViewController: UISlidingTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        navigationItem.title = "News"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchController))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28.0)]
        navigationController?.navigationBar.barStyle = .black
        
        addItem(item: EmptyViewController(), title: "STORIES")
        addItem(item: EmptyViewController(), title: "VIDEO")
        addItem(item: EmptyViewController(), title: "FAVOURITES")
        setStyle(style: .fixed)
        setHeaderActiveColor(color: .white)
        setHeaderInactiveColor(color: .lightText)
        setHeaderBackgroundColor(color: .black)
        build()
        
        let apiKey = "f910e2224b142497cc05444043cc8aa4"
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1")
        
        guard url != nil else {
            debugPrint("URL is nil!")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                do {
                    let feed = try decoder.decode(Feed.self, from: data!)
                    print("This is JSON result -->> \n\(feed)")
                } catch DecodingError.keyNotFound(let key, let context) {
                    fatalError("Failed to decode from URL due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
                } catch DecodingError.typeMismatch(_, let context) {
                    fatalError("Failed to decode from URL due to type mismatch – \(context.debugDescription)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    fatalError("Failed to decode from URL due to missing \(type) value – \(context.debugDescription)")
                } catch DecodingError.dataCorrupted(_) {
                    fatalError("Failed to decode from URL because it appears to be invalid JSON")
                } catch {
                    fatalError("Failed to decode from URL: \(error.localizedDescription)")
                }
            }
        }

        task.resume()
    }
    
    @objc func showSearchController() {
        let searchController = SearchViewController()
        searchController.modalPresentationStyle = .overCurrentContext
        present(searchController, animated: true, completion: nil)
    }


}

