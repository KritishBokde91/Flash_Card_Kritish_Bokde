import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listQuestion = FutureProvider.autoDispose((ref) async {
  final snapshot = await FirebaseFirestore.instance.collection('Questions').get();
  return snapshot.docs;
});