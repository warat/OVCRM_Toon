//
//  tblOrderDetail.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/9/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface tblOrderDetail : NSObject

@property(nonatomic,strong) NSString *pK;
@property(nonatomic,strong) NSString *product_ID;
@property(nonatomic,strong) NSString *discount_Rate;
@property(nonatomic,strong) NSString *orderMaster_PK;

@property (nonatomic,strong) NSDecimalNumber * suggest;
@property (nonatomic,strong) NSDecimalNumber * total;
@property (nonatomic,strong) NSDecimalNumber * totalDiscount;
@property (nonatomic,strong) NSDecimalNumber * discount;
@property (nonatomic,strong) NSDecimalNumber * price;
@property (nonatomic,strong) NSDecimalNumber * totalPrice;
@property (nonatomic,strong) NSDecimalNumber * quantity;

@property(strong , nonatomic) NSMutableArray  *orderDetailList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(NSMutableArray *)QueryData2:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

-(NSString *)GetMaxRnNo;

@end
