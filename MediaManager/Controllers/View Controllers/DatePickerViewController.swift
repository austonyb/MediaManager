//
//  DatePickerViewController.swift
//  MediaManager
//
//  Created by Auston Youngblood on 12/16/22.
//

import UIKit

protocol DatePickerDelegate: AnyObject {
    func reminderDateEdited(date: Date)
}

class DatePickerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Properties
    var date: Date?
    weak var delegate: DatePickerDelegate?
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Methods
    func setupViews() {
        self.datePicker.preferredDatePickerStyle = .wheels
    }
    
    // MARK: - Actions
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        self.date = sender.date
        //quick note on this one. The sender is the one sending back the date because it is the parameter invoked in the function. This makes it receive back the date sent over from the UI.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let delegate = delegate,
              let date = self.date else { return }
        delegate.reminderDateEdited(date: date)
        navigationController?.popViewController(animated: true)
    }
}
