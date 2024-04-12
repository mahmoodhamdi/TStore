class Address {
  final String? street;
  final String? city;
  final String? state;
  final String? zipCode;
  final String address;

  Address({
    required this.address,
    this.street,
    this.city,
    this.state,
    this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'address': address,
    };
  }
}

class UserModel {
  final String id;
  final String? firstName;
  final String? lastName;
  final String username;
  final String email;
  final String? phoneNumber;
  final Address? address;
  final String? image;
  final bool rememberMe;
  final bool emailVerified;
  final String? gender;
  final DateTime? birthDate;

  String get fullName => '$firstName $lastName';

  UserModel({
    this.emailVerified = false,
    required this.id,
    this.firstName,
    this.lastName,
    required this.username,
    required this.email,
    this.phoneNumber,
    this.address,
    this.image,
    this.rememberMe = false,
    this.gender,
    this.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      image: json['image'],
      rememberMe: json['rememberMe'] ?? false,
      emailVerified: json['emailVerified'] ?? false,
      gender: json['gender'],
      birthDate:
          json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address?.toJson(),
      'image': image,
      'rememberMe': rememberMe,
      'emailVerified': emailVerified,
      'gender': gender,
      'birthdate': birthDate?.toIso8601String(),
    };
  }
}
