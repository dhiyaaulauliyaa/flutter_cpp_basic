import 'dart:io';

import 'package:flutter/material.dart';

class SelectFileCard extends StatelessWidget {
  const SelectFileCard({
    super.key,
    required this.selectedFile,
    required this.isLoading,
    required this.onPressed,
  });

  final File? selectedFile;
  final bool isLoading;
  final VoidCallback onPressed;

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
              'Select a file to analyze',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              selectedFile != null
                  ? 'Selected: ${selectedFile!.path.split('/').last}'
                  : 'No file selected',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : onPressed,
                icon: const Icon(Icons.file_open),
                label: const Text('Choose File'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
