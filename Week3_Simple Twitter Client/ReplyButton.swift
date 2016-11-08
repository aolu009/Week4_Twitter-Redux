//
//  ReplyButton.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 11/3/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

protocol ReplyButtonDataSource {
    func replyButton() -> String
}

class ReplyButton: UIButton {
    var datasource : ReplyButtonDataSource?
    var tweetInfo : Tweet?

}
