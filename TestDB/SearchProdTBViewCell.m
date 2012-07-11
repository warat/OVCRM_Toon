//
//  SearchProdTBViewCell.m
//  TestDB
//
//  Created by Admin on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchProdTBViewCell.h"

@implementation SearchProdTBViewCell
@synthesize lblProdCode;
@synthesize lblProdName;
@synthesize lblProdCost;
@synthesize swSelectProduct;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
