//
//  MovieInformation.swift
//  YamievanWijnbergen-pset3
//
//  Created by Yamie van Wijnbergen on 20/04/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit

class MovieInformation: UIViewController {
    
    var moviePoster: UIImage?
    var movieTitle: String?
    var movieYear: String?
    var movieDescription: String?
    var imdbID: String?
    

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieInfo()
        self.update()
        
    }
    
    func movieInfo() {
    let string = self.imdbID
    let url = URL(string: "https://omdbapi.com/?t=" + string! + "&plot=full")!
    
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
    
//    @IBAction func addToWatchlist(_ sender: Any) {
//        
//    }
    

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
