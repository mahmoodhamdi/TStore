class Address {
  final String ?street;
  final String ? city;
  final String ?state;
  final String ?zipCode;
  final String address;

  Address({
    required this.address,
      this.street,
      this.city,
      this.state,
      this.zipCode,
  });

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

  UserModel({
    this.emailVerified=false,
    required this.id,
    this.firstName,
    this.lastName,
    required this.username,
    required this.email,
    this.phoneNumber,
    this.address,
    this.image,
    this.rememberMe = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address?.toJson(), // Convert Address to JSON if not null
      'image': image,
      'rememberMe': rememberMe,
      'emailVerified':emailVerified
    };
  }
}
