//
//  IDTWeatherAPIClient.m
//  IDT-Test
//
//  Created by Mohamed EL Meseery on 11/29/16.
//  Copyright © 2016 Mohamed EL Meseery. All rights reserved.
//

#import "IDTWeatherService.h"
#import <AFNetworking.h>
#import <Mantle.h>
#import "IDTWeatherDay.h"

@implementation IDTWeatherService

- (void)getWeatherInLocation:(CLLocation*)loc
                   onSuccess:(successBlock)success
                   onFailure:(failureBlock)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary * params = @{@"appid":KAPIKey,
                              @"lat":[NSString stringWithFormat:@"%f",loc.coordinate.latitude],
                              @"lon":[NSString stringWithFormat:@"%f",loc.coordinate.longitude]};
    [manager GET:KAPIBaseURL
      parameters:params
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             IDTWeatherDay * weatherDay = [MTLJSONAdapter modelOfClass:[IDTWeatherDay class] fromJSONDictionary:responseObject error:nil];
             success(weatherDay);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure(error);
    }];

}
@end
