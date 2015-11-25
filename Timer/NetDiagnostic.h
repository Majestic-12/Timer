//
//  NetDiagnostic.h
//  MPactClient
//
//  Created by Dan Park on 10/1/15.
//  Copyright (c) 2015 Motorola Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NetDiagnostic : NSObject

+ (NSString *)stringForProximity:(CLProximity)proximity;
+ (NSString *)regionByMajorMinor:(NSNumber *)major Minor:(NSNumber *)minor;
+ (NSString *)stringForRegionState:(CLRegionState)regionState;

+ (void)inspectString:(NSString*)functionName
              class:(Class)aClass
             string:(NSString*)string
              error:(NSError*)error;

+ (void)inspectResponse:(NSString*)functionName
                  class:(Class)aClass
               response:(NSURLResponse*)response
                  error:(NSError*)error;

+ (void)inspectData:(NSString*)functionName
              class:(Class)aClass
               data:(NSData*)data
              error:(NSError*)error;

+ (void)inspectData:(NSString*)functionName
               data:(NSData*)data;
+ (void)inspectString:(NSString*)functionName
               string:(NSString*)string;


+ (NSTimeInterval)timeIntervalSinceReferenceDate:(NSString*)functionName;
+ (NSTimeInterval)timeIntervalSince1970:(NSString*)functionName;

@end
