//
//  DetailsViewController.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 24.01.2023.
//

import Foundation
import UIKit

protocol pDetailsViewController: AnyObject {
    
}

final class DetailsViewContorller: UIViewController, pDetailsViewController {
    var vm: pDetailsViewModel?
}
