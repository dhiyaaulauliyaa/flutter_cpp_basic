#import "FileInfoWrapper.h"
#include "cpp/file_info.h"

using namespace std;

@implementation FileInfoWrapper

+ (NSDictionary *)analyzeFileAtPath:(NSString *)path {
    string cppPath([path UTF8String]);
    FileMetadata meta = FileInfo::analyzeFile([path UTF8String]);

    return @{
        @"size": @(meta.size),
        @"inode": @(meta.inode),
        @"atime": @(meta.atime),
        @"mtime": @(meta.mtime),
        @"ctime": @(meta.ctime)
    };
}

@end
