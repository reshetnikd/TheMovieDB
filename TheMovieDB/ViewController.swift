//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Dmitry Reshetnik on 02.10.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=f910e2224b142497cc05444043cc8aa4&language=en-US&page=1")
        
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
                } catch {
                    debugPrint("Error JSON parsing!")
                }
            }
        }

        task.resume()
    }


}

