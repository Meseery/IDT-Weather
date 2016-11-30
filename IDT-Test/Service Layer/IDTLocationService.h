//
//  IDTLocationService.h
//  IDT-Test
//
//  Created by Mohamed EL Meseery on 11/30/16.
//  Copyright © 2016 Mohamed EL Meseery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


#define kLocationDenied @"Location_service_denied"

typedef void(^locationHandler)(CLLocation* loc);

@interface IDTLocationService : NSObject

@property (nonatomic, strong, readonly) NSString *currentLocationName;


-(id)initWithLocationUpdateHandler:(locationHandler) locationUpdateHandler;

@end
