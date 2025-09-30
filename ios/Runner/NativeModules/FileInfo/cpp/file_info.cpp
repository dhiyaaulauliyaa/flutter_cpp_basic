#include "file_info.h"
#include <sys/stat.h>

using namespace std;

FileMetadata FileInfo::analyzeFile(const string &path) {
  // Instantiate metadata object
  FileMetadata meta{0, 0, 0, 0, 0};

  // Get file info from stat
  struct stat file_stat;
  if (stat(path.c_str(), &file_stat) != 0) {
    return meta;
  }

  meta.size = file_stat.st_size;
  meta.inode = file_stat.st_ino;
  meta.atime = file_stat.st_atime;
  meta.mtime = file_stat.st_mtime;
  meta.ctime = file_stat.st_ctime;

  return meta;
}