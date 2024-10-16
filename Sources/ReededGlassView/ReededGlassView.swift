import UIKit

public class ReededGlassView: UIView {
    /**
     Width type that applied to each reeded glass view
     */
    public enum WidthType: CGFloat {
        case narrow = 20
        case `default` = 35
        case wide = 50
    }
    
    private var targetImageView: UIImageView? // target image to apply reeded glass effect
    private var widthType = WidthType.default // reeded glass width
    
    /**
     Change width type. If reeded glass applied before, it will automatically update effect to reflect the changed width type.
     - parameters:
        - type: width type for each reeded glass views (narrow, default, wide)
     */
    public func setWidthType(to type: WidthType, completion: (() -> Void)? = nil) {
        guard let targetImageView = targetImageView else { return }
        // if targetImage exists (effect has applied before), apply reeded glass effect again to update width type
        self.applyReededGlassEffect(with: targetImageView, widthType: type) {
            completion?()
        }
    }
    
    /**
     Apply Reeded Glass Effect to the view above the target image
     - parameters:
        - imageView: UIImageView that you want to apply the reeded glass effect below
     */
    public func applyReededGlassEffect(with imageView: UIImageView,
                                     widthType: WidthType = .default,
                                     completion: (() -> Void)? = nil) {
        self.widthType = widthType
        self.subviews.forEach {
            // Remove subviews added via this method before
            if $0.tag == 999 {
                $0.removeFromSuperview()
            }
        }
        self.targetImageView = imageView
        self.clipsToBounds = true
        self.backgroundColor = targetImageView?.superview?.backgroundColor ?? .clear
        
        // Calculate x points to add subviews
        var glassWidth: CGFloat = widthType.rawValue
        let glassCount = round(self.frame.width / glassWidth)
        glassWidth = glassWidth + ((self.frame.width - (glassCount * glassWidth)) / glassCount) // Modify glassWidth in case widthType value does not fit with the view's width
        var lastMinX: CGFloat = 0
        var minXList: [CGFloat] = [lastMinX]
        while lastMinX + glassWidth < self.frame.width - (glassWidth / 2) {
            minXList.append(lastMinX + glassWidth)
            lastMinX = lastMinX + glassWidth
        }
        
        self.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 1
        
        for i in 0 ..< minXList.count {
            // Add effected subviews
            self.addReededGlassSubviews(in: minXList[i],
                                        width: i < (minXList.count - 1) ? glassWidth : self.frame.width - (glassWidth * CGFloat((minXList.count - 1))))
        }
        completion?()
    }
    
    private func addReededGlassSubviews(in xPosition: CGFloat, width: CGFloat) {
        guard let targetImageView = targetImageView else { return }

        var shrinkImageXPosition: CGFloat = 0 // xPosition relative to 'self'
        let shrinkImageWidth: CGFloat = width * 2 // fixed width
 
        if self.frame.minX + xPosition - (width / 2) >= targetImageView.frame.minX
            && self.frame.minX + xPosition + (width) + (width / 2) <= targetImageView.frame.maxX {
            // CASE 1) Basic case. Able to add (width / 2) backward and forward
            shrinkImageXPosition = xPosition - (width / 2)
        } else {
            if self.frame.minX + xPosition - (width / 2) < targetImageView.frame.minX {
                // CASE 2) Unable to add complete (width / 2) forward
                shrinkImageXPosition = targetImageView.frame.minX - self.frame.minX // minX of imageView relative to 'self'
            } else {
                // CASE 3) Unable to add complete (width / 2) backward
                let remainedWidth = shrinkImageWidth - (targetImageView.frame.maxX - (self.frame.minX + xPosition))
                shrinkImageXPosition = xPosition - remainedWidth // targetImageView's endPoint - (width * 2)
            }
        }
        
        let view = UIView(frame: CGRect(x: shrinkImageXPosition, y: 0, width: shrinkImageWidth, height: self.frame.height)) // view to crop the copied imageView below
        let image = UIImageView(frame: CGRect(x: targetImageView.frame.minX - self.frame.minX - shrinkImageXPosition,
                                              y: targetImageView.frame.minY - self.frame.minY,
                                              width: targetImageView.frame.width,
                                              height: targetImageView.frame.height)) // imageView that copies the targetImageView
        image.translatesAutoresizingMaskIntoConstraints = true
        image.image = targetImageView.image
        image.contentMode = targetImageView.contentMode
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.addSubview(image)
        
        let croppedImage = makeImage(from: view) // get UIImage from the view
        let temp = applyGaussianBlur(toImage: croppedImage, radius: 7) ?? UIImage()
        let croppedImageView = UIImageView(image: temp)
        croppedImageView.contentMode = .scaleToFill
        croppedImageView.frame = CGRect(x: xPosition, y: 0, width: width, height: self.frame.height + 5)

        // Add color gradient to make the looks like a convex glass
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: croppedImageView.frame.width, height: croppedImageView.frame.height)
        let colors: [CGColor] = [
            .init(red: 0, green: 0, blue: 0, alpha: 0.2),
            .init(red: 1, green: 1, blue: 1, alpha: 0.3),
            .init(red: 1, green: 1, blue: 1, alpha: 0.05),
            .init(red: 0, green: 0, blue: 0, alpha: 0.2)
        ]
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.05, 0.25, 0.75, 1.0]
        croppedImageView.layer.addSublayer(gradientLayer)
        croppedImageView.tag = 999 // Add tag to delete the views when re-applying the effect
        
        self.addSubview(croppedImageView)
    }
    
    /**
     Apply Gaussian blur effect to UIImage
     - Parameter : target UImage that want to apply effect
     */
    private func applyGaussianBlur(toImage currentImage: UIImage, radius : Float) -> UIImage? {
        let context: CIContext = CIContext()
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        guard let beginImage = CIImage(image: currentImage) else { return nil }
        currentFilter?.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter?.setValue(radius, forKey: kCIInputRadiusKey)
        guard let image = currentFilter?.outputImage else { return nil }
        
        let newExtent = beginImage.extent.insetBy(dx: 10.5, dy: 10.5)
        guard let final = context.createCGImage(image, from: newExtent) else {
            return nil
        }
        return UIImage(cgImage: final)
    }
    
    /**
     Convert UIView to UIImage
     - Parameter : target UIView
     */
    private func makeImage(from view: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }
    }
}
