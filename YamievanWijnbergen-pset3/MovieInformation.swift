//
//  MovieInformation.swift
//  YamievanWijnbergen-pset3
//
//  Created by Yamie van Wijnbergen on 20/04/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit

class MovieInformation: UIViewController {
    
    var movie: [String : String]?

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var addMovie: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.update()
    }

    func update() {
        self.titleLabel.text = self.movie?["Title"]
        self.yearLabel.text = self.movie?["Year"]
        self.descriptionText.text = self.movie?["Plot"]
        
        // get movieposter
        let link = NSURL(string: self.movie?["Poster"] as! String)
        if let data = NSData(contentsOf: link as! URL) {
            self.posterImage.image = UIImage(data: data as Data)
        }
    }
    
    @IBAction func addToWatchlist(_ sender: Any) {

        // append movie to watchlist, if added change text to remove intead of add
        var watchlist = UserDefaults.standard.array(forKey: "Movies") as? [[String : String]] ?? []
        let index = watchlist.index(where: {$0 == self.movie!})
        if index == nil {
            watchlist.append(self.movie!)
            UserDefaults.standard.set(watchlist, forKey: "Movies")
            self.addMovie.setTitle("Remove from Watchlist",for: .normal)
            print(watchlist)
        }
        // if movie already is in watchlist, on click add button: remove movie
        else {
            watchlist.remove(at: index!)
            UserDefaults.standard.set(watchlist, forKey: "Movies")
            self.addMovie.setTitle("Add to Watchlist",for: .normal)
            print(watchlist)
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
