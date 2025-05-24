import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final String password;
  final String phone;
  final Name name;
  final Address address;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
    required this.address,
  });
  
  @override
  List<Object?> get props => [id, email, password, username, phone, name, address];
}

class Name {
  final String firstname;
  final String lastname;

  Name({
    required this.firstname,
    required this.lastname,
  });
}

class Address {
  final Geolocation geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });
}

class Geolocation {
  final String lat;
  final String long;

  Geolocation({
    required this.lat,
    required this.long,
  });
}