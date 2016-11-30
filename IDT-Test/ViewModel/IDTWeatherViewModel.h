//
//  IDTWeatherViewModel.h
//  IDT-Test
//
//  Created by Mohamed EL Meseery on 11/30/16.
//  Copyright © 2016 Mohamed EL Meseery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "IDTLocationService.h"
#import "IDTWeatherService.h"

@interface IDTWeatherViewModel : NSObject

@property (nonatomic, strong) IDTWeatherDay *weatherDay;
@property (nonatomic, strong) NSString *currentPlace;

@end
