//
//  CreateShiftVC.swift
//  DemoHomeBase

class CreateShiftVC: UIViewController{
    
    //MARK: - UITextField Outlets
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEmployee: UITextField!
    @IBOutlet weak var txtRole: UITextField!
    @IBOutlet weak var txtColor: UITextField!
    
    //MARK: - Variable Declaration
    private lazy var createShiftViewModel = {
        CreateShiftViewModel()
    }()
    var datePicker = UIDatePicker()
    var arrEmplyoee = [String]()
    var arrRole = [String]()
    var arrColor = [String]()
    var pickerEmplyoee  = UIPickerView()
    var pickerRole  = UIPickerView()
    var pickerColor  = UIPickerView()
    
    
    //MARK: - ViewController Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    //MARK: - Initialization Method
    private func initialization() {
        createShiftViewModel.delegate = self
        let toolBar = UIToolbar()

        txtStartDate.inputView = datePicker
        txtStartDate.inputAccessoryView   = toolBar
        
        txtEndDate.inputView = datePicker
        txtEndDate.inputAccessoryView = toolBar
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.sizeToFit()
        toolBar.setItems([doneButton], animated: true)
        
        self.pickerViewSet(pickerEmplyoee, txtEmployee, btnDone: #selector(CreateShiftVC.tapEmployeeGesture(_:)))
        self.pickerViewSet(pickerRole, txtRole, btnDone: #selector(CreateShiftVC.tapRoleGesture(_:)))
        self.pickerViewSet(pickerColor, txtColor, btnDone: #selector(CreateShiftVC.tapColorGesture(_:)))
        
    }
    
    //MARK: - Textfield button Method
    
    @objc func doneButtonTapped() {
        
        if txtStartDate.isFirstResponder {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            dateFormatter.dateFormat = DateAndTimeFormatString.strDateFormate_yyyyMMddhhmmss
            self.txtStartDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtStartDate.resignFirstResponder()
        
        
        if txtEndDate.isFirstResponder {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            dateFormatter.dateFormat = DateAndTimeFormatString.strDateFormate_yyyyMMddhhmmss
            self.txtEndDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtEndDate.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    //MARK: - Set PickerView in Textfield Method
    
    func pickerViewSet(_ picker:UIPickerView,_ textfield:UITextField,btnDone:Selector){
        picker.delegate = self
        picker.dataSource = self
        textfield.inputView = picker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let btnDone = UIBarButtonItem(title: "Done", style: .plain, target: self, action: btnDone)
        toolBar.setItems([btnDone], animated: true)
        toolBar.isUserInteractionEnabled = true
        textfield.inputAccessoryView = toolBar
        
    }
    //MARK: - UITapGestureRecognizer Action Method
    
    @objc func tapEmployeeGesture(_ sender:UITapGestureRecognizer){
        
        txtEmployee.resignFirstResponder()
        if txtEmployee.text == ""{
            txtEmployee.text = arrEmplyoee[0]
        }
    }
    @objc func tapRoleGesture(_ sender:UITapGestureRecognizer){
        if txtRole.text == ""{
            txtRole.text = arrRole[0]
        }
        txtRole.resignFirstResponder()
        
    }
    @objc func tapColorGesture(_ sender:UITapGestureRecognizer){
        if txtColor.text == ""{
            txtColor.text = arrColor[0]
        }
        txtColor.resignFirstResponder()
        
    }
    
    
    //MARK: - UIButton Action Method
    
    @IBAction func btnSelectEmplyoeeAct(_ sender: Any) {
        txtEmployee.becomeFirstResponder()
    }
    
    @IBAction func btnEndDateAct(_ sender: Any) {
        txtEndDate.becomeFirstResponder()
    }
    
    @IBAction func btnSelectRoleAct(_ sender: Any) {
        txtRole.becomeFirstResponder()
    }
    @IBAction func btnStartDateAct(_ sender: Any) {
        txtStartDate.becomeFirstResponder()
    }
    
    @IBAction func btnBackAct(_ sender: Any) {
        popVC()
    }
    @IBAction func btnColorAct(_ sender: Any) {
        txtColor.becomeFirstResponder()
    }
    @IBAction func btnSaveAct(_ sender: Any) {
        createShiftViewModel.checkValidation(strStartDate: txtStartDate.text ?? "", strEndDate: txtEndDate.text ?? "", strEmployee: txtEmployee.text ?? "", strRole: txtRole.text ?? "", strColor: txtColor.text ?? "")
    }
    
}


