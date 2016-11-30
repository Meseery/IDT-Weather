//
//  IDTWeather.m
//  IDT-Test
//
//  Created by Mohamed EL Meseery on 11/29/16.
//  Copyright © 2016 Mohamed EL Meseery. All rights reserved.
//

#import "IDTWeatherDay.h"

@implementation IDTWeatherDay

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"date": @"dt",
             @"pressure":@"main.pressure",
             @"humidity": @"main.humidity",
             @"temperature": @"main.temp",
             @"windBearing": @"wind.deg",
             @"windSpeed": @"wind.speed",
             @"conditionDescription": @"weather",
             @"icon": @"weather"
             };
}



+ (NSValueTransformer *)conditionDescriptionJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray* array, BOOL *success, NSError *__autoreleasing *error) {
        return [array firstObject][@"description"];
    } reverseBlock:^id(NSString* desc, BOOL *success, NSError *__autoreleasing *error) {
        return @[desc];
    }];

}

+ (NSValueTransformer *)conditionJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray* array, BOOL *success, NSError *__autoreleasing *error) {
        return [array firstObject][@"main"];
    } reverseBlock:^id(NSString* cond, BOOL *success, NSError *__autoreleasing *error) {
        return @[cond];
    }];

}

+ (NSValueTransformer *)iconJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray* array, BOOL *success, NSError *__autoreleasing *error) {
        return [array firstObject][@"icon"];
    } reverseBlock:^id(NSString* icon, BOOL *success, NSError *__autoreleasing *error) {
        return @[icon];
    }];

}

+ (NSValueTransformer *)dateJSONTransformer {
    
   return  [MTLValueTransformer transformerUsingForwardBlock:^id(NSString* str, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:str.floatValue];
        
    } reverseBlock:^id(NSDate* date, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    }];
    
}

+ (NSValueTransformer *)sunriseJSONTransformer {
    return [self dateJSONTransformer];
}

+ (NSValueTransformer *)sunsetJSONTransformer {
    return [self dateJSONTransformer];
}

#define MPS_TO_MPH 2.23694f

+ (NSValueTransformer *)windSpeedJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber* value, BOOL *success, NSError *__autoreleasing *error) {
        return @(value.floatValue*MPS_TO_MPH);
    } reverseBlock:^id(NSNumber* speed, BOOL *success, NSError *__autoreleasing *error) {
        return @(speed.floatValue/MPS_TO_MPH);
    }];
}

+ (NSDictionary *)imageMap {
    static NSDictionary *_imageMap = nil;
    if (! _imageMap) {
        _imageMap = @{
                      @"01d" : @"weather-clear",
                      @"02d" : @"weather-few",
                      @"03d" : @"weather-few",
                      @"04d" : @"weather-broken",
                      @"09d" : @"weather-shower",
                      @"10d" : @"weather-rain",
                      @"11d" : @"weather-tstorm",
                      @"13d" : @"weather-snow",
                      @"50d" : @"weather-mist",
                      @"01n" : @"weather-moon",
                      @"02n" : @"weather-few-night",
                      @"03n" : @"weather-few-night",
                      @"04n" : @"weather-broken",
                      @"09n" : @"weather-shower",
                      @"10n" : @"weather-rain-night",
                      @"11n" : @"weather-tstorm",
                      @"13n" : @"weather-snow",
                      @"50n" : @"weather-mist",
                      };
    }
    return _imageMap;
}

- (NSString *)imageName {
    return [IDTWeatherDay imageMap][self.icon];
}

@end
