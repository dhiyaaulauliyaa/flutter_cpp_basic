#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileInfoWrapper : NSObject
+ (NSDictionary *)analyzeFileAtPath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
