//
//  NetDiagnostic.m
//  MPactClient
//
//  Created by Dan Park on 10/1/15.
//  Copyright (c) 2015 Motorola Solutions. All rights reserved.
//

#import "NetDiagnostic.h"

@implementation NetDiagnostic

+ (NSString *)regionByMajorMinor:(NSNumber *)major Minor:(NSNumber *)minor {
    
    NSString *region;
    if ((major != nil) && (minor != nil)) {
        region = [NSString stringWithFormat:@"%@-%@", major, minor];
    } else if (major != nil) {
        region = [major stringValue];
    } else {
        region = @"Site-wide";
    }
    return region;
}

+ (NSString *)stringForProximity:(CLProximity)proximity{
    NSString * string = nil;
    
    switch (proximity) {
        case CLProximityImmediate:
            string = @"CLProximityImmediate";
            break;
            
        case CLProximityFar:
            string = @"CLProximityFar";
            break;
            
        case CLProximityNear:
            string = @"CLProximityNear";
            break;
            
        default:
            string = @"CLProximity Unassigned";
            break;
    }
    
    return string;
}

+ (NSString *)stringForRegionState:(CLRegionState)regionState{
    
    NSString *string = @"";
    switch (regionState) {
        case CLRegionStateInside:
            string = @"CLRegionStateInside";
            break;
            
        case CLRegionStateOutside:
            string = @"CLRegionStateOutside";
            break;
            
        case CLRegionStateUnknown:
            string = @"CLRegionStateUnknown";
            break;
        default:
            string = @"Unassigned";
            break;
    }
    return string;
}

+ (void)inspectResponse:(NSString*)functionName
                  class:(Class)aClass
               response:(NSURLResponse*)response
                  error:(NSError*)error
{
    if (1) {
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *responseHTTPURL = (NSHTTPURLResponse *) response;
            NSString *localizedStringForStatusCode = [NSHTTPURLResponse localizedStringForStatusCode:[responseHTTPURL statusCode]];
            NSLog(@"[%@ %@]: statusCode:%@, localizedStringForStatusCode:%@", NSStringFromClass(aClass), functionName, @([responseHTTPURL statusCode]), localizedStringForStatusCode);
            NSLog(@"[%@ %@]: allHeaderFields:%@", NSStringFromClass(aClass), functionName, [responseHTTPURL allHeaderFields]);
        } else {
            NSLog(@"[%@ %@]: URL:%@", NSStringFromClass(aClass), functionName, [response URL]);
        }
    }
    
    if (error) {
        NSLog(@"[%@ %@]: error:%@", NSStringFromClass(aClass), functionName, error);
    }
}

+ (void)inspectData:(NSString*)functionName
              class:(Class)aClass
               data:(NSData*)data
              error:(NSError*)error
{
    if (1) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"[%@ %@]: data:%@", NSStringFromClass(aClass), functionName, string);
    }
    if (error) {
        NSLog(@"[%@ %@]: error:%@", NSStringFromClass(aClass), functionName, error);
    }
}

+ (void)inspectData:(NSString*)functionName
               data:(NSData*)data {
    if (1) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@: data:%@",functionName,string);
    }
}

+ (void)inspectString:(NSString*)functionName
                class:(Class)aClass
               string:(NSString*)string
                error:(NSError*)error {
    
    if (1) {
        NSLog(@"[%@ %@]: data:%@", NSStringFromClass(aClass), functionName, string);
    }
    
    if (error) {
        NSLog(@"[%@ %@]: error:%@", NSStringFromClass(aClass), functionName, error);
    }
}

+ (void)inspectString:(NSString*)functionName
               string:(NSString*)string {
    if (1) {
        NSLog(@"%@: string:%@",functionName,string);
    }
}

+ (NSTimeInterval)timeIntervalSinceReferenceDate:(NSString*)functionName {
    NSDate *date = [NSDate date];
    NSTimeInterval timeIntervalSinceReferenceDate = [date timeIntervalSinceReferenceDate];
    if (1) {
        NSLog(@"%@", [NSString stringWithFormat:@"functionName:%@ timeIntervalSinceReferenceDate: %f", functionName, timeIntervalSinceReferenceDate]);
    }
    
    return timeIntervalSinceReferenceDate;
}

+ (NSTimeInterval)timeIntervalSince1970:(NSString*)functionName {
    NSDate *date = [NSDate date];
    NSTimeInterval timeIntervalSince1970 = [date timeIntervalSince1970];
    if (1) {
        NSLog(@"%@", [NSString stringWithFormat:@"functionName:%@ timeIntervalSince1970: %f", functionName, timeIntervalSince1970]);
        
    }
    return timeIntervalSince1970;
}


@end
