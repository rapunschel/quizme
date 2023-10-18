import 'package:flutter/material.dart';
import '../model/quiz_class.dart';
import 'folder_content.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 92, 199, 149)),
        useMaterial3: true,
      ),
      home: const Folder(title: 'Folders'),
    );
  }
}

class Folder extends StatefulWidget {
  const Folder({Key? key, required this.title});

  final String title;

  @override
  State<Folder> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Folder> {
  List<CreateFolder> folders = [];

  TextEditingController _folderNameController = TextEditingController();

  void addFolder(String title) {
    setState(() {
      folders.add(CreateFolder(title: title));
    });
  }

  void _openFolderContents(CreateFolder folder) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FolderContentsScreen(folder: folder),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () {},
                  shape: StadiumBorder(),
                  icon: Icon(Icons.share_rounded),
                  label: Text('Share Folder'),
                ),
                SizedBox(
                  width: 150,
                  child: FloatingActionButton.extended(
                      onPressed: () {},
                      shape: StadiumBorder(),
                      icon: Icon(Icons.add),
                      label: Text('Add Quiz to Folder')),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _folderNameController,
              decoration: InputDecoration(
                labelText: 'Folder name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String folderTitle = _folderNameController.text;
                addFolder(folderTitle);
                _folderNameController.clear();
              },
              child: Text('Save Folder'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(folders[index].title),
                    onTap: () {
                      _openFolderContents(folders[index]);
                    },
                    // Customize the appearance of the ListTile as needed
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
