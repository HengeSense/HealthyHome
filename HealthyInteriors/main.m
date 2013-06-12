//
//  main.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <PXEngine/PXEngine.h>

int main(int argc, char *argv[]) {
    @autoreleasepool {

        [PXEngine licenseKey:@"GIGC3-GUAQC-9CLAA-A8P4H-M4IJD-M1E2O-UGB3U-MES1H-71TUC-O20HI-7LIPO-8D9JD-4VEIG-B5BN2-9V581-5M" forUser:@"mark@markoflynn.com"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([HIAppDelegate class]));

    }
}
