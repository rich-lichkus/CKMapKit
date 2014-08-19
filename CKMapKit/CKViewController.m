//
//  CKViewController.m
//  CKMapKit
//
//  Created by Richard Lichkus on 8/15/14.
//  Copyright (c) 2014 Richard Lichkus. All rights reserved.
//

#import "CKViewController.h"
#import <MapKit/MapKit.h>
#import "CKMapPin.h"
#import "CKCluster.h"
#import "CKClusterPins.h"

@interface CKViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@property (strong, nonatomic) NSMutableArray *downtownLocations;
@property (strong, nonatomic) CKClusterPins *clusteredPins;

@end

@implementation CKViewController

#pragma mark - View

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    [self.mapView.userLocation addObserver:self
                                forKeyPath:@"location"
                                   options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                                   context:nil];

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
    
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:pin1.latitude longitude:pin1.longitude];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:pin2.latitude longitude:pin2.longitude];
    CLLocation *location3 = [[CLLocation alloc] initWithLatitude:pin3.latitude longitude:pin3.longitude];
    CLLocation *location4 = [[CLLocation alloc] initWithLatitude:pin4.latitude longitude:pin4.longitude];
    CLLocation *location5 = [[CLLocation alloc] initWithLatitude:pin5.latitude longitude:pin5.longitude];
    CLLocation *location6 = [[CLLocation alloc] initWithLatitude:pin6.latitude longitude:pin6.longitude];
    CLLocation *location7 = [[CLLocation alloc] initWithLatitude:pin7.latitude longitude:pin7.longitude];
    CLLocation *location8 = [[CLLocation alloc] initWithLatitude:pin8.latitude longitude:pin8.longitude];
    CLLocation *location9 = [[CLLocation alloc] initWithLatitude:pin9.latitude longitude:pin9.longitude];
    CLLocation *location10 = [[CLLocation alloc] initWithLatitude:pin10.latitude longitude:pin10.longitude];
    
    self.downtownLocations = [[NSMutableArray alloc] initWithObjects:location1, location2, location3, location4, location5,
                                         location6, location7, location8, location9, location10, nil];
    
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
    
    for(int i=0; i<10; i++)
    {
        CKMapPin *aPin = [[CKMapPin alloc]initWithCoordinate:points[i] withPinType:kReadable withTitle:[NSString stringWithFormat:@"Pin %i", i]];
        [self.mapView addAnnotation: aPin];
        [self.mapView addOverlay:[MKCircle circleWithCenterCoordinate:points[i] radius:100]];
    }
    
    
    
//    // Central Business District
//    NSMutableArray *downtownLocations = [[NSMutableArray alloc] initWithObjects:location1, location2, location3, location4, location5,
//                                                                                location6, location7, location8, location9, location10, nil];
//    
//    CKClusterPins *clusteredPins = [[CKClusterPins alloc]initWithCLLocations:downtownLocations andProximityDistance:500];
//    
//    NSMutableArray *clusters = [clusteredPins getClusters];
//    
//    for (CKCluster *cluster in clusters){
//        CLLocationCoordinate2D aCoordinate = ((CKCluster*)cluster).centroid.coordinate;
//        [self.mapView addAnnotation:[[CKMapPin alloc]initWithCoordinate:aCoordinate withPinType:kVisible withTitle:@"centriod"]];
//        [self.mapView addOverlay:[MKCircle circleWithCenterCoordinate:aCoordinate radius:150]];
//        NSLog(@"New centroid: %f, %f", aCoordinate.latitude, aCoordinate.longitude);
//    }
}

#pragma mark - Delegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if([annotation isKindOfClass:CKMapPin.class]){
        MKPinAnnotationView *pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
        if(pin == nil){
            pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
        } else {
            pin.annotation = annotation;
        }
        if ([((CKMapPin*)annotation).title isEqualToString:@"centroid"]) {
            pin.pinColor = MKPinAnnotationColorGreen;
        } else {
            pin.pinColor = MKPinAnnotationColorRed;
        }
        pin.canShowCallout = YES;
        return pin;
    }
    return nil;
}

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
    } else if ([overlay isKindOfClass:[MKCircle class]]){
        MKCircle *currentCircle = (MKCircle*)overlay;
        MKCircleRenderer *circleRender = [[MKCircleRenderer alloc]initWithCircle:currentCircle];
        circleRender.fillColor = [[UIColor redColor] colorWithAlphaComponent:.2];
        return circleRender;
    }
    return nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    MKCoordinateRegion region;
//    region.center = self.mapView.userLocation.coordinate;
//    
//    MKCoordinateSpan span;
//    span.latitudeDelta  = .03;
//    span.longitudeDelta = .03;
//    region.span = span;
//    
//    if(region.center.longitude == -180.00000000){
//        NSLog(@"Invalid region!");
//    }else{
//        [self.mapView setRegion:region animated:YES];
//    }
}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    NSLog(@"will %f, %f",mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"did %f, %f",mapView.region.span.latitudeDelta , mapView.region.span.longitudeDelta);
    NSLog(@"did %f, %f",mapView.region.span.latitudeDelta*12000, mapView.region.span.longitudeDelta*1200);
    
    // Central Business District
    self.clusteredPins = [[CKClusterPins alloc]initWithCLLocations:self.downtownLocations andProximityDistance:500];
    
    NSMutableArray *clusters = [self.clusteredPins getClustersWithDistance:mapView.region.span.latitudeDelta*12000];
    
    for(CKMapPin* annotation in self.mapView.annotations){
        if([annotation isKindOfClass:CKMapPin.class]){
            if ([annotation.title isEqualToString:@"centroid"]) {
                [self.mapView removeAnnotation:annotation];
            }
        }
    }
    
    for (CKCluster *cluster in clusters){
        CLLocationCoordinate2D aCoordinate = ((CKCluster*)cluster).centroid.coordinate;
        [self.mapView addAnnotation:[[CKMapPin alloc]initWithCoordinate:aCoordinate withPinType:kVisible withTitle:@"centroid"]];
//        [self.mapView addOverlay:[MKCircle circleWithCenterCoordinate:aCoordinate radius:150]];
        NSLog(@"New centroid: %f, %f", aCoordinate.latitude, aCoordinate.longitude);
    }
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
