//
//  SearchProdTBViewCell.h
//  TestDB
//
//  Created by Admin on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchProdTBViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblProdCode;

@property (strong, nonatomic) IBOutlet UILabel *lblProdName;

@property (strong, nonatomic) IBOutlet UILabel *lblProdCost;

@property (strong, nonatomic) IBOutlet UISwitch *swSelectProduct;


@end
