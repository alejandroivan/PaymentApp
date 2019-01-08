//
//  PaymentMethodCCTableViewCell.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 1/8/19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

import UIKit
import AlamofireImage

class PaymentMethodCCTableViewCell: UITableViewCell {
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var cellTitleLabel: UILabel!
    @IBOutlet private weak var cellSubtitleLabel: UILabel!

    public var cellImageUrl: String? {
        didSet {
            cellImageView.af_cancelImageRequest()

            guard let urlStr = cellImageUrl, let url = URL(string: urlStr) else {
                cellImageView.image = nil
                return
            }

            cellImageView.af_setImage(withURL: url)
        }
    }

    public var cellTitle: String? {
        set { cellTitleLabel.text = newValue }
        get { return cellTitleLabel.text }
    }

    public var cellSubtitle: String? {
        set { cellSubtitleLabel.text = newValue }
        get { return cellSubtitleLabel.text }
    }
}
