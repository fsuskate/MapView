//
//  ViewController.h
//  MapView
//
//  Created by Francisco Surroca on 11/17/13.
//  Copyright (c) 2013 Francisco Surroca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    MKMapView *mapView;
    ADBannerView *banner;
}

@property (nonatomic,assign) BOOL bannerIsVisible;
@property (nonatomic,retain) IBOutlet ADBannerView *banner;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
-(IBAction)setMap:(id)sender;
-(IBAction)getLocation;
-(IBAction)go;

@end
