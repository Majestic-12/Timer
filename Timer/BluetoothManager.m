//
//  BluetoothManager.m
//  DriveSDK
//
//  Created by Dan Park on 11/17/15.
//  Copyright © 2015 Dan Park. All rights reserved.
//

#import "NetDiagnostic.h"
#import "BluetoothManager.h"

@interface BluetoothManager () <CBCentralManagerDelegate> {
    CBCentralManager* centralManager;
}
@end

@implementation BluetoothManager

-(id)init {
    if ((self = [super init])) {
        dispatch_queue_t centralQueue = dispatch_queue_create("com.zebra.BluetoothManager", DISPATCH_QUEUE_SERIAL);
        centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:centralQueue options:nil];
        //        centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:centralQueue options:@{CBCentralManagerOptionShowPowerAlertKey:@NO}];
    }
    return self;
}

-(void)start{
    
    if ([centralManager state] == CBCentralManagerStatePoweredOn) {
        [centralManager stopScan];
        
//        NSDictionary *options = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
        NSArray *services = nil;
        [centralManager scanForPeripheralsWithServices:services
                                               options:nil];
    }
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:@""];
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
    
    NSString *string = [NSString stringWithFormat:@"dict:%@", dict];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:string];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {

    NSString *string = [NSString stringWithFormat:@"RSSI(%@), advertisementData:%@, peripheral:%@", [RSSI stringValue], advertisementData, peripheral];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:string];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {

    NSString *string = [NSString stringWithFormat:@"peripheral:%@", peripheral];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:string];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    
    NSString *string = [NSString stringWithFormat:@"peripheral:%@", peripheral];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] class:self.class string:string error:error];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {

    NSString *string = [NSString stringWithFormat:@"peripheral:%@", peripheral];
    [NetDiagnostic inspectString:[NSString stringWithFormat:@"%s",__FUNCTION__] string:string];
}

@end
