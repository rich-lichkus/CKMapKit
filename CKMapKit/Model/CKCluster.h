//
//  CKCluster.h
//  CKMapKit
//
//  Created by Richard Lichkus on 8/19/14.
//  Copyright (c) 2014 Richard Lichkus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CKMapPin.h"

@interface CKCluster : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) CLLocation *centroid;
@property (strong, nonatomic) NSMutableArray *locations;

-(instancetype)initWithCLLocation:(CLLocation*)location;

@end
