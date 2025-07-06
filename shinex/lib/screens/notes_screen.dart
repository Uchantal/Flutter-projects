import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../models/note.dart';

class NotesScreen extends StatelessWidget {
  final String uid;
  const NotesScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
      ),
      body: Builder(
        builder: (context) {
          if (notesProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (notesProvider.notes.isEmpty) {
            return const Center(
              child: Text(
                'Nothing here yet—tap ➕ to add a note.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            itemCount: notesProvider.notes.length,
            itemBuilder: (context, index) {
              final note = notesProvider.notes[index];
              return ListTile(
                title: Text(note.text),
                subtitle: Text(note.timestamp.toDate().toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final newText = await showDialog<String>(
                          context: context,
                          builder: (context) {
                            final controller = TextEditingController(text: note.text);
                            return AlertDialog(
                              title: const Text('Edit Note'),
                              content: TextField(
                                controller: controller,
                                autofocus: true,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, controller.text),
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                        if (newText != null && newText.trim().isNotEmpty) {
                          await notesProvider.updateNote(uid, note.id, newText.trim());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Note updated!')),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await notesProvider.deleteNote(uid, note.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Note deleted!')),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newText = await showDialog<String>(
            context: context,
            builder: (context) {
              final controller = TextEditingController();
              return AlertDialog(
                title: const Text('Add Note'),
                content: TextField(
                  controller: controller,
                  autofocus: true,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, controller.text),
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
          if (newText != null && newText.trim().isNotEmpty) {
            await notesProvider.addNote(uid, newText.trim());
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Note added!')),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
