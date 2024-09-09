
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore{

  final db = FirebaseFirestore.instance;


  Future<void> read() async { 
    final p = await db.collection('product').doc
  }
}