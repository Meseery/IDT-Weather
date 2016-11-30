//
//  IDTWeatherAPIClient.h
//  IDT-Test
//
//  Created by Mohamed EL Meseery on 11/29/16.
//  Copyright © 2016 Mohamed EL Meseery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "IDTWeatherDay.h"

static NSString * const KAPIBaseURL = @"http://api.openweathermap.org/data/2.5/weather";
static NSString * const KAPIKey  =   @"7b07bf06d063e0fa01fe05324f611049";

typedef void (^successBlock) (IDTWeatherDay * weatherDay);
typedef void (^failureBlock) (NSError *error);

@interface IDTWeatherService : NSObject

- (void)getWeatherInLocation:(CLLocation*)location
                   onSuccess:(successBlock)success
                   onFailure:(failureBlock)failure;

@end
