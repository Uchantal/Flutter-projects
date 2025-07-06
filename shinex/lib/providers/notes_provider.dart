import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/notes_service.dart';

class NotesProvider extends ChangeNotifier {
  final NotesService _notesService = NotesService();
  List<Note> _notes = [];
  bool _isLoading = false;
  String? _error;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchNotes(String uid) async {
    _isLoading = true;
    notifyListeners();
    try {
      _notes = await _notesService.fetchNotes(uid);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNote(String uid, String text) async {
    try {
      await _notesService.addNote(uid, text);
      await fetchNotes(uid);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateNote(String uid, String noteId, String text) async {
    try {
      await _notesService.updateNote(uid, noteId, text);
      await fetchNotes(uid);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteNote(String uid, String noteId) async {
    try {
      await _notesService.deleteNote(uid, noteId);
      await fetchNotes(uid);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
