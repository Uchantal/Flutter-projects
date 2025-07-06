import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note.dart';

class NotesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Note>> fetchNotes(String uid) async {
    final snapshot = await _db.collection('users').doc(uid).collection('notes').orderBy('timestamp', descending: true).get();
    return snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
  }

  Future<void> addNote(String uid, String text) async {
    await _db.collection('users').doc(uid).collection('notes').add({
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateNote(String uid, String noteId, String text) async {
    await _db.collection('users').doc(uid).collection('notes').doc(noteId).update({
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String uid, String noteId) async {
    await _db.collection('users').doc(uid).collection('notes').doc(noteId).delete();
  }
}
