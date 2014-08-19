//
//  CKClusterPins.h
//  CKMapKit
//
//  Created by Richard Lichkus on 8/19/14.
//  Copyright (c) 2014 Richard Lichkus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKCluster.h"


@interface CKClusterPins : NSObject

@property (strong, nonatomic) NSMutableArray *clusters;
@property (strong, nonatomic) NSMutableArray *allLocations;
@property (nonatomic) NSInteger distance;

-(instancetype)initWithCLLocations: (NSMutableArray*)locations andProximityDistance:(NSInteger)distance;

-(NSMutableArray*)getClustersWithDistance:(NSInteger)distance;

@end
