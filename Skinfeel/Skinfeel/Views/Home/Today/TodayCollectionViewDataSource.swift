//
//  TodayCollectionViewDataSource.swift
//  Skinfeel
//
//  Created by Carolina Ortega on 11/02/22.
//

import Foundation
import UIKit

class TodayCollectionViewDataSource: NSObject, UICollectionViewDataSource{

    private lazy var today = TodayViewController()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return today.rotinasData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rotine", for: indexPath) as! RoutineCollectionViewCell
        cell.nameRoutine.text = today.rotinasData[indexPath.row].routineName
        // guard let cell = routineCollectionView.dequeueReusableCell(withReuseIdentifier: "rotine", for: indexPath) as? RoutineCollectionViewCell else {return UICollectionViewCell()}
        cell.morningCircularProgress.image = UIImage(named: "dia")
        cell.afternoonCircularProgress.image = UIImage(named: "tarde")
        cell.nightCircularProgress.image = UIImage(named: "lua")

        
//        let soma = (oi?[indexPath.row].somaManha)!/10 //total de itens
//        let yourSoma = (oi?[indexPath.row].yourSomaManha)!/10 //total de itens selecionados
//        let isSalvo = oi?[indexPath.row].salvo
//        let result = Float(yourSoma/soma)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 170)
    }
}
