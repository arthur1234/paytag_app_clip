//
//  CartDataSource.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 21.02.2023.
//

import UIKit

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartService.shared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartTableViewCell.self), for: indexPath) as! CartTableViewCell
        
        let item = CartService.shared.all()[indexPath.row]
        cell.set(image: item.imageUrl, title: item.name, color: item.color, size: item.size, price: item.price, discount: item.discountPrice)
        cell.onTapRemove = { [weak self] in
            self?.presenter.didTapRemove(index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(index: indexPath.row)
    }
}
