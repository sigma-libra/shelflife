// tags_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive/hive.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/tag/tag.dart';

class TagsPage extends StatefulWidget {
  final Box<Tag> tagsBox;

  const TagsPage({super.key, required this.tagsBox});

  @override
  _TagsPageState createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  final textEditingController = TextEditingController();
  Color _selectedColor = Colors.brown; // Default color

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void addTag() {
    String newTag = textEditingController.text;
    if (widget.tagsBox.containsKey(newTag)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$newTag already exists'),
        ),
      );
    } else if (newTag.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tag cannot be empty!'),
        ),
      );
    } else {
      setState(() {
        widget.tagsBox.put(newTag, Tag(name: newTag, color: _selectedColor.value));
        textEditingController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tags'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: textEditingController,
              onSubmitted: (newTag) {
                addTag();
              },
              decoration: InputDecoration(
                hintText: 'Add a new tag',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.color_lens),
                  color: _selectedColor,
                  onPressed: _openColorPickerDialog,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      addTag();
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.tagsBox.length,
              itemBuilder: (context, index) {
                return Padding(padding: const EdgeInsets.all(8.0), child: makeListTile(widget.tagsBox.getAt(index)!, index));
              },
            ),
          ),
        ],
      ),
    );
  }

  ListTile makeListTile(Tag tag, index) {
    final color = Color(tag.color);
    return ListTile(
      title: Text(tag.name),
      tileColor: color,
      leading: IconButton(
        icon: const Icon(Icons.color_lens),
        color: BLACK_BROWN,
        highlightColor: color,
        onPressed: () => _openColorPickerDialog(tag: tag),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          setState(() {
            // Remove the tag from the list and the Hive box
            widget.tagsBox.delete(tag.name);
          });
        },
      ),
    );
  }

  void _openColorPickerDialog({Tag? tag}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: tag?.color != null ? Color(tag!.color) : _selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  if (tag != null) {
                    tag.color = color.value;
                    widget.tagsBox.put(tag.name, tag);
                  } else {
                    _selectedColor = color;
                  }
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
