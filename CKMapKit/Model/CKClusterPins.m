//
//  CKClusterPins.m
//  CKMapKit
//
//  Created by Richard Lichkus on 8/19/14.
//  Copyright (c) 2014 Richard Lichkus. All rights reserved.
//

#import "CKClusterPins.h"
@class CKCluster;

@interface CKClusterPins()

@property (strong, nonatomic) NSMutableArray *unclusteredLocations;

@end

@implementation CKClusterPins

#pragma mark - Instantiation

-(instancetype)initWithCLLocations:(NSMutableArray *)locations andProximityDistance:(NSInteger)distance{
    self = [super init];
    if (self) {
        self.allLocations = [locations mutableCopy];
        self.unclusteredLocations = [locations mutableCopy];
        self.distance = distance;
        [self.clusters addObject:[[CKCluster alloc] initWithCLLocation:self.unclusteredLocations[0]]];
    }
    
    return self;
}

-(NSMutableArray*)getClustersWithDistance:(NSInteger)distance{
    
    self.unclusteredLocations = self.allLocations;
    self.distance = distance;
    
    while (self.unclusteredLocations.count >0)
    {
        [self processClusters];
    }
    
    return _clusters;
}


-(void)processClusters{

    NSInteger refLocation = 0;
    NSMutableIndexSet *removeIndicies = [[NSMutableIndexSet alloc]initWithIndex:0];
    
    for (int i = 0; i <self.unclusteredLocations.count; i++) {
        
        if(i != refLocation){
            CLLocation *location1 = self.unclusteredLocations[refLocation];
            CLLocation *location2 = self.unclusteredLocations[i];
            CLLocationDistance distance = [location1 distanceFromLocation:location2];
            NSLog(@"pin %li -> pin %i distance %f",(long)refLocation, i, distance);
            
            if(distance <self.distance){
                
                CKCluster *cluster = [_clusters lastObject];
                CLLocation *centroidLocation = cluster.centroid;
                float centroidLat   = centroidLocation.coordinate.latitude;
                float centroidLong  = centroidLocation.coordinate.longitude;
                
                cluster.centroid = [[CLLocation alloc] initWithLatitude:(centroidLat + location2.coordinate.latitude)*.5f
                                                              longitude:(centroidLong + location2.coordinate.longitude)*.5f];
                [cluster.locations addObject:location2];
                
                [removeIndicies addIndex:i];
                
                NSLog(@"Removing pin %i", i);
                
                NSLog(@"New centroid: %f, %f", ((CKCluster*)[_clusters lastObject]).centroid.coordinate.latitude, ((CKCluster*)[_clusters lastObject]).centroid.coordinate.longitude);
            }
        }
    }
    
    NSLog(@"!!!");
    [self.unclusteredLocations removeObjectsAtIndexes:removeIndicies];
    NSLog(@"!!!");
    if(self.unclusteredLocations.count != 0){
        CLLocation *loc = self.unclusteredLocations[0];
        [self.clusters addObject:[[CKCluster alloc]initWithCLLocation:loc]];
    }
    NSLog(@"%lu", (unsigned long)self.unclusteredLocations.count );
}

#pragma mark - Lazy

-(NSMutableArray*)clusters{
    if(!_clusters){
        _clusters = [[NSMutableArray alloc]init];
    } 
    return _clusters;
}
         
-(NSMutableArray*)allLocations{
     if(!_allLocations){
         _allLocations = [[NSMutableArray alloc]init];
     }
     return _allLocations;
 }

-(NSMutableArray*)unclusteredLocations{
    if(!_unclusteredLocations){
        _unclusteredLocations = [[NSMutableArray alloc]init];
    }
    return _unclusteredLocations;
}

@end

