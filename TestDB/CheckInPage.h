//
//  CheckInPage.h
//  TestDB
//
//  Created by Warat Agatwipat on 6/28/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface CheckInPage : UIViewController<CLLocationManagerDelegate>{
    IBOutlet MKMapView *mapView;
    NSString * account_ID;
    NSString * plan_ID;
}

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) IBOutlet UILabel *lbAccountLatitude;
@property (strong, nonatomic) IBOutlet UILabel *lbAccountLongitude;
@property (strong, nonatomic) IBOutlet UILabel *lbCheckInLatitude;
@property (strong, nonatomic) IBOutlet UILabel *lbCheckInLongitude;
@property (strong, nonatomic) IBOutlet UILabel *lbCheckInDate;
@property (strong, nonatomic) IBOutlet UILabel *lbCheckInTime;

@end
