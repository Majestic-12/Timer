//
//  LocationManager.m
//  DriveSDK
//
//  Created by Dan Park on 11/17/15.
//  Copyright © 2015 Dan Park. All rights reserved.
//

#import "NetDiagnostic.h"
#import "LocationManager.h"

@interface LocationManager () <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}
@end

@implementation LocationManager

-(id)init {
    if ((self = [super init])) {
    }
    return self;
}

-(void)start{
    NSString * const kMPactRegionPrefix = @"MPact-";
    NSString * const kDefaultMPactUUID = @"FE913213-B311-4A42-8C16-47FAEAC938DB";
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:kDefaultMPactUUID];
    
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc]
                                    initWithProximityUUID:uuid
                                    identifier:[NSString stringWithFormat:@"%@%@", kMPactRegionPrefix, [uuid UUIDString]]];
    beaconRegion.notifyEntryStateOnDisplay = YES;
    beaconRegion.notifyOnEntry = YES;
    beaconRegion.notifyOnExit = YES;
    
    
    if (! locationManager) {
        locationManager = [CLLocationManager new];
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
        if ([CLLocationManager locationServicesEnabled]) {
        }
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
        
        [locationManager stopRangingBeaconsInRegion:beaconRegion];
        [locationManager stopMonitoringForRegion:beaconRegion];
//        [locationManager stopMonitoringVisits];
        
        [locationManager requestStateForRegion:beaconRegion];
        [locationManager startRangingBeaconsInRegion:beaconRegion];
        [locationManager startMonitoringForRegion:beaconRegion];
//        [locationManager startMonitoringVisits];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    
    NSString *string = [NSString stringWithFormat:@"region:%@, state:%ld", region, (long)state];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:string];
};

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    
//    NSString *string = [NSString stringWithFormat:@"region:%@, beacons:%@", region, beacons];
//    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:string];
}

- (void)locationManager:(CLLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
              withError:(NSError *)error {
    
    NSString *string = [NSString stringWithFormat:@"region:%@", region];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] class:self.class string:string error:error];
}

- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region {
    
    NSString *string = [NSString stringWithFormat:@"region:%@", region];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:string];
}

- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region {
    
    NSString *string = [NSString stringWithFormat:@"region:%@", region];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:string];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    NSString *string = [NSString stringWithFormat:@"manager:%@", manager];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] class:self.class string:string error:error];
}

- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(nullable CLRegion *)region
              withError:(NSError *)error {
    
    NSString *string = [NSString stringWithFormat:@"manager:%@", manager];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] class:self.class string:string error:error];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
 
    NSString *string = [NSString stringWithFormat:@"status:%d", status];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:string];
}

- (void)locationManager:(CLLocationManager *)manager
didStartMonitoringForRegion:(CLRegion *)region {
    
    NSString *string = [NSString stringWithFormat:@"region:%@", region];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:string];
}

- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit {
    
    NSString *string = [NSString stringWithFormat:@"visit:%@", visit];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:string];
}

@end
