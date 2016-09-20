//
//  CloudQandATableViewController.swift
//  Pollster
//


import UIKit
import CloudKit

class CloudQandATableViewController: QandATableViewController {
    
    var ckQandARecord: CKRecord {
        get {
            if _ckQandARecord == nil {
                _ckQandARecord = CKRecord(recordType: Cloud.Entity.QandA)
            }
            return _ckQandARecord!
        }
        set {
            _ckQandARecord = newValue
        }
    }
    
    private var _ckQandARecord : CKRecord? {
        didSet {
            let question = ckQandARecord[Cloud.Attribute.Question] as? String ?? ""
            let answers = ckQandARecord[Cloud.Attribute.Answers] as? [String] ?? []
            qanda = QandA(question: question, answers: answers)
            
            asking = ckQandARecord.wasCreatedByThisUser
        }
    }
    
    private let database = CKContainer.default().publicCloudDatabase
    
    private func iCloudUpdate() {
        if !qanda.question.isEmpty && !qanda.answers.isEmpty {
            ckQandARecord[Cloud.Attribute.Question] = qanda.question as CKRecordValue
            ckQandARecord[Cloud.Attribute.Answers] = qanda.answers as CKRecordValue
            iCloudSaveRecord(recordToSave: ckQandARecord)
        }
    }
    
    private func iCloudSaveRecord(recordToSave: CKRecord) {
        
        database.save(recordToSave) { (savedRecord, error) in
            guard let ckerror = error as? CKError else { return }
            if ckerror.code == CKError.serverRecordChanged {
                // ignore
            } else if error != nil {
               // self.retryAfterError(error: error, withSelector: #selector(self.iCloudUpdate))
            }
        }
    }
    
    private func retryAfterError(error: NSError?, withSelector selector: Selector) {
        if let retryInterval = error?.userInfo[CKErrorRetryAfterKey] as? TimeInterval {
            Timer.scheduledTimer(timeInterval: retryInterval, target: self, selector: selector, userInfo: nil, repeats: false)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        super.textViewDidEndEditing(textView: textView)
        iCloudUpdate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        ckQandARecord = CKRecord(recordType: Cloud.Entity.QandA)
    }

}
