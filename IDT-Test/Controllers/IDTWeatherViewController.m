//
//  IDTWeatherViewController.m
//  IDT-Test
//
//  Created by Mohamed EL Meseery on 11/29/16.
//  Copyright © 2016 Mohamed EL Meseery. All rights reserved.
//

#import "IDTWeatherViewController.h"
#import "IDTWeatherViewModel.h"
#import "IDTWeatherView.h"

static void * WeatherContext = &WeatherContext;

@interface IDTWeatherViewController ()
@property (strong, nonatomic) IDTWeatherViewModel *weatherViewModel;

@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet IDTWeatherView *weatherView;
@end

@implementation IDTWeatherViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weatherViewModel = [[IDTWeatherViewModel alloc]init];
    //KVO
    [self.weatherViewModel addObserver:self forKeyPath:NSStringFromSelector(@selector(weatherDay))
                             options:NSKeyValueObservingOptionNew  context:WeatherContext];
    //Notification center
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:)
                                                 name:kLocationDenied
                                               object:nil];
    self.statusLabel.text = @"Fetching weather...";
    self.weatherView.hidden = YES;
   
}

#pragma mark - Notifications and KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context
{    if (context == WeatherContext) {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(weatherDay))]) {
        //KVO notification need not be in main thread, so switch to the UI thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.statusLabel.hidden = YES;
            self.weatherView.hidden = NO;
            [self.weatherView setWeatherConditionNow:self.weatherViewModel.weatherDay];
            [self.weatherView SetCurrentPlaceName:self.weatherViewModel.currentPlace];
        });
    }
}
}
- (void)receivedNotification:(NSNotification *) notification{
    //Notification center notifications are delivered on the same thread, where they are send
    //Here the sender ensures main thread, so no context switching required
    if ([[notification name] isEqualToString:kLocationDenied]) {
        
        self.statusLabel.text = @"Please enable location service";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
