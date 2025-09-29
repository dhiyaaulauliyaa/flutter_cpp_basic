#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CounterWrapper : NSObject

- (int)getValue;
- (void)increment;
- (void)decrement;
- (void)reset;

@end

NS_ASSUME_NONNULL_END