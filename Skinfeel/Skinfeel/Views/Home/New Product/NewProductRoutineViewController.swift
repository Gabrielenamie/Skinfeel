//
//  NewProductViewController.swift
//  Skincare
//
//  Created by Carolina Ortega on 06/12/21.
//

import Foundation
import UIKit

class NewProductRoutineViewController: UIViewController{
    
    @IBOutlet var productTableView: UITableView!
    var list: [String] = []
    var searchProduct: [String]!
    let defaults = UserDefaults.standard
    var chosenProducts: [String] = []

    var array: [String] = []
    var selectedSection: Int = 0
    
    @IBAction func saveButton(_ sender: Any) {
        if defaults.integer(forKey: "filtro") == 0 {
        if defaults.integer(forKey: "section") == 0 {
            defaults.setValue(array, forKey: "limpezaManha")
            print(array)
            defaults.removeObject(forKey: "newArray")
        } else if defaults.integer(forKey: "section") == 1 {
            defaults.setValue(array, forKey: "hidratacaoManha")
            print(array)
            defaults.removeObject(forKey: "newArray")
        } else {
            defaults.setValue(array, forKey: "protecaoManha")
            print(array)
            defaults.removeObject(forKey: "newArray")
        }
        } else if defaults.integer(forKey: "filtro") == 1 {
            defaults.setValue(array, forKey: "protecaoTarde")
            print(array)
            defaults.removeObject(forKey: "newArray")
        } else {
            if defaults.integer(forKey: "section") == 0 {
                defaults.setValue(array, forKey: "limpezaNoite")
                print(array)
                defaults.removeObject(forKey: "newArray")
            } else if defaults.integer(forKey: "section") == 1 {
                defaults.setValue(array, forKey: "esfoliacaoNoite")
                print(array)
                defaults.removeObject(forKey: "newArray")
            } else {
                defaults.setValue(array, forKey: "protecaoNoite")
                print(array)
                defaults.removeObject(forKey: "newArray")
            }
        }
        navigationController?.popViewController(animated: false)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
//        navigationItem.setHidesBackButton(true, animated: false)
        
        //tableView
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        
        //multi seleção
        self.productTableView.allowsMultipleSelection = true
        self.productTableView.allowsMultipleSelectionDuringEditing = true
        
        
    }
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chosenProducts = defaults.stringArray(forKey: "myKey") ?? []
        array = defaults.stringArray(forKey: "newArray") ?? []
        print(chosenProducts)
        list = chosenProducts
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
        
extension NewProductRoutineViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "produto", for: indexPath) as! ShelfFormTableViewCell
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = self.tableView(productTableView, cellForRowAt: indexPath)
            let text = cell.textLabel!.text
            if let text = text {
                NSLog("did select and the text is \(text)")
                if !array.contains(text){
                    array.append(text)
                    print("Novo array", array)
                }

        }
        defaults.set(array, forKey: "newArray")
    }
        
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = self.tableView(productTableView, cellForRowAt: indexPath)
        let text = cell.textLabel!.text
        if let text = text {
            NSLog("did deselect and the text is \(text)")
            if let index = array.firstIndex(of: text) {
                array.remove(at: index)
                print(array)
                
            }
            defaults.set(array, forKey: "newArray")

        }

    }
    
}
extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

