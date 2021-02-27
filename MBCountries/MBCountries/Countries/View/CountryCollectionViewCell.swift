//
//  CountryCollectionViewCell.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import UIKit

final class CountryCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        nameLabel.text = nil
        flagImageView.image = nil
    }
    
    func configureCell(viewModel: CountryCellViewModel) {
        nameLabel.text = viewModel.name
        
        viewModel.getImage(size: Int(bounds.size.width)) { image in
            DispatchQueue.main.async { [weak self] in
                self?.flagImageView.image = image
            }
        }
    }
}
