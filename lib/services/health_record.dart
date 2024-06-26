import 'package:cloud_firestore/cloud_firestore.dart';

class HealthRecordService {
  final String _userId;
  final CollectionReference userHealthRecords;

  HealthRecordService(this._userId)
      : userHealthRecords = FirebaseFirestore.instance
      .collection("users")
      .doc(_userId)
      .collection('health_records');

  Future<void> addHealthRecord(Map<String, dynamic> record) {
    record['time'] = Timestamp.now();
    return userHealthRecords.add(record);
  }

  Stream<QuerySnapshot> getUserHealthRecord() {
    final notesStream = userHealthRecords.orderBy('time').snapshots();

    return notesStream;
  }

  Future<void> deleteHealthRecord(String docId) {
    return userHealthRecords.doc(docId).delete();
  }
}
