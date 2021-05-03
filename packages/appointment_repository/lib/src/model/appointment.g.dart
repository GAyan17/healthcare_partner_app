// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return Appointment(
    id: json['id'] as String?,
    partnerId: json['partner_id'] as String?,
    partnerName: json['partner_name'] as String?,
    patientName: json['patient_name'] as String?,
    patientId: json['patient_id'] as String?,
    patientAge: json['patient_age'] as int?,
    appointmentDateTime: json['appointment_date_time'] == null
        ? null
        : DateTime.parse(json['appointment_date_time'] as String),
    symptoms: json['symptoms'] as String?,
    description: json['description'] as String?,
    prescription: json['prescription'] as String?,
    appointmentStatus: json['appointment_status'] as String?,
    paymentStatus: json['payment_status'] as String?,
    rating: (json['rating'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partner_id': instance.partnerId,
      'partner_name': instance.partnerName,
      'patient_name': instance.patientName,
      'patient_id': instance.patientId,
      'patient_age': instance.patientAge,
      'appointment_date_time': instance.appointmentDateTime?.toIso8601String(),
      'symptoms': instance.symptoms,
      'description': instance.description,
      'prescription': instance.prescription,
      'appointment_status': instance.appointmentStatus,
      'payment_status': instance.paymentStatus,
      'rating': instance.rating,
    };
