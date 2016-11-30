//
//  IDTWeatherView.m
//  IDT-Test
//
//  Created by Mohamed EL Meseery on 11/30/16.
//  Copyright © 2016 Mohamed EL Meseery. All rights reserved.
//

#import "IDTWeatherView.h"


@implementation IDTWeatherView

-(void)setWeatherConditionNow:(IDTWeatherDay*)day{

    self.weatherIcon.image = [UIImage imageNamed:day.imageName];
    self.temperatureLabel.text = [NSString stringWithFormat:@"%.1f°C",[self convertToCelsius:day.temperature.floatValue]];
    self.weatherDescriptionLabel.text = day.conditionDescription;
    self.dateTimeLabel.text = [self getFormattedDate:day.date];
    self.humidityLabel.text = [NSString stringWithFormat:@"%@ %@",day.humidity, @"%"];
    
    self.pressureLabel.text = [NSString stringWithFormat:@"%@ hPa", [self getRoundedValue:(day.pressure)]];
    self.windSpeedLabel.text = [NSString stringWithFormat:@"%@ meter/sec", [self getRoundedValue:(day.windSpeed)]];
    self.windDirectionLabel.text = [NSString stringWithFormat:@"%@ degrees", [self getRoundedValue:(day.windBearing)]];
    
}

- (void)SetCurrentPlaceName:(NSString*)name{
    
    self.cityLabel.text = name;
}

//convert to celsius
- (float)convertToCelsius:(float)fahrenheit{
    
    return (fahrenheit-32)*5/9;
    
}

- (NSString*) getRoundedValue:(NSNumber*) value {
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setPositiveFormat:@"0.##"];
    
    return [fmt stringFromNumber:value];
}

- (NSString*)getFormattedDate:(NSDate*)date {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a, EEEE d"];
    
    return [NSString stringWithFormat:@"%@th", [dateFormatter stringFromDate:date] ];
}
@end
