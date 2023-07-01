import 'dart:convert';

import 'package:http/http.dart' as http;

class Account {
  final String accountID;
  final String username;
  final String firstName;
  final String lastName;
  final String accountRole;
  final bool isActive;
  final bool isStaff;
  final bool isSuperuser;

  Account({
    required this.accountID,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.accountRole,
    required this.isActive,
    required this.isStaff,
    required this.isSuperuser,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      accountID: json['accountID'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      accountRole: json['accountRole'],
      isActive: json['is_active'],
      isStaff: json['is_staff'],
      isSuperuser: json['is_superuser'],
    );
  }

  Map<String, dynamic> toJson() => {
        'accountID': accountID,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'accountRole': accountRole,
        'is_active': isActive,
        'is_staff': isStaff,
        'is_superuser': isSuperuser,
      };
}
