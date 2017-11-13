//
//  ClipsListTableViewCell.swift
//  Video clips
//
//  Created by Alexander Slobodjanjuk on 11.11.2017.
//  Copyright © 2017 Alexander Slobodjanjuk. All rights reserved.
//

import UIKit

class ClipsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtypeLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.previewImageView.image = nil
        self.titleLabel.text = nil
        self.subtypeLabel.text = nil
    }
    
    /*
     According to the traditional MVC, the filling of cell objects must occur in the controller. But in practice this is the reason for the "Massiv View Controller". Therefore, we transfer the padding to the class of the cell
    */
    
    func initWithItem(item: Clip, languageId: Int){
        
        /*
         Decodouble protocol creates an object, not a dictionary. Therefore, we do not use the standard approach
        */
        
        switch languageId {
        case 0:
            self.titleLabel.text = item.descriptions?.en?.name
            break
            
        case 1:
            self.titleLabel.text = item.descriptions?.ru?.name
            break
           
        case 2:
            self.titleLabel.text = item.descriptions?.ua?.name
            break
            
        default:
            self.titleLabel.text = Constants.noData
        }
        
        if item.subtype != nil {
            subtypeLabel.text = item.subtype
        } else {
            subtypeLabel.isHidden = true
        }
        
        let idOptional: String!
        idOptional = String(describing: item.preview!.id!)
        
        if let id = idOptional{
            
            let url = URL(string: Constants.getImage + id + Constants.size + Constants.screenWidthString)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.previewImageView?.image = UIImage(data: data!)
                }
            }
        }

    }
}
