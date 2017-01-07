//
//  FactorSet.h
//  Euler
//
//  Created by Bob Carson on 10/1/16.
//
//

#import <Foundation/Foundation.h>

@class Factor;

@interface FactorSet : NSObject

@property (nonatomic, copy, readonly) NSSet<Factor *> *factors;

- (id)initWithFactors:(NSSet<Factor *> *)factors;

@end
