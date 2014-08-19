//
//  CKCluster.m
//  CKMapKit
//
//  Created by Richard Lichkus on 8/19/14.
//  Copyright (c) 2014 Richard Lichkus. All rights reserved.
//

#import "CKCluster.h"

@interface CKCluster()

@end

@implementation CKCluster

#pragma mark - Instantiation

-(instancetype)initWithCLLocation:(CLLocation *)location{
    self = [super init];
    if (self) {
        self.centroid = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
        [self.locations addObject:location];
    }
    return self;
}

-(NSMutableArray*)locations{
    if(!_locations){
        _locations = [[NSMutableArray alloc] init];
    }
    return _locations;
}


@end
