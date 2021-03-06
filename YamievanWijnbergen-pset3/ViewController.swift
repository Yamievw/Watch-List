//
//  ViewController.swift
//  YamievanWijnbergen-pset3
//
//  Created by Yamie van Wijnbergen on 18/04/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var results = UserDefaults.standard.array(forKey: "Movies") as? [[String : String]] ?? []
    
    @IBOutlet weak var watchList: UITableView!

    // set number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    // create new cell
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! MovieCell
        
        // for each cell in tableview, display title, year and poster
        cell.movieTitle.text = self.results[indexPath.row]["Title"] as! String?
        cell.movieYear.text = self.results[indexPath.row]["Year"] as! String!
        
        // get movieposter
        let link = NSURL(string: self.results[indexPath.row]["Poster"] as! String)
        if let data = NSData(contentsOf: link as! URL) {
            cell.moviePoster.image = UIImage(data: data as Data)
        }
        return cell
    }

    // Segue to SearchMovies when clicking on addmovie button
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addmovie" {
            if let viewController = segue.destination as? SearchMovies {
            }
        }
            
        // Segue to MovieInformation when clicking on cell
        else if segue.identifier == "showmovieinfo2" {
            let path = self.watchList.indexPathForSelectedRow
            let cell = watchList.cellForRow(at: path!) as? MovieCell
            if let viewController = segue.destination as? MovieInformation {
                
                viewController.movie = self.results[path!.row] as? [String : String]

            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

