import 'package:ecommerce/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.password,
    required super.phone,
    required super.name,
    required super.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      name: Name(
        firstname: json['name']['firstname'],
        lastname: json['name']['lastname'],
      ),
      address: Address(
        geolocation: Geolocation(
          lat: json['address']['geolocation']['lat'],
          long: json['address']['geolocation']['long'],
        ),
        city: json['address']['city'],
        street: json['address']['street'],
        number: json['address']['number'],
        zipcode: json['address']['zipcode'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
      'name': {
        'firstname': name.firstname,
        'lastname': name.lastname,
      },
      'address': {
        'geolocation': {
          'lat': address.geolocation.lat,
          'long': address.geolocation.long,
        },
        'city': address.city,
        'street': address.street,
        'number': address.number,
        'zipcode': address.zipcode,
      },
    };
  }
}