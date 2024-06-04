//
//  Courses+TableView.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 04.06.2024.
//

import UIKit

extension CoursesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CoursesTableViewCell
        
        return cell
    }
}
