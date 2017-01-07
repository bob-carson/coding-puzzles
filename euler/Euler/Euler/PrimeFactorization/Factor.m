//
//  Factor.m
//  Euler
//
//  Created by Bob Carson on 10/1/16.
//
//

#import "Factor.h"

@interface Factor ()

@property (nonatomic, readwrite) int prime;
@property (nonatomic, readwrite) int power;

@end

@implementation Factor

- (id)initWithPrime:(int)prime power:(int)power {
    if (self = [super init]) {
        self.prime = prime;
        self.power = power;
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (self == other) {
        return YES;
    }

    if (![other isKindOfClass:[Factor class]]) {
        return NO;
    }

    Factor *otherFactor = other;
    return otherFactor.power == self.power && otherFactor.prime == self.prime;
}

- (NSUInteger)hash {
    return self.power * self.prime;
}

@end
