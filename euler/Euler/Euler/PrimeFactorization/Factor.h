//
//  Factor.h
//  Euler
//
//  Created by Bob Carson on 10/1/16.
//
//

#import <Foundation/Foundation.h>

@interface Factor : NSObject

@property (nonatomic, readonly) int prime;
@property (nonatomic, readonly) int power;

- (id)initWithPrime:(int)prime power:(int)power;

@end
