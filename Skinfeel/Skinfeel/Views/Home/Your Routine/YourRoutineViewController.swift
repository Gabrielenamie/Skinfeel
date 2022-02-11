//
//  YourRoutineViewController.swift
//  Skincare
//
//  Created by Carolina Ortega on 09/12/21.
//

import Foundation
import UIKit

class YourRoutineViewController: UIViewController {
    
    weak var NewRoutineViewControllerDelegate: NewRoutineViewControllerDelegate?
    @IBOutlet var deleteRoutine: UIBarButtonItem!
    var routine: Routine = Routine()
    weak var YourRoutineViewControllerDelegate: YourRoutineViewControllerDelegate?
    @IBOutlet weak var routineNome: UILabel!
    @IBAction func deleteButton(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "", message: "Tem certeza de que deseja deletar esta rotina?".localized(), preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Apagar".localized(), style: .destructive, handler: {(action: UIAlertAction!) in
            
            //acao de deletar
            _ = try! CoreDataStackRoutine.deleteRoutine(routine: (self.nomeRotina?[YourRoutineViewController.index])!)
            self.navigationController?.popViewController(animated: true)
        }))
        ac.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        
        present(ac, animated: true, completion: nil)
        YourRoutineViewControllerDelegate?.didRegister()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var dataFilter = 0
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var defaults = UserDefaults.standard
    var selectedSection: Int?
    
    var limpezaManha: [String] = []
    var hidratacaoManha: [String] = []
    var protecaoManha: [String] = []
    var protecaoTarde: [String] = []
    var limpezaNoite: [String] = []
    var esfoliacaoNoite: [String] = []
    var protecaoNoite: [String] = []
    var somaManha: Float = 0.0
    var somaTarde: Float = 0.0
    var somaNoite: Float = 0.0
    
    
    var nomeRotina = try? CoreDataStackRoutine.getRoutine()
    static var index : Int = -1
    
//    @IBAction func saveButton(_ sender: Any) {
//        somaManha = Float(limpezaManha.count + hidratacaoManha.count + protecaoManha.count)
//        somaTarde = Float(protecaoTarde.count)
//        somaNoite = Float(limpezaNoite.count + protecaoNoite.count + esfoliacaoNoite.count)
//        
//        var salvo = try? CoreDataStackRoutine.saveRoutine(salvo: true, routine: routine)
//        print("batata \(salvo!)")
//        
//        var soma = try? CoreDataStackRoutine.createSumYour(routine: routine, protecaomanha: protecaoManha, protecaotarde: protecaoTarde, protecaonoite: protecaoNoite, limpezamanha: limpezaManha, limpezanoite: limpezaNoite, hidratacaomanha: hidratacaoManha, esfoliacaonoite: esfoliacaoNoite, yourSomaManha: Float(limpezaManha.count + protecaoManha.count + hidratacaoManha.count), yourSomaTarde: Float(protecaoTarde.count), yourSomaNoite: Float(limpezaNoite.count + protecaoNoite.count + esfoliacaoNoite.count))
//        print("batata \(soma!)")
//        
//        defaults.set(true, forKey: "feito")
//        navigationController?.popViewController(animated: true)
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        navigationController?.setNavigationBarHidden(false, animated: false)
        routineNome.text = nomeRotina?[YourRoutineViewController.index].routineName
    
        //multi seleção
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        routineNome.text = nomeRotina?[YourRoutineViewController.index].routineName
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        routineNome.text = nomeRotina?[YourRoutineViewController.index].routineName
    }
    //reload da tableView
    func reload() {
        self.tableView.reloadData()
    }
    
    //segmentedControl
    @IBAction func segmentedControlAction(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            dataFilter = 0
        case 1:
            dataFilter = 1
        case 2:
            dataFilter = 2
        default:
            dataFilter = 0
        }
        reload()
        
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension YourRoutineViewController: YourRoutineViewControllerDelegate{
    func didRegister() {
        nomeRotina = try! CoreDataStackRoutine.getRoutine()
        
    }
}

//tableView
extension YourRoutineViewController: UITableViewDelegate{
    
}

extension YourRoutineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataFilter == 0 {
            if section == 0 {
                return routine.limpezamanha?.count ?? 0
            } else if section == 1 {
                return routine.hidratacaomanha?.count ?? 0
            } else {
                return routine.protecaomanha?.count ?? 0
            }
        }
        else if dataFilter == 1 {
            return routine.protecaotarde?.count ?? 0
            
        } else {
            if section == 0 {
                return routine.limpezanoite?.count ?? 0
            } else if section == 1 {
                return routine.esfoliacaonoite?.count ?? 0
            } else {
                return routine.protecaonoite?.count ?? 0
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch dataFilter {
        case 0:
            return 3
        case 1:
            return 1
        case 2:
            return 3
        default:
            return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        let text = cell.textLabel!.text
            if let text = text {
                if dataFilter == 0 {
                    if indexPath.section == 0 {
                        NSLog("did deselect and the text is \(text)")
                        if let index = limpezaManha.firstIndex(of: text) {
                            limpezaManha.remove(at: index)
                        }
                    } else if indexPath.section == 1 {
                        NSLog("did deselect and the text is \(text)")
                        if let index = hidratacaoManha.firstIndex(of: text) {
                            hidratacaoManha.remove(at: index)
                        }
                    } else {
                        NSLog("did deselect and the text is \(text)")
                        if let index = protecaoManha.firstIndex(of: text) {
                            protecaoManha.remove(at: index)
                        }
                    }
                } else if dataFilter == 1 {
                    NSLog("did deselect and the text is \(text)")
                    if let index = protecaoTarde.firstIndex(of: text) {
                        protecaoTarde.remove(at: index)
                    }
                    
                } else {
                    if indexPath.section == 0 {
                        NSLog("did deselect and the text is \(text)")
                        if let index = limpezaNoite.firstIndex(of: text) {
                            limpezaNoite.remove(at: index)
                        }
                    } else if indexPath.section == 1 {
                        NSLog("did deselect and the text is \(text)")
                        if let index = esfoliacaoNoite.firstIndex(of: text) {
                            esfoliacaoNoite.remove(at: index)
                        }
                    } else {
                        NSLog("did select and the text is \(text)")
                        if let index = protecaoNoite.firstIndex(of: text) {
                            protecaoNoite.remove(at: index)
                        }
                        
                    }
                }
                
            }
        }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch dataFilter {
        case 0:
            switch section {
            case 0:
                return "Limpeza".localized()
            case 1:
                return "Hidratação".localized()
            case 2:
                return "Proteção".localized()
            default:
                return "Limpeza".localized()
                
            }
        case 1:
            switch section {
            case 0:
                return "Proteção".localized()
            default:
                return "Proteção".localized()
                
            }
        case 2:
            switch section {
            case 0:
                return "Limpeza".localized()
            case 1:
                return "Esfoliação".localized()
            case 2:
                return "Proteção".localized()
            default:
                return "Limpeza".localized()
                
            }
        default:
            switch section {
            case 0:
                return "Limpeza".localized()
            case 1:
                return "Hidratação".localized()
            case 2:
                return "Proteção".localized()
            default:
                return "Limpeza".localized()
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataFilter == 0 {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "yourRoutine", for: indexPath) as! YourRoutineTableViewCell
                cell.textLabel?.text = routine.limpezamanha?[indexPath.row]
                
                return cell
                
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "yourRoutine", for: indexPath) as! YourRoutineTableViewCell
                cell.textLabel?.text = routine.hidratacaomanha?[indexPath.row]
                return cell
                
            } else if indexPath.section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "yourRoutine", for: indexPath) as! YourRoutineTableViewCell
                cell.textLabel?.text = routine.protecaomanha?[indexPath.row]
                return cell
                
            }
        } else if dataFilter == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "yourRoutine", for: indexPath) as! YourRoutineTableViewCell
            cell.textLabel?.text = routine.protecaotarde?[indexPath.row]
            return cell
            
        } else {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "yourRoutine", for: indexPath) as! YourRoutineTableViewCell
                cell.textLabel?.text = routine.limpezanoite?[indexPath.row]
                return cell
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "yourRoutine", for: indexPath) as! YourRoutineTableViewCell
                cell.textLabel?.text = routine.esfoliacaonoite?[indexPath.row]
                return cell
                
                
            } else if indexPath.section == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "yourRoutine", for: indexPath) as! YourRoutineTableViewCell
                cell.textLabel?.text = routine.protecaonoite?[indexPath.row]
                return cell
                
            }
            
        }
        
        
        return UITableViewCell()
    }
}

