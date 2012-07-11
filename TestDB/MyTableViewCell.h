//
//  MyTableViewCell.h
//  TestDB
//
//  Created by Admin on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblProdName;
@property (strong, nonatomic) IBOutlet UILabel *lblProdCode;
@property (strong, nonatomic) IBOutlet UILabel *lblProdCost;

@end
