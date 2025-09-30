import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cpp_basic/models/file_metadata.dart';
import 'package:flutter_cpp_basic/plugins/cpp_file_info_plugin.dart';
import 'package:flutter_cpp_basic/widgets/file_info_page/metadata_display_card.dart';
import 'package:flutter_cpp_basic/widgets/file_info_page/select_file_card.dart';
import 'package:file_picker/file_picker.dart';

class FileInfoPage extends StatefulWidget {
  const FileInfoPage({super.key});

  @override
  State<FileInfoPage> createState() => _FileInfoPageState();
}

class _FileInfoPageState extends State<FileInfoPage> {
  File? _file;
  FileMetadata? fileMetadata;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Info Analyzer'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card for file selection
            SelectFileCard(
              selectedFile: _file,
              isLoading: _isLoading,
              onPressed: _chooseFile,
            ),

            const SizedBox(height: 24),

            // Loading indicator
            if (_isLoading) const Center(child: CircularProgressIndicator()),

            // File metadata display
            if (fileMetadata != null && !_isLoading)
              MetadataDisplayCard(fileMetadata: fileMetadata!),
          ],
        ),
      ),
    );
  }

  Future<void> _chooseFile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        setState(() {
          _file = File(result.files.single.path!);
          fileMetadata = null;
        });

        await _getMetadata();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error selecting file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _getMetadata() async {
    if (_file == null) return;

    try {
      final metadata = await CppFileInfoPlugin.analyzeFile(_file!.path);
      setState(() {
        fileMetadata = FileMetadata.fromJson(metadata as Map<String, dynamic>);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error analyzing file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
