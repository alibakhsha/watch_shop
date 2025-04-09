import 'package:flutter/cupertino.dart';

class RegisterUserResponse {
  final String message;
  final UserData data;

  RegisterUserResponse({required this.message, required this.data});

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) {
    debugPrint('Parsing RegisterUserResponse: $json');
    return RegisterUserResponse(
      message: json['message'] ?? "",
      data: UserData.fromJson(json['data']?['user'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'RegisterUserResponse(message: $message, data: $data)';
  }
}

// lib/core/model/user_data.dart
class UserData {
  final int id;
  final String name;
  final String mobile;
  final String phone;
  final Address address;
  final List<String>? imagePaths;

  UserData({
    required this.id,
    required this.name,
    required this.mobile,
    required this.phone,
    required this.address,
    this.imagePaths,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    debugPrint('Parsing UserData: $json');
    return UserData(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      mobile: json['mobile'] ?? "",
      phone: json['phone'] ?? "",
      address: Address.fromJson(json['address'] ?? {}),
      imagePaths:
          json['image_paths'] != null
              ? List<String>.from(json['image_paths'])
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name.isNotEmpty ? name : "",
      'mobile': mobile.isNotEmpty ? mobile : "",
      'phone': phone.isNotEmpty ? phone : "",
      'address': address.address.isNotEmpty ? address.address : "",
      'lat': address.lat ?? 0.0,
      'lng': address.lng ?? 0.0,
      'postalCode': address.postalCode.isNotEmpty ? address.postalCode : "",
      'imagePaths': imagePaths != null ? imagePaths!.join(',') : null,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      mobile: map['mobile'] ?? '',
      phone: map['phone'] ?? '',
      address: Address(
        address: map['address'] ?? '',
        lat: map['lat']?.toDouble() ?? 0.0,
        lng: map['lng']?.toDouble() ?? 0.0,
        postalCode: map['postalCode'] ?? '',
      ),
      imagePaths:
          map['imagePaths'] != null
              ? (map['imagePaths'] as String).split(',')
              : null,
    );
  }

  @override
  String toString() {
    return 'UserData(id: $id, name: $name, mobile: $mobile, phone: $phone, address: $address, imagePaths: $imagePaths)';
  }
}

class Address {
  final String address;
  final double lat;
  final double lng;
  final String postalCode;

  Address({
    required this.address,
    required this.lat,
    required this.lng,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    debugPrint('Parsing Address: $json');
    return Address(
      address: json['address'] ?? "",
      lat: json['lat']?.toDouble() ?? 0.0,
      lng: json['lng']?.toDouble() ?? 0.0,
      postalCode: json['postal_code'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address.isNotEmpty ? address : "",
      'lat': lat ?? 0.0,
      'lng': lng ?? 0.0,
      'postalCode': postalCode.isNotEmpty ? postalCode : "",
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      address: map['address'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      postalCode: map['postalCode'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Address(address: $address, lat: $lat, lng: $lng, postalCode: $postalCode)';
  }
}
