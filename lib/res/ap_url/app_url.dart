

class AppUrl {
  // 🔹 Base URL (10.0.2.2 works for Android Emulator; use localhost for browser)
  // static const String baseUrl = 'http://10.0.2.2/api/';
  static const String baseUrl = 'http://192.168.0.217/api'; // replace with your IP
  // static const String baseUrl = 'http://192.168.0.103/api';

  // 🔹 Endpoints
  static const String testApi = '$baseUrl/test_api.php';
  static const String signupApi = '$baseUrl/signup.php';
  static const String loginApi = '$baseUrl/login.php';
  static const String homeApi = '$baseUrl/user_home_data.php';
  static const String getattendenceApi = '$baseUrl/get_attendence.php';
  static const String getstatsApi = '$baseUrl/get_attendance_statistics.php';
}
