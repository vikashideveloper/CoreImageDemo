//
//  ViewController.swift
//  CoreImageDemo
//
//  Created by Vikash Kumar on 18/04/17.
//  Copyright © 2017 Vikash Kumar. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityView: UIActivityIndicatorView!
    
    //

    let filters = ["CIBoxBlur",
                   "CIDiscBlur",
                   "CIGaussianBlur",
                   "CIMaskedVariableBlur",
                   "CIMedianFilter", "CIMotionBlur",
                   "CINoiseReduction",
                   "CIZoomBlur",
                   "CIColorClamp",
                   "CIColorControls",
                   "CIColorMatrix",
                   "CIColorPolynomial",
                   "CIExposureAdjust",
                   "CIGammaAdjust",
                   "CIHueAdjust",
                   "CILinearToSRGBToneCurve",
                   "CISRGBToneCurveToLinear",
                   "CITemperatureAndTint",
                   "CIToneCurve",
                   "CIVibrance",
                   "CIWhitePointAdjust",
                   "CIColorCrossPolynomial",
                   "CIColorCube",
                   "CIColorCubeWithColorSpace",
                   "CIColorInvert",
                   "CIColorMap",
                   "CIColorMonochrome",
                   "CIColorPosterize",
                   "CIFalseColor",
                   "CIMaskToAlpha",
                   "CIMaximumComponent",
                   "CIMinimumComponent",
                   "CIPhotoEffectChrome",
                   "CIPhotoEffectFade",
                   "CIPhotoEffectInstant",
                   "CIPhotoEffectMono",
                   "CIPhotoEffectNoir",
                   "CIPhotoEffectProcess",
                   "CIPhotoEffectTonal",
                   "CIPhotoEffectTransfer",
                   "CISepiaTone",
                   "CIVignette",
                   "CIVignetteEffect",
                   
                   "CIAdditionCompositing",
                   "CIColorBlendMode",
                   "CIColorBurnBlendMode",
                   "CIColorDodgeBlendMode",
                   "CIDarkenBlendMode",
                   "CIDifferenceBlendMode",
                   "CIDivideBlendMode",
                   "CIExclusionBlendMode",
                   "CIHardLightBlendMode",
                   "CIHueBlendMode",
                   "CILightenBlendMode",
                   "CILinearBurnBlendMode",
                   "CILinearDodgeBlendMode",
                   "CILuminosityBlendMode",
                   "CIMaximumCompositing",
                   "CIMinimumCompositing",
                   "CIMultiplyBlendMode",
                   "CIMultiplyCompositing",
                   "CIOverlayBlendMode",
                   "CIPinLightBlendMode",
                   "CISaturationBlendMode",
                   "CIScreenBlendMode",
                   "CISoftLightBlendMode",
                   "CISourceAtopCompositing",
                   "CISourceInCompositing",
                   "CISourceOutCompositing",
                   "CISourceOverCompositing",
                   "CISubtractBlendMode"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setFilter(fname: String) {
        activityView.startAnimating()
        let image = UIImage(named: "image")
        guard let cgImage = image?.cgImage else {return}
        let coreImage = CIImage(cgImage: cgImage)
       
        let openGLContext = EAGLContext(api: .openGLES2)
        let context = CIContext(eaglContext: openGLContext!)
       
        let filter = CIFilter(name: fname)
        filter?.setValue(coreImage, forKey: kCIInputImageKey)
       
        DispatchQueue.global(qos: .background).async {
            if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
                let cgImage = context.createCGImage(output, from: output.extent)
                let filterImage = UIImage(cgImage: cgImage!)
               
                DispatchQueue.main.async {
                    self.imageView.image = filterImage
                    self.activityView.stopAnimating()
                }
            }

        }
    }
    
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lblTitle.text = filters[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filter = filters[indexPath.row]
        setFilter(fname: filter)
    }
}


class TableViewCell: UITableViewCell {
    @IBOutlet var lblTitle: UILabel!
}
