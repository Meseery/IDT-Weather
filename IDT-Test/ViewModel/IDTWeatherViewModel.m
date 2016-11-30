//
//  IDTWeatherViewModel.m
//  IDT-Test
//
//  Created by Mohamed EL Meseery on 11/30/16.
//  Copyright © 2016 Mohamed EL Meseery. All rights reserved.
//

#import "IDTWeatherViewModel.h"


@interface IDTWeatherViewModel () <CLLocationManagerDelegate>

@property (nonatomic, strong) IDTLocationService *locationService;

@property (nonatomic, strong) IDTWeatherService * weatherService;

@end

@implementation IDTWeatherViewModel

-(id)init{
    
    self = [super init];
    
    self.weatherService = [[IDTWeatherService alloc]init];
    //Once the location is available fetch the weather data
    self.locationService = [[IDTLocationService alloc]initWithLocationUpdateHandler:^(CLLocation * location){
        
        [self getWeatherInLocation:location];
        
    }];
    
    return self;
}

#pragma mark - Weather fetch

//Download weather info as json and convert it to Mantle model objects
-(void)getWeatherInLocation:(CLLocation*)location{
    
    //Restrict once reqest at a time
    static BOOL requstInProgress;
    
    if (requstInProgress) {
        
        return;
    }
    [self.weatherService getWeatherInLocation:location onSuccess:^(IDTWeatherDay *weatherDay) {
        

        self.weatherDay = weatherDay;
        
        self.currentPlace = self.locationService.currentLocationName;
        
        requstInProgress = NO;
        
        
    } onFailure:^(NSError *error) {
        
        requstInProgress = NO;
    } ];
    
    
    
}

@end
