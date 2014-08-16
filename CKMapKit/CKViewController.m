//
//  CKViewController.m
//  CKMapKit
//
//  Created by Richard Lichkus on 8/15/14.
//  Copyright (c) 2014 Richard Lichkus. All rights reserved.
//

#import "CKViewController.h"
#import <MapKit/MapKit.h>

@interface CKViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@end

@implementation CKViewController

#pragma mark - View

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    // Boundary Pin
    // - CLLocationCoordinate2D
    // - Cross Streets Address
    // - Pin id
    // - (maybe) boundaries that are using the pin
    
    CLLocationCoordinate2D pin1 = CLLocationCoordinate2DMake(47.611114, -122.340410);
    CLLocationCoordinate2D pin2 = CLLocationCoordinate2DMake(47.612368, -122.338490);
    CLLocationCoordinate2D pin3 = CLLocationCoordinate2DMake(47.616098, -122.329576);
    CLLocationCoordinate2D pin4 = CLLocationCoordinate2DMake(47.609817, -122.331651);
    CLLocationCoordinate2D pin5= CLLocationCoordinate2DMake(47.605528, -122.327571);
    CLLocationCoordinate2D pin6 = CLLocationCoordinate2DMake(47.602752, -122.334260);
    CLLocationCoordinate2D pin7 = CLLocationCoordinate2DMake(47.603452, -122.334984);
    CLLocationCoordinate2D pin8 = CLLocationCoordinate2DMake(47.602467, -122.336901);
    CLLocationCoordinate2D pin9 = CLLocationCoordinate2DMake(47.607033, -122.341099);
    CLLocationCoordinate2D pin10 = CLLocationCoordinate2DMake(47.608529, -122.338008);
    CLLocationCoordinate2D pin11 = CLLocationCoordinate2DMake(47.612664, -122.343113);
    CLLocationCoordinate2D pin12 = CLLocationCoordinate2DMake(47.609974, -122.346252);
    CLLocationCoordinate2D pin13 = CLLocationCoordinate2DMake(47.618494, -122.328968);
    CLLocationCoordinate2D pin14 = CLLocationCoordinate2DMake(47.618595, -122.358472);
    
    // Central Business District
    CLLocationCoordinate2D  points[10];
    points[0] = pin1;
    points[1] = pin2;
    points[2] = pin3;
    points[3] = pin4;
    points[4] = pin5;
    points[5] = pin6;
    points[6] = pin7;
    points[7] = pin8;
    points[8] = pin9;
    points[9] = pin10;
    
    MKPolygon* poly = [MKPolygon polygonWithCoordinates:points count:10];
    poly.title = @"Central Business District";
    [self.mapView addOverlay:poly];
    
    // Pike Market
    CLLocationCoordinate2D pikePoints[5];
    pikePoints[0] = pin9;
    pikePoints[1] = pin10;
    pikePoints[2] = pin1;
    pikePoints[3] = pin11;
    pikePoints[4] = pin12;

    MKPolygon *pikePoly = [MKPolygon polygonWithCoordinates:pikePoints count:5];
    pikePoly.title = @"Pike Market";
    [self.mapView addOverlay:pikePoly];
    
    // Belltown
    CLLocationCoordinate2D bellPoints[7];
    bellPoints[0] = pin1;
    bellPoints[1] = pin2;
    bellPoints[2] = pin3;
    bellPoints[3] = pin13;
    bellPoints[4] = pin14;
    bellPoints[5] = pin12;
    bellPoints[6] = pin11;
    
    MKPolygon *bellPoly = [MKPolygon polygonWithCoordinates:bellPoints count:7];
    bellPoly.title = @"Belltown";
    [self.mapView addOverlay:bellPoly];
    
}

#pragma mark - Delegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        MKPolygon *currentPoly = (MKPolygon*)overlay;
        
        MKPolygonRenderer*    aRenderer = [[MKPolygonRenderer alloc] initWithPolygon:currentPoly];
        if([currentPoly.title isEqualToString:@"Central Business District"]){
            aRenderer.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        } else if ([currentPoly.title isEqualToString:@"Belltown"]){
            aRenderer.fillColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
        } else {
            aRenderer.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        }
        aRenderer.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        aRenderer.lineWidth = 3;
        
        return aRenderer;
    }
    
    return nil;
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
