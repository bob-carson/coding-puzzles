//
//  PrimeTests.m
//  Euler
//
//  Created by Bob Carson on 10/1/16.
//
//

#import "PrimeTests.h"
#import "Prime.h"

@implementation PrimeTests

+(void) test {
    int max = 100;
    Prime *prime = [[Prime alloc] initWithMax:max];

    [self assert:[prime isPrime:2]];
    [self assert:[prime isPrime:3]];
    [self assert:![prime isPrime:4]];
    [self assert:[prime isPrime:5]];
    [self assert:![prime isPrime:6]];
    [self assert:[prime isPrime:13]];
    [self assert:[prime isPrime:17]];
    [self assert:![prime isPrime:18]];

    NSLog(@"%s tests passed", __FILE__);
}

+(void) assert:(BOOL) condition {
    NSAssert(condition, @"passes tests");
}

@end
