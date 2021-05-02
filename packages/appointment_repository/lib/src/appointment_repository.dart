import 'package:cloud_firestore/cloud_firestore.dart';

import '../appointment_repository.dart';

class AppointmentRepository {
  AppointmentRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const _appontmentCollection = 'appointments';
  static const _partnerId = 'partner_id';

  Future<void> createAppointment(Appointment appointment) async {
    await _firestore
        .collection(_appontmentCollection)
        .add(appointment.toJson());
  }

  Future<void> updateAppointment(Appointment appointment) async {
    await _firestore
        .collection(_appontmentCollection)
        .doc(appointment.id)
        .update(appointment.toJson());
  }

  Stream<List<Appointment>> getAppointments(String partnerId) {
    return _firestore
        .collection(_appontmentCollection)
        .where(_partnerId, isEqualTo: partnerId)
        .snapshots()
        .map((qSnap) {
      return qSnap.docs.map((docSnap) {
        return Appointment.fromJson(docSnap.data());
      }).toList();
    });
  }
}
