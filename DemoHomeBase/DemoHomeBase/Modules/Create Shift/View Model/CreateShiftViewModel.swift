//
//  CreateShiftViewModel.swift
//  DemoHomeBase

//MARK: - CreateShiftViewModel Protocol
protocol CreateShiftViewModelDelegate: AnyObject {
    func moveToShifts()
}

class CreateShiftViewModel {
    
    //MARK: - Variable Declaration
    weak var delegate: CreateShiftViewModelDelegate?
    
    //MARK: - Check Validation Method
    func checkValidation(strStartDate : String, strEndDate : String,strEmployee : String,strRole : String,strColor : String) {
        
        if validateFields(strStartDate, strEndDate, strEmployee, strRole, strColor){
            //MARK: - Save Shift to Core data
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let newNote = ShiftDetail(context: managedContext)
            newNote.setValue(strEmployee, forKey: ConstantsKeys.kName)
            newNote.setValue(strRole, forKey: ConstantsKeys.kRole)
            newNote.setValue("\(strStartDate) -08:00", forKey: ConstantsKeys.kStartDate)
            newNote.setValue("\(strEndDate) -08:00", forKey: ConstantsKeys.kEndDate)
            newNote.setValue(strColor, forKey: ConstantsKeys.kColor)
            
            print(newNote)
            do {
                try managedContext.save()
                Utility().showToast( AlertMessage.msgShiftSaved)
            } catch _ {
                print("Failed")
            }
            delegate?.moveToShifts()
        }
        
    }
    
    //MARK: - Validate Fields Method
    fileprivate func validateFields(_ startDate: String,_ endDate: String,_ employee: String,_ role: String,_ color: String) -> Bool {
        
        var isValid = false
        if startDate.isEmpty {
            Utility().showToast( AlertMessage.msgStartDate)
            isValid = false
        } else if endDate.isEmpty {
            Utility().showToast( AlertMessage.msgEndDate)
            isValid = false
        } else if employee.isEmpty {
            Utility().showToast( AlertMessage.msgEmplyoee)
            isValid = false
        } else if role.isEmpty {
            Utility().showToast( AlertMessage.msgRole)
            isValid = false
        } else if color.isEmpty {
            Utility().showToast( AlertMessage.msgColor)
            isValid = false
        }else {
            isValid = true
        }
        
        return isValid
    }
    
}
//MARK: - UIPickerViewDelegate & UIPickerViewDataSource Extension

extension CreateShiftVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         if pickerView == pickerEmplyoee {
             return arrEmplyoee.count
         }else if  pickerView == pickerRole{
             return arrRole.count
         }else{
             return arrColor.count
         }
     }
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         if pickerView == pickerEmplyoee {
             return arrEmplyoee[row]
         }else if  pickerView == pickerRole{
             return arrRole[row]
         }else{
             return arrColor[row]
         }
     }
     
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         if pickerView == pickerEmplyoee {
             txtEmployee.text = arrEmplyoee[row]
         }else if  pickerView == pickerRole{
             txtRole.text = arrRole[row]
         }else{
             txtColor.text = arrColor[row]
         }
     }
}
//MARK: - CreateShift Delegate Extension
extension CreateShiftVC : CreateShiftViewModelDelegate {
    
    func moveToShifts() {
        popVC()
    }
}
