#import "DataTransformerWrapper.h"
#include "cpp/data_transformer.h"

@implementation DataTransformerWrapper {
    DataTransformer *dataTransformer;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        dataTransformer = new DataTransformer();
    }
    return self;
}

- (void)dealloc {
    delete dataTransformer;
}

- (NSString *)transformJson:(NSString *)jsonInput {
    std::string input = std::string([jsonInput UTF8String]);
    std::string result = dataTransformer->transformJson(input);
    return [NSString stringWithUTF8String:result.c_str()];
}

- (NSString *)analyzeText:(NSString *)textInput {
    std::string input = std::string([textInput UTF8String]);
    std::string result = dataTransformer->analyzeText(input);
    return [NSString stringWithUTF8String:result.c_str()];
}

- (NSString *)convertFormat:(NSString *)dataInput fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat {
    std::string data = std::string([dataInput UTF8String]);
    std::string from = std::string([fromFormat UTF8String]);
    std::string to = std::string([toFormat UTF8String]);
    std::string result = dataTransformer->convertFormat(data, from, to);
    return [NSString stringWithUTF8String:result.c_str()];
}

@end