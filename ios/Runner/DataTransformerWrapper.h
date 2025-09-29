#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataTransformerWrapper : NSObject

- (NSString *)transformJson:(NSString *)jsonInput;
- (NSString *)analyzeText:(NSString *)textInput;
- (NSString *)convertFormat:(NSString *)dataInput fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;

@end

NS_ASSUME_NONNULL_END