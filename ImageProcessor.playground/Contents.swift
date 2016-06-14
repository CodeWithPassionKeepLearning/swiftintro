//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")
// Process the image!


//ColorFilter constants
enum ColorFilter{
    case red
    case blue
    case green
    
}
//class containing all methods to process filters on an image
class Filter{
    //class variables
    
    
    private var _averageRed: Int
    private var _averageGreen: Int
    private var _averageBlue: Int
    private var _averageAplha: Int
    //class initializer
    
    init(){
        
        self._averageRed=0
        self._averageGreen=0
        self._averageBlue=0
        self._averageAplha=0
        
    }
    
    //function to calculate the average RGBA pixels
    
    func calculateRGBAAverage(funcRGBAimage : RGBAImage ) {
        var myFuncRGBAimage = funcRGBAimage
        
        
        var totalRed = 0
        var totalBlue = 0
        var totalGreen = 0
        var totalAlpha = 0
        
        let count = myFuncRGBAimage.width * myFuncRGBAimage.height
        
        for y in 0..<myFuncRGBAimage.width{
            for x in 0..<myFuncRGBAimage.height{
                let index = y * myFuncRGBAimage.width + x
                var pixel = myFuncRGBAimage.pixels[index]
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
                totalAlpha += Int(pixel.alpha)
                
            }
        }
        
        self._averageRed = totalRed/count
        self._averageGreen = totalGreen/count
        self._averageBlue = totalBlue/count
        self._averageAplha = totalAlpha/count
        
    }
    
    
    
    //Function to amplify colors : Red/Green/Blue
    func amplifyColorFilter ( myColorFilter : ColorFilter, funcRGBAimage : RGBAImage , amplifyFactor : Int) -> RGBAImage{
        var myFuncRGBAimage = funcRGBAimage
        //make a call to calculate average of the image
        self.calculateRGBAAverage(myFuncRGBAimage)
    
        if (myColorFilter == ColorFilter.red ){
            for y in 0..<myFuncRGBAimage.height {
                for x in 0..<myFuncRGBAimage.width {
                    let index = y * myFuncRGBAimage.width + x
                    var pixel = myFuncRGBAimage.pixels[index]
                    let redDiff = Int(pixel.red) - self._averageRed
                    if (redDiff > 0){
                        pixel.red = UInt8( max(0, min(255, self._averageRed + redDiff * amplifyFactor)))
                        myFuncRGBAimage.pixels[index] = pixel
                    }
                    
                    
                }
            }
        }
        else if(myColorFilter == ColorFilter.green ){
            for y in 0..<myFuncRGBAimage.height {
                for x in 0..<myFuncRGBAimage.width {
                    let index = y * myFuncRGBAimage.width + x
                    var pixel = myFuncRGBAimage.pixels[index]
                    let greenDiff = Int(pixel.green) - self._averageGreen
                    if (greenDiff > 0){
                        pixel.green = UInt8( max(0, min(255, self._averageGreen + greenDiff * amplifyFactor)))
                        myFuncRGBAimage.pixels[index] = pixel
                    }
                    
                    
                }
            }
        }
        
        else if (myColorFilter == ColorFilter.blue){
            for y in 0..<myFuncRGBAimage.height {
                for x in 0..<myFuncRGBAimage.width {
                    let index = y * myFuncRGBAimage.width + x
                    var pixel = myFuncRGBAimage.pixels[index]
                    let blueDiff = Int(pixel.blue) - self._averageBlue
                    if (blueDiff > 0){
                        pixel.blue = UInt8( max(0, min(255, self._averageBlue + blueDiff * amplifyFactor)))
                        myFuncRGBAimage.pixels[index] = pixel
                    }
                    
                    
                }
            }
        }
        
        
        
        return myFuncRGBAimage
    }
    
    //Function to apply contrast on an image
    //contrast can range between -255 to +255
    func getContrastFilter(funcRGBAimage :  RGBAImage, contrast : Int) -> RGBAImage{
        
        var myFuncRGBAimage = funcRGBAimage
        let factor = Double(259 * (contrast + 255)) / Double( 255 * (259 - contrast))
        
        
        for y in 0..<myFuncRGBAimage.width{
            
            for x in 0..<myFuncRGBAimage.height{
                
                let index = y * myFuncRGBAimage.width + x
                var pixel = myFuncRGBAimage.pixels[index]
                
                let outputRed = factor * (Double(pixel.red) - 128) + 128
                let outputGreen = factor * (Double(pixel.green) - 128) + 128
                let outputBlue =  factor * (Double(pixel.blue) - 128) + 128
                
                pixel.red = UInt8(max(0,min(outputRed,255)))
                
                pixel.green = UInt8(max(0,min(outputGreen,255)))
                pixel.blue = UInt8(max(0,min(outputBlue,255)))
                
                myFuncRGBAimage.pixels[index] = pixel
                
            }
        }
        return myFuncRGBAimage
    }
    
    
    
    //Function to apply grayscale as a filter on the image
    //numberOfShades range : 2 to 256
    
    func getGrayscaleFilter(funcRGBAimage : RGBAImage, numberOfShades : Int) -> RGBAImage{
        
        var myFuncRGBAimage = funcRGBAimage
        let conversionFactor = 255 / ( numberOfShades - 1)
        
        for y in 0..<myFuncRGBAimage.width{
            
            for x in 0..<myFuncRGBAimage.height{
                let index = y * myFuncRGBAimage.width + x
                var pixel = myFuncRGBAimage.pixels[index]
                
                let avg = (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue))/3 //formula to obtain grayscale
                let grayAvg = (Int(avg / conversionFactor) ) * conversionFactor
                
                let gray = max(0, min(255, grayAvg))
                pixel.red = UInt8(gray)
                pixel.green = UInt8(gray)
                pixel.blue = UInt8(gray)
                
                myFuncRGBAimage.pixels[index] = pixel
                
            }
        }
        return myFuncRGBAimage
    }
    
    //function to apply sepia as a filter to the image
 
    func getSepiaFilter( funcRGBAimage : RGBAImage, intensity : Double) -> RGBAImage{
        
        
        var myFuncRGBAimage = funcRGBAimage
        
        for y in 0..<myFuncRGBAimage.width{
            
            for x in 0..<myFuncRGBAimage.height{
                let index = y * myFuncRGBAimage.width + x
                var pixel = myFuncRGBAimage.pixels[index]
                
             
                let outputRed = Double(pixel.red) * intensity
                let outputGreen = Double(pixel.red)
                let outputBlue = Double(pixel.red)
                
                
                pixel.red = UInt8(max(0,min(outputRed * 2,255)))
                pixel.green = UInt8(max(0,min(outputGreen,255)))
                pixel.blue = UInt8(max(0,min(outputBlue,255)))
                
                myFuncRGBAimage.pixels[index] = pixel
                
            }
        }
        return myFuncRGBAimage
    }
    
    //function to apply brightness
    
    func getBrightnessFilter(funcRGBAimage :  RGBAImage, brightnessPercent : Int) -> RGBAImage{
        
        var myFuncRGBAimage = funcRGBAimage
     
        for y in 0..<myFuncRGBAimage.width{
            
            for x in 0..<myFuncRGBAimage.height{
                
                let index = y * myFuncRGBAimage.width + x
                var pixel = myFuncRGBAimage.pixels[index]
                
                let outputRed = Double(pixel.red) * Double(brightnessPercent) / 100
                let outputGreen = Double(pixel.green) * Double(brightnessPercent) / 100
                let outputBlue =  Double(pixel.blue) * Double(brightnessPercent) / 100
                
                pixel.red = UInt8(max(0,min(outputRed,255)))
                
                pixel.green = UInt8(max(0,min(outputGreen,255)))
                pixel.blue = UInt8(max(0,min(outputBlue,255)))
                
                myFuncRGBAimage.pixels[index] = pixel
                
            }
        }
        return myFuncRGBAimage
    }
    
    
    //function to apply red/blue/green filter to the image
    
    func getColorFilter( myColorFilter : ColorFilter, funcRGBAimage : RGBAImage)-> RGBAImage {
        
        var myFuncRGBAimage = funcRGBAimage
        var redPixelValue = 0
        var greenPixelValue = 0
        var bluePixelValue = 0
        
        for y in 0..<myFuncRGBAimage.width{
            
            for x in 0..<myFuncRGBAimage.height{
                
                let index = y * myFuncRGBAimage.width + x
                var pixel = myFuncRGBAimage.pixels[index]
                
                if(myColorFilter ==   ColorFilter.red){
                    
                    redPixelValue = Int(pixel.red)
                    greenPixelValue = Int(pixel.green) - 255
                    bluePixelValue = Int(pixel.blue) - 255
                }
                else if(myColorFilter == ColorFilter.green){
                    
                    redPixelValue = Int(pixel.red) - 255
                    greenPixelValue = Int(pixel.green)
                    bluePixelValue = Int(pixel.blue) - 255
                    
                }
                else if(myColorFilter == ColorFilter.blue){
                    
                    redPixelValue = Int(pixel.red) - 255
                    greenPixelValue = Int(pixel.green) - 255
                    bluePixelValue = Int(pixel.blue)
                }
                
                pixel.red = UInt8(max(0,min(redPixelValue,255)))
                
                pixel.green = UInt8(max(0,min(greenPixelValue,255)))
                pixel.blue = UInt8(max(0,min(bluePixelValue,255)))
                
                myFuncRGBAimage.pixels[index] = pixel
                
            }
        }
        return myFuncRGBAimage
        
        
        
        
    }
    

    
    
}

//Image processing class

class ImageProcessor{
    //class variables
    var myRGBAimage:RGBAImage
    var originalImage : RGBAImage
    
    //class initializer
    
    init(image: UIImage){
        self.myRGBAimage = RGBAImage(image: image)!
        self.originalImage = RGBAImage(image : image)!
        
    }
    
    //function to get original image
    func getOriginalImage() -> RGBAImage{
        return self.originalImage
    }
    
    //Function to apply filters
    
    func applyFilter (filterNames : [String])->UIImage
    {
        let filter = Filter()
        
        for filterName in filterNames
        {
            
            switch filterName
            {
            case "sepia" :
                
                self.myRGBAimage = filter.getSepiaFilter(self.myRGBAimage, intensity: 2.1)
                
            case "grayscale" :
                
                self.myRGBAimage = filter.getGrayscaleFilter(self.myRGBAimage, numberOfShades: 90)
                
            case "50% brightness" :
                
                self.myRGBAimage = filter.getBrightnessFilter(self.myRGBAimage, brightnessPercent: 50)
          
            case "2X brightness" :
                
                self.myRGBAimage = filter.getBrightnessFilter(self.myRGBAimage, brightnessPercent: 200)
        
            case "half contrast" :
                
                self.myRGBAimage = filter.getContrastFilter(self.myRGBAimage, contrast: -128)
                
            case "double contrast" :
                
                self.myRGBAimage = filter.getContrastFilter(self.myRGBAimage, contrast: 128)
                
            case "red" :
                self.myRGBAimage = filter.getColorFilter(ColorFilter.red, funcRGBAimage: self.myRGBAimage)
                
            case "green" :
                self.myRGBAimage = filter.getColorFilter(ColorFilter.green, funcRGBAimage: self.myRGBAimage)
                
            case "blue" :
                self.myRGBAimage = filter.getColorFilter(ColorFilter.blue, funcRGBAimage: self.myRGBAimage)
            
            case "amplify red" :
                self.myRGBAimage = filter.amplifyColorFilter(ColorFilter.red, funcRGBAimage: self.myRGBAimage, amplifyFactor: 5)
                
            case "amplify green" :
                self.myRGBAimage = filter.amplifyColorFilter(ColorFilter.green, funcRGBAimage: self.myRGBAimage, amplifyFactor: 5)
                
            case "amplify blue" :
                self.myRGBAimage = filter.amplifyColorFilter(ColorFilter.blue, funcRGBAimage: self.myRGBAimage, amplifyFactor: 5)
            
            case "original" :
                self.myRGBAimage = self.getOriginalImage()
                
            default :
                self.myRGBAimage
                
            }
            
        }
        let viewImage = self.convertRGBAtoUIimage(self.myRGBAimage)
        return viewImage
    
    }
    
    //Function to convert RGBAImage to UIImage
    
    func convertRGBAtoUIimage(myFuncRGBAimage : RGBAImage)->UIImage
    {
        return myFuncRGBAimage.toUIImage()!
    }
}

/*
 Filters :
 red
 green
 blue
 grayscale
 sepia
 amplify red
 amplify green
 amplify blue
 2X brightness
 50% brightness
 half contrast
 double contrast
 original
 
 */
let ip = ImageProcessor(image : image!)
ip.applyFilter(["red"])

let ip1 = ImageProcessor(image : image!)
ip1.applyFilter(["green"])

let ip2 = ImageProcessor(image : image!)
ip2.applyFilter(["blue"])

let ip3 = ImageProcessor(image : image!)
ip3.applyFilter(["grayscale"])

let ip4 = ImageProcessor(image : image!)
ip4.applyFilter(["sepia"])

let ip5 = ImageProcessor(image : image!)
ip5.applyFilter(["amplify red"])

let ip6 = ImageProcessor(image : image!)
ip6.applyFilter(["amplify green"])

let ip7 = ImageProcessor(image : image!)
ip7.applyFilter(["amplify blue"])

let ip8 = ImageProcessor(image : image!)
ip8.applyFilter(["2X brightness"])

let ip9 = ImageProcessor(image : image!)
ip9.applyFilter(["50% brightness"])

let ip10 = ImageProcessor(image : image!)
ip10.applyFilter(["half contrast"])

let ip11 = ImageProcessor(image : image!)
ip11.applyFilter(["double contrast"])

let ip12 = ImageProcessor(image : image!)
ip12.applyFilter(["original"])

//using combination of filters
let ip13 = ImageProcessor(image : image!)
ip13.applyFilter(["grayscale","2X brightness"])




