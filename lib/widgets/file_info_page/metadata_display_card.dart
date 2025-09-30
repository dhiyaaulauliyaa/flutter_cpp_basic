import 'package:flutter/material.dart';
import 'package:flutter_cpp_basic/models/file_metadata.dart';

class MetadataDisplayCard extends StatelessWidget {
  const MetadataDisplayCard({super.key, required this.fileMetadata});

  final FileMetadata fileMetadata;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'File Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _MetadataRow(
              label: 'Size',
              value: _formatFileSize(fileMetadata.size.toDouble()),
            ),
            _MetadataRow(
              label: 'Index Node',
              value: fileMetadata.indexNode.toString(),
            ),
            _MetadataRow(
              label: 'Last Access Time',
              value: _formatTimestamp(fileMetadata.lastAccessTime),
            ),
            _MetadataRow(
              label: 'Last Modified Time',
              value: _formatTimestamp(fileMetadata.lastModifiedTime),
            ),
            _MetadataRow(
              label: 'Last Status Change Time',
              value: _formatTimestamp(fileMetadata.lastStatusChangeTime),
            ),
          ],
        ),
      ),
    );
  }

  String _formatFileSize(double bytes, [int unitIndex = 0]) {
    const units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];

    if (bytes < 1024 || unitIndex == units.length - 1) {
      return '${bytes.toStringAsFixed(1)} ${units[unitIndex]}';
    }

    return _formatFileSize(bytes / 1024, unitIndex + 1);
  }

  String _formatTimestamp(int secondsSinceEpoch) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      secondsSinceEpoch * 1000,
    );
    return dateTime.toString();
  }
}

class _MetadataRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetadataRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }
}
