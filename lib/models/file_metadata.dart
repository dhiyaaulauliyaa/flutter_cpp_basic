/// Represents the metadata of a file, parsed from a platform channel response.
class FileMetadata {
  /// Creates an immutable [FileMetadata] instance.
  const FileMetadata({
    required this.size,
    required this.indexNode,
    required this.lastAccessTime,
    required this.lastModifiedTime,
    required this.lastStatusChangeTime,
  });

  /// File size in bytes.
  final int size;

  /// Inode number (unique within a filesystem).
  /// The Dart field is `indexNode` but the JSON key is 'inode'.
  final int indexNode;

  /// Last access time (seconds since epoch).
  /// The Dart field is `lastAccessTime` but the JSON key is 'atime'.
  final int lastAccessTime;

  /// Last modification time (seconds since epoch).
  /// The Dart field is `lastModifiedTime` but the JSON key is 'mtime'.
  final int lastModifiedTime;

  /// Last status change time (seconds since epoch).
  /// The Dart field is `lastStatusChangeTime` but the JSON key is 'ctime'.
  final int lastStatusChangeTime;

  /// Creates a [FileMetadata] instance from a JSON map.
  ///
  /// This factory maps the abbreviated JSON keys from the native platform
  /// to the more descriptive Dart field names.
  factory FileMetadata.fromJson(Map<String, dynamic> json) {
    return FileMetadata(
      size: json['size'] as int,
      indexNode: json['inode'] as int,
      lastAccessTime: json['atime'] as int,
      lastModifiedTime: json['mtime'] as int,
      lastStatusChangeTime: json['ctime'] as int,
    );
  }

  /// Converts the [FileMetadata] instance to a JSON map.
  ///
  /// This method serializes the data back to the standard abbreviated keys,
  /// ensuring compatibility with the native platform and external systems.
  Map<String, dynamic> toJson() => {
    'size': size,
    'inode': indexNode,
    'atime': lastAccessTime,
    'mtime': lastModifiedTime,
    'ctime': lastStatusChangeTime,
  };

  @override
  String toString() =>
      'FileMetadata('
      'size: $size, '
      'indexNode: $indexNode, '
      'lastAccessTime: $lastAccessTime, '
      'lastModifiedTime: $lastModifiedTime, '
      'lastStatusChangeTime: $lastStatusChangeTime'
      ')';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileMetadata &&
          runtimeType == other.runtimeType &&
          size == other.size &&
          indexNode == other.indexNode &&
          lastAccessTime == other.lastAccessTime &&
          lastModifiedTime == other.lastModifiedTime &&
          lastStatusChangeTime == other.lastStatusChangeTime;

  @override
  int get hashCode => Object.hash(
    size,
    indexNode,
    lastAccessTime,
    lastModifiedTime,
    lastStatusChangeTime,
  );
}
