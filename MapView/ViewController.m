//
//  ViewController.m
//  MapView
//
//  Created by Francisco Surroca on 11/17/13.
//  Copyright (c) 2013 Francisco Surroca. All rights reserved.
//

#import "ViewController.h"
#import "NewClass.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mapView;
@synthesize banner, bannerIsVisible;

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if(self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animatedAdBannerOn" context:nil];
        banner.frame = CGRectOffset(banner.frame, 0.0, 50.0);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if(self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animatedAdBannerOff" context:nil];
        banner.frame = CGRectOffset(banner.frame, 0.0, -320.0);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }

}

-(void)go
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.addressTextField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        MKCoordinateRegion region;
        region.center.latitude = placemark.region.center.latitude;
        region.center.longitude = placemark.region.center.longitude;
        MKCoordinateSpan span;
        double radius = placemark.region.radius / 1000; // convert to km
        
        NSLog(@"[searchBarSearchButtonClicked] Radius is %f", radius);
        span.latitudeDelta = radius / 112.0;
        
        region.span = span;
        
        [mapView setRegion:region animated:YES];
    }];
    
}

-(IBAction)getLocation
{
    mapView.showsUserLocation = YES;
}

-(IBAction)setMap:(id)sender
{
    switch (((UISegmentedControl *) sender).selectedSegmentIndex)
    {
        case  0:
            mapView.mapType = MKMapTypeStandard;
            break;
        case  1:
            mapView.mapType = MKMapTypeSatellite;
            break;
        case  2:
            mapView.mapType = MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)addressTextField
{
    NSLog(@"You entered %@",self.addressTextField.text);
    [self.addressTextField resignFirstResponder];
    [self go];
    return YES;
}

- (void)viewDidLoad
{
    self.addressTextField.delegate = self;
    
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    
    MKCoordinateRegion region = {{0.0, 0.0}, {0.0, 0.0}};
    region.center.latitude = 48.862908;
    region.center.longitude = 2.351021;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    
    [mapView setRegion:region animated:YES];
    
    NewClass *ann = [[NewClass alloc] init];
    ann.title = @"Paris, France";
    ann.subtitle = @"J'aime Paris beacoup!";
    ann.coordinate = region.center;
    [mapView addAnnotation:ann];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
