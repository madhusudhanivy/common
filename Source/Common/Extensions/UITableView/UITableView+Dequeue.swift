//
//  UITableView+Dequeue.swift
//  Sports Betting
//
//  Created by Kristina Del Rio on 29.11.2019.
//  Copyright © 2019 Ladbrokes Coral part of GVC group. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Cannot dequeue reusable cell with identifier \(T.reuseID)")
        }

        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.reuseID) as? T else {
            fatalError("Cannot dequeue reusable HeaderFooter with identifier \(T.reuseID)")
        }

        return headerFooter
    }
}
