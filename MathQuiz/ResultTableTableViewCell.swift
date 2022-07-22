//
//  ResultTableTableViewCell.swift
//  MathQuiz
//
//  Created by Rimma on 2022-04-12.
//

import UIKit

class ResultTableTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func update(with result: Result){
        titleLabel.text = result.yourQuestion
        descriptionLabel.text = result.yourAnswer + " " + result.rightOrWrong
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }

}
