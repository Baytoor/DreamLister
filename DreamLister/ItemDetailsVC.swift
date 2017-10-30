//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by baytoor on 8/13/17.
//  Copyright © 2017 Baytur. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var storePicked: UIPickerView!
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var typeField: CustomTextField!
    
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicked.dataSource = self
        storePicked.delegate = self
        
        let store1 = Store(context: context)
        store1.name = "Best Buy"
        let store2 = Store(context: context)
        store2.name = "Mercedes Dealership"
        let store3 = Store(context: context)
        store3.name = "Amazon"
        let store4 = Store(context: context)
        store4.name = "Aliexpress"
        let store5 = Store(context: context)
        store5.name = "Technodom"
        let store6 = Store(context: context)
        store6.name = "Magnum"
        
        getStores()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.textFieldShouldReturn(_:)))
        view.addGestureRecognizer(tap)
        
        self.titleField.delegate = self
        self.priceField.delegate = self
        self.detailsField.delegate = self
        self.typeField.delegate = self
        
        if itemToEdit != nil {
            loadItemData()
        }
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // update when selected
    }
    
    func getStores(){
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicked.reloadAllComponents()
        } catch {
            // handle the error
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImg.image
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            item.title = title
        }
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsField.text {
            item.details = details
        }
        if let type = typeField.text {
            item.toItemType?.type = type
        }
        item.toStore = stores[storePicked.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
        
    }
    
    
    
    func loadItemData() {
        
        if let item = itemToEdit {
            thumbImg.image = item.toImage?.image as? UIImage
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            typeField.text = item.toItemType?.type
            
            if let store = item.toStore {
                
                for index in 0..<stores.count {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicked.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imgBtnPressed (_ sender: Any){
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImg.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}
