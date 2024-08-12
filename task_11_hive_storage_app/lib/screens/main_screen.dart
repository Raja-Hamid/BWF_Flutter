import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_storage_app/components/notes.dart';

class MainScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function toggleTheme;

  const MainScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _editController = TextEditingController();
  final Notes notes = Notes();

  void _toggleTheme() {
    widget.toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final notesBox = Hive.box('notesBox');
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Hive Storage App',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    labelText: 'Enter a note',
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: notesBox.listenable(),
                    builder: (context, Box box, _) {
                      if (box.values.isEmpty) {
                        return const Center(child: Text('No notes added.'));
                      }
                      return ListView.builder(
                        itemCount: box.values.length,
                        itemBuilder: (context, index) {
                          final note = box.getAt(index) as Map;
                          return Card(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 3,
                            child: ListTile(
                              title: Text(note['text']),
                              subtitle: Text(
                                'Created: ${note['timestamp']}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit,
                                        color: theme.colorScheme.tertiary),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) {
                                        _editController.text = note['text'];
                                        return AlertDialog(
                                          title: const Text('Edit Note'),
                                          content: TextField(
                                            controller: _editController,
                                            decoration: const InputDecoration(
                                                hintText:
                                                    'Enter new note text'),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                notes.editNoteDialog(index,
                                                    _editController.text, note);
                                                Navigator.of(context).pop();
                                                setState(() {});
                                              },
                                              child: Text(
                                                'Save',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => setState(() {
                                      notes.deleteNote(index);
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            notes.addNote(_controller.text);
          });
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.save,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
