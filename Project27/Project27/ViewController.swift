//
//  ViewController.swift
//  Project27
//
//  Created by Stomach Diego on 10/19/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 7 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawSmile()
        case 7:
            drawTwin()
        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)

            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
        
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)

            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = img
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)

            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }

        imageView.image = img
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)

            let rotations = 16
            let amount = Double.pi / Double(rotations)

            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }

        imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)

            var first = true
            var length: CGFloat = 256

            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)

                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }

                length *= 0.99
            }

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }

        imageView.image = img
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]

            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)

            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)

            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }

        imageView.image = img
    }
    
    func drawSmile() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let circle = CGRect(x: 5, y: 5, width: 502, height: 502)
            ctx.cgContext.setFillColor(UIColor.systemYellow.cgColor)
            
            ctx.cgContext.addEllipse(in: circle)
            ctx.cgContext.drawPath(using: .fill)
            
            let leftEye = CGRect(x: 128, y: 100, width: 70, height: 100)
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.addEllipse(in: leftEye)
            ctx.cgContext.drawPath(using: .fill)
            
            let rightEye = CGRect(x: 314, y: 100, width: 70, height: 100)
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.addEllipse(in: rightEye)
            ctx.cgContext.drawPath(using: .fill)
            
            //let mouth = CGRect(x: 256, y: 256, width: 256, height: 70)
            //ctx.cgContext.move(to: CGPoint(x: 256, y: 256))
            //ctx.cgContext.translateBy(x: 256, y: 256)
            ctx.cgContext.addArc(center: CGPoint(x: 256, y: 300), radius: 128, startAngle: 0, endAngle: .pi, clockwise: false)
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.drawPath(using: .fill)
        }
        
        imageView.image = img
    }
    
    func drawTwin() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 50, y: 0)
            
            ctx.cgContext.move(to: CGPoint(x: 20, y: 156))
            ctx.cgContext.addLine(to: CGPoint(x: 100, y: 156))
            ctx.cgContext.move(to: CGPoint(x: 60, y: 156))
            ctx.cgContext.addLine(to: CGPoint(x: 60, y: 270))
            ctx.cgContext.move(to: CGPoint(x: 120, y: 156))
            ctx.cgContext.addLine(to: CGPoint(x: 160, y: 270))
            ctx.cgContext.addLine(to: CGPoint(x: 200, y: 156))
            ctx.cgContext.addLine(to: CGPoint(x: 240, y: 270))
            ctx.cgContext.addLine(to: CGPoint(x: 280, y: 156))
            ctx.cgContext.move(to: CGPoint(x: 300, y: 156))
            ctx.cgContext.addLine(to: CGPoint(x: 300, y: 270))
            ctx.cgContext.move(to: CGPoint(x: 320, y: 270))
            ctx.cgContext.addLine(to: CGPoint(x: 320, y: 156))
            ctx.cgContext.addLine(to: CGPoint(x: 380, y: 270))
            ctx.cgContext.addLine(to: CGPoint(x: 380, y: 156))
            ctx.cgContext.setLineWidth(2.5)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = img
    }
    
}

