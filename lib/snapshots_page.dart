import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SnapshotsPage extends StatefulWidget {
  @override
  _SnapshotsPageState createState() => _SnapshotsPageState();
}

class _SnapshotsPageState extends State<SnapshotsPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _title;
  String? _caption;
  String? _userName;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
      _showInputDialog();
    } else {
      print('User canceled image selection.');
    }
  }

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _caption = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Caption'),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _userName = value;
                  });
                },
                decoration: InputDecoration(labelText: 'User Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Save the details (title, caption, user name) here
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.92,
                      height: MediaQuery.of(context).size.width * 0.92,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.thumb_up),
                      Icon(Icons.thumb_down),
                      Icon(Icons.comment),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Title: $_title'),
                  Text('Caption: $_caption'),
                  Text('User Name: $_userName'),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Upload Photo',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
