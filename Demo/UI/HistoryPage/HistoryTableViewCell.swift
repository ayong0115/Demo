//
//  HistoryTableViewCell.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCellWith(data:APIList){
        countLabel.text = String(data.apis.count)
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-mm-dd HH:mm:ss"
        timeLabel.text = dateFormate.string(from: data.time)
    }
    
}
