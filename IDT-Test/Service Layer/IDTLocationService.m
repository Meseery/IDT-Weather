//
//  IDTLocationService.m
//  IDT-Test
//
//  Created by Mohamed EL Meseery on 11/30/16.
//  Copyright © 2016 Mohamed EL Meseery. All rights reserved.
//

#import "IDTLocationService.h"



@interface IDTLocationService () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) void(^locationUpdateHandler)(CLLocation*);
@property (nonatomic, strong) NSString *currentLocationName;

@end

@implementation IDTLocationService
-(id)initWithLocationUpdateHandler:(locationHandler) locationUpdateHandler{
    
    self = [super init];
    
    [self initLocationService];
    self.locationUpdateHandler = locationUpdateHandler;
    
    [self getLocation];
    
    return self;
}

-(void)initLocationService{
    
    
    self.locationManager = [self createLocationManager];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    

    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        
        [self.locationManager requestWhenInUseAuthorization];
        
    }
    
    
}
- (CLLocationManager *)createLocationManager
{
    return [[CLLocationManager alloc] init];
}
-(void)getLocation{
    
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
        
        NSLog(@"Location service denied");

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kLocationDenied object:self];
        });
        
        return;
        
    }
    
   
    [self.locationManager requestWhenInUseAuthorization];
    
  
    [self.locationManager requestLocation];
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    
    if (kCLErrorDenied!=error.code) {
        
        NSLog(@"Location Eror");
        
    }
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    
    CLLocation *location = [locations lastObject];
    
    if (location.horizontalAccuracy > 0) {
        
        [self.locationManager stopUpdatingLocation];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
        [geocoder reverseGeocodeLocation:self.locationManager.location
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           
                           
                           if (error){
                               
                               NSLog(@"Geocode failed with error: %@", error);
                               
                               self.currentLocationName = @"Unknown Location";
                               self.locationUpdateHandler(location);
                               return;
                               
                           }
                           CLPlacemark *placemark = [placemarks objectAtIndex:0];
                           
                           
                           if (placemark.locality&&placemark.administrativeArea&&placemark.country) {
                               
                               self.currentLocationName = [NSString stringWithFormat:@"%@,%@,%@",placemark.locality,placemark.administrativeArea,placemark.country];
                           }
                           else if(placemark.administrativeArea&&placemark.country){
                               
                               self.currentLocationName = [NSString stringWithFormat:@"%@,%@",placemark.administrativeArea,placemark.country];
                           }
                           else if(placemark.country)
                           {
                               self.currentLocationName = [NSString stringWithFormat:@"%@",placemark.country];
                           }
                           else{
                               
                               self.currentLocationName = @"Unknown Location";
                           }
                           
                           self.locationUpdateHandler(location);
                           
                       }];
    }
}

@end
