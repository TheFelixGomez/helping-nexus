import 'location.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String? phone;
  String dob;
  Location location;
  bool wisher;
  String? companyName;
  String? description;
  String? profilePicture;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    required this.dob,
    required this.location,
    this.wisher = false,
    this.companyName,
    this.description,
    this.profilePicture
  });

  factory User.fromJson(Map<String, dynamic> json){
    json = json['data'];
    return User(
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      dob: json['dob'] as String,
      location: Location.fromJson(json['location']),
      wisher: json['wisher'] as bool,
      companyName: json['company_name'] as String?,
      description: json['description'] as String?,
      profilePicture: json['profile_picture'] as String?,
    );
  }
}