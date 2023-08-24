//
//  ContactDetailsViewController.swift
//  ContactList
//
//  Created by Lera Savchenko on 22.08.23.
//

import UIKit
import AlamofireImage

class ContactDetailsViewController: UIViewController {

    @IBOutlet var contactImage: UIImageView!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var secondNameLabel: UILabel!
    
    var result: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues(with: result)
        
    }
    
    override func viewWillLayoutSubviews() {
        contactImage.layer.cornerRadius = contactImage.bounds.height / 1.9
    }
    
    private func setValues(with user: User) {
        firstNameLabel.text = user.name?.first
        secondNameLabel.text = user.name?.last
        
        guard let imageUrl = URL(string: user.picture?.large ?? "") else { return }
        contactImage.af.setImage(withURL: imageUrl)
    }

}
