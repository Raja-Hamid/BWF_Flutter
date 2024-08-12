import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Notes {
  final Box notesBox = Hive.box('notesBox');

  void addNote(String note) {
    if (note.isNotEmpty) {
      final noteData = {
        'text': note,
        'timestamp': DateTime.now().toString(),
        'color': Colors.white.value,
      };
      notesBox.add(noteData);
    }
  }

  void deleteNote(int index) {
    notesBox.deleteAt(index);
  }

  void editNoteDialog(int index, String newText, Map note) {
    notesBox.putAt(index, {
      'text': newText,
      'timestamp': DateTime.now().toString(),
      'color': note['color'],
    });
  }
}
