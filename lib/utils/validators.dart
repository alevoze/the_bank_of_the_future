

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp emailValidator = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
r"{0,253}[a-zA-Z0-9])?)*$");

const String emailNullError = "Please Enter your email";
const String invalidEmailError = "Please Enter Valid Email";
const String passNullError = "Please Enter your password";
const String shortPassError = "Password is too short";
const String matchPassError = "Passwords don't match";
const String nameNullError = "Please Enter your name";
const String phoneNumberNullError = "Please Enter your phone number";
const String phoneNumberShortError = "Phone number is too short";
const String addressNullError = "Please Enter your address";
const String awbNumberNullError = "Please input  your Order/AWB Number";
const String awbNumberLengthError = "Input your AWB with 8-10 character";