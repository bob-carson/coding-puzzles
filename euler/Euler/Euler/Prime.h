//
//  Prime.h
//  Euler
//
//  Created by Bob Carson on 10/1/16.
//
//

#import <Foundation/Foundation.h>

@interface Prime : NSObject

@property (nonatomic, readonly) int max;

-(id) initWithMax:(int) max;
-(BOOL) isPrime:(int) n;

@end
