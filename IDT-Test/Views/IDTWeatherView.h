//
//  IDTWeatherView.h
//  IDT-Test
//
//  Created by Mohamed EL Meseery on 11/30/16.
//  Copyright © 2016 Mohamed EL Meseery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDTWeatherDay.h"
@interface IDTWeatherView : UIView

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;


- (void)setWeatherConditionNow:(IDTWeatherDay*)now;
- (void)SetCurrentPlaceName:(NSString*)name;

@end
