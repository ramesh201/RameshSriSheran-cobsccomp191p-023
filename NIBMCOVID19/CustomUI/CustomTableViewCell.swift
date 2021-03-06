//
//  CustomTableViewCell.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/23/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import MapKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var imgBullet: UIImageView!
    @IBOutlet weak var lblNotifiTitle: UILabel!
    @IBOutlet weak var lblNotifiSubtitle: UILabel!
    @IBOutlet weak var lblSurveyQuestionItem: UILabel!
    @IBOutlet weak var lblSurveyQuestionResult: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    
}
