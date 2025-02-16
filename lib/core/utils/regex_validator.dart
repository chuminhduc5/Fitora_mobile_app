class RegexValidator {
  RegexValidator._();

  // static bool isValidEmail(String email) {
  //   final RegExp regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  //   return regex.hasMatch(email);
  // }
  //
  // static bool isValidPhoneNumber(String phoneNumber) {
  //   final RegExp regex = RegExp(r"^(0[3|5|7|8|9])+([0-9]{8})$");
  //   return regex.hasMatch(phoneNumber);
  // }
  //
  // static bool isValidPassword(String password) {
  //   return password.length >= 6;
  // }


  static final email = RegExp(r"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$");
  static final password = RegExp(r"^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$");
}
