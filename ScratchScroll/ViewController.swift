//
//  ViewController.swift
//  ScratchScroll
//
//  Created by Vincent O'Sullivan on 20/04/2017.
//  Copyright © 2017 Rose Cottage. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var credits: UILabel!
    @IBOutlet weak var creditsScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        creditsScrollView.contentOffset = CGPoint.zero
        credits.attributedText = creditsText()
    }

    override func viewDidLayoutSubviews() {
        applyEdgeFading()
        fadeInCredits()
    }

    @IBAction func repeatCredits() {
        loopCredits()
    }

    private func creditsText() -> NSAttributedString {
        let myString = "RAINCOAT\n\nDesigned and developed by\n\nVincent O'Sullivan\n\n\nOriginal Artwork by\n\nBeth Rose\n\n\nWeather data by\n\nDark Sky\n\n\nWeather symbols by\n\nWeather Awesome"

        let titleAttributes = [
            UIFontDescriptorFamilyAttribute: "Helvetica",
            UIFontWeightTrait : UIFontWeightHeavy] as [String : Any]
        let subTitleAttributes = [
            UIFontDescriptorFamilyAttribute: "Helvetica",
            UIFontWeightTrait : UIFontWeightRegular] as [String : Any]
        let nameAttributes = [
            UIFontDescriptorFamilyAttribute: "ChalkDuster",
            UIFontWeightTrait : UIFontWeightRegular] as [String : Any]

        let titleFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: titleAttributes), size: 18.0)
        let subTitleFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: subTitleAttributes), size: 12.0)
        let nameFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: nameAttributes), size: 15.0)

        let myMutableString = NSMutableAttributedString(
            string: myString,
            attributes: [NSFontAttributeName: subTitleFont])
        myMutableString.addAttribute(NSFontAttributeName,
                                     value: titleFont,
                                     range: NSRange(location: 0, length: 8))
        myMutableString.addAttribute(NSFontAttributeName,
                                     value: nameFont,
                                     range: NSRange(location: 37, length: 18))
        myMutableString.addAttribute(NSFontAttributeName,
                                     value: nameFont,
                                     range: NSRange(location: 79, length: 9))
        myMutableString.addAttribute(NSFontAttributeName,
                                     value: nameFont,
                                     range: NSRange(location: 108, length: 8))
        myMutableString.addAttribute(NSFontAttributeName,
                                     value: nameFont,
                                     range: NSRange(location: 139, length: 15))
        //Add more attributes here
        return myMutableString
    }

    private func applyEdgeFading() {
        let innerColor = UIColor(red: 212.0/255.0, green: 214.0/255.0, blue: 1.0, alpha: 0.0).cgColor
        let outerColor = UIColor(red: 212.0/255.0, green: 214.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        //let innerColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        //let outerColor = UIColor(white: 1.0, alpha: 1.0).cgColor

        // first, define a horizontal gradient (left/right edges)
        let hMaskLayer = CAGradientLayer()
        hMaskLayer.opacity = 0.9
        hMaskLayer.colors = [outerColor, innerColor, innerColor, outerColor]
        hMaskLayer.locations = [NSNumber(value: 0.0), NSNumber(value: 0.05), NSNumber(value: 0.8), NSNumber(value: 1.0)]
        hMaskLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        hMaskLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        let maskFrame = CGRect(x: creditsScrollView.frame.origin.x,
                               y: creditsScrollView.frame.origin.y,
                               width: creditsScrollView.frame.size.width,
                               height: creditsScrollView.frame.size.height)
        hMaskLayer.frame = maskFrame

        // you must add the masks to the root view, not the scrollView, otherwise
        //  the masks will move as the user scrolls!
        view.layer.addSublayer(hMaskLayer)
    }

    private func loopCredits() {
        self.repeatButton.isEnabled = false
        let frame = creditsScrollView.frame
        let finalOffset = CGPoint(x: 0.0, y: -(creditsScrollView.intrinsicContentSize.height - frame.size.height) * 1.5)
        self.creditsScrollView.contentOffset = CGPoint.zero

        UIView.animate(withDuration: 12.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.creditsScrollView.contentOffset = finalOffset
        }, completion: { (_) in
            self.fadeInCredits()
        })
    }

    private func fadeInCredits() {
        self.credits.alpha = 0.0
        self.creditsScrollView.contentOffset = CGPoint.zero
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.credits.alpha = 1.0
        }, completion: { (_) in
            self.repeatButton.isEnabled = true
        })
    }
}

