class Validators {
  String? Function(String?) phonevalidator = (phone) {
    if (phone!.isEmpty) {
      return "Phone Number is required";
    } else if (phone.length < 10) {
      return "Invalid Phone Number";
    } else {
      return null;
    }
  };
  String? Function(String?) otpvalidator = (otp) {
    if (otp!.isEmpty) {
      return "Enter OTP";
    } else {
      return null;
    }
  };
}
