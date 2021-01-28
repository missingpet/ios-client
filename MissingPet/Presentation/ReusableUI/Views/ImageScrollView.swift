//
//  ImageScrollView.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.11.2020.
//

import UIKit

class ImageScrollView: UIScrollView, UIScrollViewDelegate {

    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        delegate = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    func set(image: UIImage) {
        imageView?.removeFromSuperview()
        imageView = nil
        imageView = UIImageView(image: image)
        addSubview(imageView)
        configureForImageSize(image.size)
    }
    
    private func configureForImageSize(_ imageSize: CGSize) {
        contentSize = imageSize
        setMaxAndMinZoomScalesForCurrentBounds()
        
        zoomScale = minimumZoomScale

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(zoomOnTap))
        tapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tapGesture)
        
        imageView.isUserInteractionEnabled = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerImage()
    }
    
    private func centerImage() {
        let boundsSize = bounds.size

        var frameToCenter = imageView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        imageView.frame = frameToCenter
    }
    
    private func setMaxAndMinZoomScalesForCurrentBounds() {
        let boundsSize = bounds.size
        let imageSize = imageView.bounds.size
        
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        
        var maxScale: CGFloat = 1.0
        
        if minScale < 0.1 {
            maxScale = 0.3
        } else if (minScale >= 0.1) && (minScale < 0.5) {
            maxScale = 0.7
        } else if minScale >= 0.5 {
            maxScale = max(1.0, minScale)
        }
        
        minimumZoomScale = minScale
        maximumZoomScale = maxScale
    }
    
    private func zoom(point: CGPoint, animated: Bool) {
        let currectScale = zoomScale
        let minScale = minimumZoomScale
        let maxScale = maximumZoomScale
        
        if (abs(minScale - maxScale) < CGFloat.ulpOfOne) && (minScale > 1.0) {
            return
        }
        
        let toScale = maxScale
        let finalScale = (abs(currectScale - minScale) < CGFloat.ulpOfOne) ? toScale : minScale
        let zoomRect = zoomRectForScale(finalScale, with: point)
        
        zoom(to: zoomRect, animated: animated)
    }
    
    private func zoomRectForScale(_ scale: CGFloat, with center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        let bounds = self.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        
        return zoomRect
    }
    
    @objc private func zoomOnTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        zoom(point: location, animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
    
}
