import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String id;
  final String phoneNumber;
  final bool fromApp;
  final String name;
  final String userEmail;

  const ContactEntity({
    required this.id,
    required this.phoneNumber,
    this.fromApp = false,
    required this.name,
    required this.userEmail,
  });

  ContactEntity copyWith({
    String? id,
    String? name,
    bool? fromApp,
    String? phoneNumber,
    String? userEmail,
  }) {
    return ContactEntity(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fromApp: fromApp ?? this.fromApp,
      name: name ?? this.name,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fromApp,
        phoneNumber,
        name,
        userEmail,
      ];
}
