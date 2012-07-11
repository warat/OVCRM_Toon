//
//  tblCallcard_Stock.h
//  DBAppTest
//
//  Created by Admin on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface tblCallcard_Stock : NSObject

@property(nonatomic,strong) NSString *callCard_PK;
@property(nonatomic,assign) NSString *PK;
@property(nonatomic,strong) NSString *product_Name;
@property(nonatomic,strong) NSString *onShelf;
@property(nonatomic,strong) NSString *inStock;

@property(strong , nonatomic) NSMutableArray  *callCardStockList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

-(NSString *)GetMaxRnNo;

@end
