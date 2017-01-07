//
//  FactorTests.m
//  Euler
//
//  Created by Bob Carson on 10/2/16.
//
//

#import "FactorTests.h"
#import "Factor.h"

@implementation FactorTests

+ (void)test {
    Factor *factor = [[Factor alloc] initWithPrime:2 power:5];
    Factor *differentFactor = [[Factor alloc] initWithPrime:3 power:2];
    Factor *sameFactor = [[Factor alloc] initWithPrime:2 power:5];

    NSAssert(![factor isEqual:@"Hello"], @"is not equal to other types");
    NSAssert([factor isEqual:factor], @"is equal to itself");
    NSAssert(![factor isEqual:differentFactor], @"is not equal");
    NSAssert([factor isEqual:sameFactor], @"is equal");

    NSLog(@"%s tests passed", __FILE__);
}

@end
