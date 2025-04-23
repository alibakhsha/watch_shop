abstract class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  final String name;
  final String phone;
  final String address;
  final String postalCode;
  final double lat;
  final double lng;
  final List<String>? imagePaths; // لیست مسیرهای تصاویر
  final String token;

  RegisterUserEvent({
    required this.name,
    required this.phone,
    required this.address,
    required this.postalCode,
    required this.lat,
    required this.lng,
    this.imagePaths, // لیست اختیاری
    required this.token
  });
}
