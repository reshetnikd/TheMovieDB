//
//  SlideViewController.swift
//  TheMovieDB
//
//  Created by Dmitry Reshetnik on 06.10.2020.
//

import UIKit

class SlideViewController: UIViewController {
    var feed: Feed?
    var slides: [Slide] = []
    var scrollView = UIScrollView()
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
    
    func createSlides() -> [Slide] {
        var slides = [Slide]()
        if feed != nil {
            for movie in self.feed!.results {
                let slide: Slide = Bundle.main.loadNibNamed("Slide", owner: nil, options: nil)?.first as! Slide
                slide.imageView.load(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)")!)
                slide.titleLabel.text = movie.title
                slide.descriptionLabel.text = movie.overview
                
                slides.append(slide)
            }
        }
        
        return slides
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
