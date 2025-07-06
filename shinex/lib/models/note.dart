import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String text;
  final Timestamp timestamp;

  Note({required this.id, required this.text, required this.timestamp});

  factory Note.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      text: data['text'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
