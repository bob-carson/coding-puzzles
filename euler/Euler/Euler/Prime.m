//
//  Prime.m
//  Euler
//
//  Created by Bob Carson on 10/1/16.
//
//

#import "Prime.h"

@interface Prime ()

@property (nonatomic, readwrite) int max;
@property (nonatomic, readwrite) NSMutableArray<NSNumber *> *isPrime;

@end

@implementation Prime

-(id) initWithMax:(int) max {
    if (self = [super init]) {
        self.max = max;
        self.isPrime = [NSMutableArray arrayWithCapacity: max + 1];

        [self initializeArray];
        [self markNonPrimes];
    }
    return self;
}

-(BOOL) isPrime:(int) n {
    NSAssert(n > 1, @"%s can only be called on numbers greater than 1", __FUNCTION__);
    NSAssert(n <= self.max, @"%s can only be called on numbers less than max", __FUNCTION__);
    return [self.isPrime[n] boolValue];
}

//MARK: - private

-(void) initializeArray {
    for (int i = 0; i <= self.max; i++) {
        BOOL prime = YES;

        [self.isPrime addObject: [NSNumber numberWithBool: prime]];
    }
}

-(void) markNonPrimes {
    for (int i = 2; i <= sqrt(self.max); i++) {
        if ([self isPrime: i]) {
            [self markMutliples:i];
        }
    }
}

-(void) markMutliples:(int) n {
    for (int i = n * n; i <= self.max; i += n) {
        [self setNotPrime:i];
    }
}

-(void) setNotPrime:(int) n {
    self.isPrime[n] = [NSNumber numberWithBool:NO];
}

@end
