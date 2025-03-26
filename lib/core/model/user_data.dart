class RegisterUserRequest {
  final String name;
  final String phone;
  final String address;
  final String postalCode;
  final double lat;
  final double lng;
  final List<String>? imagePaths;

  RegisterUserRequest({
    required this.name,
    required this.phone,
    required this.address,
    required this.postalCode,
    required this.lat,
    required this.lng,
    this.imagePaths,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'postal_code': postalCode,
      'lat': lat,
      'lng': lng,
      'images': imagePaths != null && imagePaths!.isNotEmpty
          ? imagePaths // ارسال لیست مسیرهای تصویر
          : null,
    };
  }
}

class RegisterUserResponse {
  final bool result;
  final String message;
  final UserData data;

  RegisterUserResponse({required this.result, required this.message, required this.data});

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) {
    return RegisterUserResponse(
      result: json['result'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String mobile;
  final String phone;
  final Address address;

  UserData({required this.id, required this.name, required this.mobile, required this.phone, required this.address});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id']?? 0,
      name: json['name']?? "",
      mobile: json['mobile']?? "",
      phone: json['phone']?? "",
      address: Address.fromJson(json['address']?? {}),
    );
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
    return Address(
      address: json['address'] ?? "",
      lat: json['lat']?? 0.0,
      lng: json['lng']?? 0.0,
      postalCode: json['postal_code']??"",
    );
  }
}
