import 'package:flutter/material.dart';
import 'quiz_class.dart';

class FolderContentsScreen extends StatelessWidget {
  final CreateFolder folder;

  const FolderContentsScreen({required this.folder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Folder Contents - ${folder.title}'),
      ),
      body: ListView(
        children: [
          // Display folder contents here
          // For example:
          ListTile(title: Text('Item 1')),
          ListTile(title: Text('Item 2')),
          // ...
        ],
      ),
    );
  }
}
