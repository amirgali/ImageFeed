//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Amir on 26.10.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIndetifier = "ImagesListCell"
    
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
}
