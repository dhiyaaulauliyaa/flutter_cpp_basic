#ifndef FILE_INFO_H
#define FILE_INFO_H

#include <string>

struct FileMetadata {
  long size;  // file size in bytes
  long inode; // inode number (unique within filesystem)
  long atime; // last access time (epoch seconds)
  long mtime; // last modification time
  long ctime; // last status change time
};

class FileInfo {
public:
  static FileMetadata analyzeFile(const std::string &path);
};

#endif // FILE_INFO_H