//
//  CheckInPage.m
//  TestDB
//
//  Created by Warat Agatwipat on 6/28/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "CheckInPage.h"

@interface CheckInPage ()
-(void) startLocationService;
-(void) stopLocationService;

@end

@implementation CheckInPage

@synthesize lbAccountLatitude = _lbAccountLatitude;
@synthesize lbAccountLongitude = _lbAccountLongitude;
@synthesize lbCheckInLatitude = _lbCheckInLatitude;
@synthesize lbCheckInLongitude = _lbCheckInLongitude;
@synthesize lbCheckInDate = _lbCheckInDate;
@synthesize lbCheckInTime = _lbCheckInTime;
@synthesize locationManager = _locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self startLocationService];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocation *currentLocation=_locationManager.location;
    
    _lbAccountLatitude.text = [NSString stringWithFormat:@"%+.6f",currentLocation.coordinate.latitude];
    _lbAccountLongitude.text = [NSString stringWithFormat:@"%+.6f",currentLocation.coordinate.longitude];
    _lbCheckInLatitude.text = [NSString stringWithFormat:@"%+.6f",currentLocation.coordinate.latitude];
    _lbCheckInLongitude.text = [NSString stringWithFormat:@"%+.6f",currentLocation.coordinate.longitude];
    _lbCheckInDate.text = [NSString stringWithFormat:@"%@",[self dateToString:currentLocation.timestamp]];
    _lbCheckInTime.text = [NSString stringWithFormat:@"%@",[self timeToString:currentLocation.timestamp]];
    
    mapView.mapType = MKMapTypeHybrid;
    
    CLLocationCoordinate2D coordinate = [currentLocation coordinate];
    
    /////////////////////////////////////////
    coordinate.latitude = 13.715;
    coordinate.longitude = 100.609;
    /////////////////////////////////////////    
    
    MKCoordinateSpan span ;
    span.latitudeDelta = 0.001;
    span.longitudeDelta = 0.001;
    
    MKCoordinateRegion region ;//= {coord, span};
    region.center = coordinate;
    region.span = span;
    
    [mapView setRegion:region animated:YES];
    [mapView setRegion:region];
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = coordinate;
    //    annotationPoint.title = @"";//Microsoft";
    //    annotationPoint.subtitle = @"";//Microsoft's headquarters";
    [mapView addAnnotation:annotationPoint]; 
    
    
    MKPointAnnotation *annotationPoint2 = [[MKPointAnnotation alloc] init];
    annotationPoint2.coordinate = coordinate;
    [mapView setZoomEnabled:YES];
    [mapView addAnnotation:annotationPoint2]; 
    
}

-(void) startLocationService{
    if(self.locationManager==nil){
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.delegate=self;
        _locationManager.purpose = @"We will try to tell you where you are if you get lost";
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=500;
        self.locationManager=_locationManager;
    }
    
    if([CLLocationManager locationServicesEnabled]){
        [self.locationManager startUpdatingLocation];
    }
}

-(void) stopLocationService{
    if([CLLocationManager locationServicesEnabled]){
        [self.locationManager stopUpdatingLocation];//startUpdatingLocation];
    }
}

-(NSString *)dateToString:(NSDate*)sDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    //NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:118800];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];//@"en_US"];
    [dateFormatter setLocale:usLocale];
    
    //NSLog(@"Date for locale %@: %@",
    //      [[dateFormatter locale] localeIdentifier], [dateFormatter stringFromDate:sDate]);
    
    return [dateFormatter stringFromDate:sDate];
}

-(NSString *)timeToString:(NSDate*)sDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    
    //NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:118800];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];//@"en_US"];
    [dateFormatter setLocale:usLocale];
    
    //NSLog(@"Date for locale %@: %@",
    //      [[dateFormatter locale] localeIdentifier], [dateFormatter stringFromDate:sDate]);
    
    return [dateFormatter stringFromDate:sDate];
}

@end
