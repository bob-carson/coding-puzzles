//
//  FactorSet.m
//  Euler
//
//  Created by Bob Carson on 10/1/16.
//
//

#import "FactorSet.h"

@interface FactorSet ()

@property (nonatomic, copy, readwrite) NSSet<Factor *> *factors;

@end

@implementation FactorSet

- (id)initWithFactors:(NSSet<Factor *> *)factors {
    if (self = [super init]) {
        self.factors = factors;
    }
    return self;
}

- (id)initWithFactorSet:(FactorSet *)factorSet incrementingPrime:(int)prime {
    if (self = [super init]) {
        NSMutableSet<Factor *> *factors = [NSMutableSet setWithSet:factorSet.factors];

        BOOL haveIncremented = NO;
        for (factors in factors) {

        }
    }
    return self;
}

@end
