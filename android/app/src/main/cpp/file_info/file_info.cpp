#include "file_info.h"

#include <jni.h>
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

// Global data transformer instance
static FileInfo fileInfo;

// JNI functions to expose to Java/Kotlin
extern "C" {

JNIEXPORT jstring JNICALL
Java_com_example_flutter_1cpp_1basic_FileInfoWrapper_analyzeFile(JNIEnv *env,
                                                                 jobject thiz,
                                                                 jstring path) {
  /* Get Path */
  const char *nativePath = env->GetStringUTFChars(path, 0);
  string input(nativePath);

  /* Get Result */
  FileMetadata result = fileInfo.analyzeFile(nativePath);
  env->ReleaseStringUTFChars(path, nativePath);

  /* Return Result as JSON */
  string jsonResult = "{"
                      "\"size\":" +
                      std::to_string(result.size) +
                      ","
                      "\"inode\":" +
                      std::to_string(result.inode) +
                      ","
                      "\"atime\":" +
                      std::to_string(result.atime) +
                      ","
                      "\"mtime\":" +
                      std::to_string(result.mtime) +
                      ","
                      "\"ctime\":" +
                      std::to_string(result.ctime) + "}";

  return env->NewStringUTF(jsonResult.c_str());
}
}