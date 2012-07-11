//
//  tblParameter.h
//  TestDB
//
//  Created by Admin on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface tblParameter : NSObject

@property(nonatomic,strong) NSString *tag;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *label;

@property(strong , nonatomic) NSMutableArray  *parameterList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

@end
