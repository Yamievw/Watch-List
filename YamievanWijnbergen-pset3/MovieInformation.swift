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
    

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func update() {
        posterImage.image = moviePoster
        titleLabel.text = movieTitle
        yearLabel.text = movieYear
        descriptionText.text = movieDescription
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addMovie(_ sender: UIButton) {
        
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
