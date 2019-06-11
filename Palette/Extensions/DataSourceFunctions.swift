//
//  DataSourceFunctions.swift
//  Palette
//
//  Created by Kaden Hendrickson on 6/11/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

extension PaletteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageViewSpace: CGFloat = (view.frame.width - (2 * SpacingConstants.outerHorizontalPadding))
        let titleLabelSpace: CGFloat = SpacingConstants.oneLineElementHeight
        let colorPaletteViewSpace: CGFloat = SpacingConstants.twoLineElementHeight
        let verticalPadding: CGFloat = (3 * SpacingConstants.verticalObjectBuffer)
        let outerVerticalPadding: CGFloat = (2 * SpacingConstants.outerVerticalPadding)
        return imageViewSpace + titleLabelSpace + colorPaletteViewSpace + verticalPadding + outerVerticalPadding
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as! PaletteTableViewCell
        //select photo
        let unsplashPhoto = photos[indexPath.row]
        //assign photo to cell
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
    
    
}

