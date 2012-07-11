//
//  AppDelegate.h
//  TestDB
//
//  Created by Warat Agatwipat on 6/28/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

#define DATABASE_NAME @"Ovaltine_DB.db"
#define DATABASE_TITLE @"Ovaltine_DB"

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UINavigationController * navController;

@end
