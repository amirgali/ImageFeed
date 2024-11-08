//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Amir on 01.11.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var scrollView: UIScrollView!

    @IBAction private func didTapBackButton() {
            dismiss(animated: true, completion: nil)
        }
    
    @IBAction private func didTapShareButton(_ sender: UIButton) {
        guard let image else { return }
        let share = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(share, animated: true, completion: nil)
    }
    
    var image: UIImage? {
          didSet {
              guard isViewLoaded, let image else { return }
              imageView.image = image
              imageView.frame.size = image.size
              rescaleAndCenterImageInScrollView(image: image)
          }
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        
        guard let image else { return }
        imageView.image = image
        imageView.frame.size = image.size

        rescaleAndCenterImageInScrollView(image: image)
    }
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = max(min(maxZoomScale, max(hScale, vScale)), minZoomScale)

        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        centerImageInScrollView()
    }
    
    private func centerImageInScrollView() {
            let scrollViewSize = scrollView.bounds.size
            let imageSize = imageView.frame.size
            let horizontalInset = max(0, (scrollViewSize.width - imageSize.width) / 2)
            let verticalInset = max(0, (scrollViewSize.height - imageSize.height) / 2)
            
            scrollView.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        }
}

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
