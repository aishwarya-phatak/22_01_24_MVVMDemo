//
//  ProductTableViewCell.swift
//  22_01_24_MVVMDemo
//
//  Created by Vishal Jagtap on 15/04/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productIdLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    var product : Product?{
        didSet{
            productConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func productConfiguration(){
        self.productIdLabel.text = product?.id.codingKey.stringValue
        self.productTitleLabel.text = product?.title
    }
}
