//
//  tblProduct.h
//  TestDB
//
//  Created by Admin on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface tblProduct : NSObject

@property(nonatomic,strong) NSString *PK;
@property(nonatomic,strong) NSString *sale_ID;
@property(nonatomic,strong) NSString *product_Code;
@property(nonatomic,strong) NSString *product_Name;
@property(nonatomic,strong) NSString *lastSyncDate;
@property(nonatomic,strong) NSString *lastSyncTime;
@property(nonatomic,assign) NSInteger cost;
@property(nonatomic,strong) NSString *weight;  
@property(nonatomic,strong) NSString *packaging;
@property(nonatomic,strong) NSString *width;
@property(nonatomic,strong) NSString *packSize;
@property(nonatomic,strong) NSString *productLong;
@property(nonatomic,strong) NSString *height;
@property(nonatomic,strong) NSString *productCategory;
@property(nonatomic,strong) NSString *brand;
@property(nonatomic,strong) NSString *shortName ;
@property(nonatomic,strong) NSString *product_Family; 
@property(nonatomic,strong) NSString *target;
@property(nonatomic,strong) NSString *unitName;
@property(nonatomic,strong) NSString *isCancel;
@property(nonatomic,strong) NSString *activeFlag;
@property(nonatomic,strong) NSString *expireFlag;

//Block A :Property ด้านล่างนี้สำหรับรับinput ในprocessต่างๆ
@property(nonatomic,strong) NSString *returnAmt; 
//End Block A

@property(strong , nonatomic) NSMutableArray  *productList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

@end
