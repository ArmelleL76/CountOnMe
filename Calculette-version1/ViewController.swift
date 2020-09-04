//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    let calculator = CountOnMeCalculator()
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addANumber(numberText)
        textView.text = calculator.expression
    }
    
    private func showMessage(_ message: String) {
        let alertVC = UIAlertController(title: "Erreur!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    private func addOperator(_ ope: String) {
        //good way
        do {
            try calculator.addOperator(ope)
            textView.text = calculator.expression
        } catch CountOnMeCalculator.Error.cantAddOperator {
            return showMessage("Un operateur est déja mis ")
        } catch {
            // do nothing
        }
        
//        guard calculator.canAddOperator() else {
//            return showMessage("Un operateur est déja mis ")
//        }
//        calculator.addOperator(ope)
//        textView.text = calculator.expression
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        addOperator("+")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        addOperator("-")
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        addOperator("x")
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        addOperator("/")
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        calculator.reset()
        textView.text = calculator.expression
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionHasEnoughElement(elements: calculator.elements) else {
            return showMessage("Votre expression est incomplète, démarrez un nouveau calcul!")
        }
        guard calculator.expressionIsCorrect(elements: calculator.elements) else {
            return  showMessage("Entrez une expression correcte!")
        }
        guard calculator.dividingIsPossible(elements: calculator.elements) else {
            return showMessage("La division par zéro est impossible!")
        }
        textView.text = calculator.equalFunc(elements: calculator.elements)
    }
}
