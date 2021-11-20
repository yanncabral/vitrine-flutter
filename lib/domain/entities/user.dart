import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/person_name.dart';

class User {
  final String? id;
  final PersonName name;
  final EmailAddress email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });
}
