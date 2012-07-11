//
//  MyTableViewCell.m
//  TestDB
//
//  Created by Admin on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
@synthesize lblProdCost;


@synthesize lblProdName;
@synthesize lblProdCode;
//@synthesize lblProdCost;

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
