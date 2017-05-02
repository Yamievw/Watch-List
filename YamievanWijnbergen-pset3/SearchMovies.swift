//
//  SearchMovies.swift
//  YamievanWijnbergen-pset3
//
//  Created by Yamie van Wijnbergen on 20/04/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit

class SearchMovies: UIViewController, UISearchBarDelegate {

    var moviePoster: UIImage?
    var movieTitle: String?
    var movieYear: String?
    
    var results = [] as! [[String:Any]]
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieList: UITableView!
    
    // When user inputs searchitem, search it, disable keyboard and make searchbar empty
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchmovie = searchBar.text!.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        searchMovieInfo(search: searchmovie)
        view.endEditing(true)
    }
    
    
    // insert OMDB API to get database of movies
    func searchMovieInfo(search: String){
        
        let search = search
        let request = String("https://omdbapi.com/?s=" + search)
        let url = URL(string: request!)
        
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            if json["Search"] != nil{
                let searchResults = json["Search"] as! [[String : Any]]
                self.results = searchResults

                DispatchQueue.main.async {
                    self.movieList.reloadData()
                }
                
                
            }
        }
        task.resume()
    }
    
    // set number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    // create new cell
    private func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! MovieCell
        
        // for each cell in tableview, display title, year and poster
        print(self.results)
        cell.movieTitle.text = self.results[indexPath.row]["Title"] as! String?
        cell.movieYear.text = self.results[indexPath.row]["Year"] as! String!
        
        // get movieposter
        let link = NSURL(string: self.results[indexPath.row]["Poster"] as! String)
        if let data = NSData(contentsOf: link as! URL) {
            cell.moviePoster.image = UIImage(data: data as Data)
        }
        return cell
    }
    
    // Segue to MovieInformation when clicking on cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SearchMovies {
            
            let string = self.searchBar.text
            let url = URL(string: "https://omdbapi.com/?t=" + string! + "&plot=full")!
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
                        viewController.moviePoster = UIImage(data: data as Data)
                    }
                    
                    viewController.movieTitle = searchResults["Title"] as! String?
                    viewController.movieYear = searchResults["Year"] as! String?
                    
                    //viewController.update()
                }
            }
            task.resume()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
