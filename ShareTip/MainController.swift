//
//  ViewController.swift
//  ShareTip
//
//  Created by YardenSwisa on 20/08/2020.
//  Copyright © 2020 YardenSwisa. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    /// Outlets
    @IBOutlet weak var totalSumTF: UITextField!
    @IBOutlet weak var numOfPeopleSlider: UISlider!
    @IBOutlet weak var tipPercentSegment: UISegmentedControl!
    @IBOutlet weak var billPerPersonLabel: UILabel!
    @IBOutlet weak var totalTipLabel: UILabel!
    @IBOutlet weak var tipPerPersonLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var sliderLabel: UILabel!
    
    /// Properties
    var totalSum = 0.0
    var numOfPeople = 0
    var tipPercent = 0.0
    var tipPerPerson = 0.0
    var billPerPerson = 0.0
    var totalPerPerson = 0.0
    var totalTip = 0.0
    
    
    /// LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        totalSumTF.becomeFirstResponder()
    }
    
    /// Methods
    
    //MARK: take screenShot without the upper bar and return image
    func screenShot() -> UIImage? {
        let layer = UIApplication.shared.keyWindow!.layer
        
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0.0)
        if UIGraphicsGetCurrentContext() != nil{
            layer.render(in: UIGraphicsGetCurrentContext()!)
            if let screenShot = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                return screenShot
            }
        }
        return nil
    }
    
    // MARK: Tip Precents
    func selectTipPrecent()-> Double{
        switch tipPercentSegment.selectedSegmentIndex {
        case 0:
            return 0.1
        case 1:
            return 0.125
        case 2:
            return 0.15
        case 3:
            return 0.175
        case 4:
            return 0.2
        default:
            return 0.1
        }
    }
    
    // MARK: Calculations
    func calculateTotalTip(totalSum: Double, tipPercent: Double)-> Double{
        var totalTip:Double
        
        totalTip = totalSum * tipPercent
        
        return totalTip
    }
    func calculateTipPerPerson(totalSum: Double, people: Int, tipPercent: Double)-> Double{
        var tipPerPerson:Double
        
        tipPerPerson = (totalSum * tipPercent) / Double(people)
        
        return tipPerPerson
    }
    func calculateBillPerPerson(totalSum: Double, people: Int)-> Double{
        var bill:Double
        
        bill = totalSum / Double(people)
        
        return bill
    }
    func calculateTotalPerPerson(totalSum: Double, people: Int, tipPercent: Double)-> Double{
        var totalPerPerson:Double
        let tip = (totalSum * tipPercent) / Double(people)
        let bill = (totalSum / Double(people))
        
        totalPerPerson = tip + bill
        
        return totalPerPerson
    }
    
    /// Actions
    
    //MARK: Calculate Tapped
    @IBAction func calculateTapped(_ sender: UIButton) {
        if let total = Double(totalSumTF.text!) {
            totalSum = total
        }else{//error
            print("totalSumTF -> only numbers")
        }
        
        numOfPeople = Int(numOfPeopleSlider.value)
        
        tipPercent = selectTipPrecent()
        
        billPerPerson = calculateBillPerPerson(totalSum: totalSum, people: numOfPeople)
        
        tipPerPerson = calculateTipPerPerson(totalSum: totalSum, people: numOfPeople, tipPercent: tipPercent)
        
        totalPerPerson = calculateTotalPerPerson(totalSum: totalSum, people: numOfPeople, tipPercent: tipPercent)
        
        totalTip = calculateTotalTip(totalSum: totalSum, tipPercent: tipPercent)
        
        billPerPersonLabel.text = String(format: "%.2f", billPerPerson)
        tipPerPersonLabel.text = String(format: "%.2f", tipPerPerson)
        totalTipLabel.text = String(format: "%.2f", totalTip)
        totalPerPersonLabel.text = String(format: "%.2f", totalPerPerson)
    }
    
    //MARK: Reset Bill, clear Tapped
    @IBAction func clearTapped(_ sender: UIButton){
        totalSumTF.becomeFirstResponder()
        totalSumTF.text = ""
        numOfPeopleSlider.value = 2
        sliderLabel.text = "2"
        tipPercentSegment.selectedSegmentIndex = 0
        tipPerPerson = 0.0
        totalTip = 0.0
        billPerPerson = 0.0
        totalPerPerson = 0.0
        billPerPersonLabel.text = "0.0"
        totalTipLabel.text = "0.0"
        tipPerPersonLabel.text = "0.0"
        totalPerPersonLabel.text = "0.0"
        
    }
    
    //MARK: share screenShot by email, whatsapp,massage etc...
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let acivityController = UIActivityViewController(activityItems: [screenShot()!], applicationActivities: nil)
        
        present(acivityController, animated: true, completion: nil)
    }
    
   // MARK: Select number of people
    @IBAction func sliderMoving(_ sender: UISlider) {
        let sliderInt = Int(sender.value)
        
        sliderLabel.text = "\(sliderInt)"
    }



}




