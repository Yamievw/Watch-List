//
//  MovieInformation.swift
//  YamievanWijnbergen-pset3
//
//  Created by Yamie van Wijnbergen on 20/04/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit

class MovieInformation: UIViewController {
    
    var watchlist = (UserDefaults.standard.array(forKey: "Movies") as? [[String]]) ?? []
    
    var moviePoster: UIImage?
    var movieTitle: String?
    var movieYear: String?
    var movieDescription: String?
    var imdbID: String?
    

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var addMovie: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.update()
        self.movieInfo()
    }
    
    func movieInfo() {
    

    let url = URL(string: "https://omdbapi.com/?i=" + imdbID! + "&plot=full")!
    print(url)


    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            return
        }

        let json = try! JSONSerialization.jsonObject(with: data) as! [String : Any]
        let searchResults = json as! [String : Any]
        print(searchResults)

        DispatchQueue.main.async {
            if let data = NSData(contentsOf: NSURL(string: searchResults["Poster"] as! String) as! URL) {
                self.moviePoster = UIImage(data: data as Data)
            }

            self.imdbID = searchResults["ImdbID"] as! String?
            self.movieTitle = searchResults["Title"] as! String?
            self.movieYear = searchResults["Year"] as! String?
            self.movieDescription = searchResults["Description"] as! String?
        }
    }
    task.resume()
    }

    func update() {
        posterImage.image = moviePoster
        titleLabel.text = movieTitle
        yearLabel.text = movieYear
        descriptionText.text = movieDescription
    }
    
    @IBAction func addToWatchlist(_ sender: Any) {

        // append movie to watchlist, if added change text to remove intead of add
        let index = watchlist.index(where: {$0[0] == self.movieTitle!})
        if index == nil {
            self.watchlist.append([self.movieTitle!])
            UserDefaults.standard.set(watchlist, forKey: "Movies")
            self.addMovie.setTitle("Remove from Watchlist",for: .normal)
            reloadInputViews()
            print(watchlist)
        }
        // if movie already is in watchlist, on click add button: remove movie
        else {
            self.watchlist.remove(at: index!)
            UserDefaults.standard.set(watchlist, forKey: "Movies")
            self.addMovie.setTitle("Add to Watchlist",for: .normal)
            print(watchlist)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            viewController.watchlist = self.watchlist
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
