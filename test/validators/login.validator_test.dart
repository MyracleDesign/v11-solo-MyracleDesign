import 'package:flutter_app/validators/login.validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("LoginValidator", () {
    group("validate email", () {
      test("should return true if email is valid", () {
        expect(LoginValidator.isValidEmail("weber.max@mail.de"), true);
      });

      test("should return false if email is invalid", () {
        expect(LoginValidator.isValidEmail("NotAValidMail"), false);
      });

      test("should return false if email is invalid", () {
        expect(() => LoginValidator.isValidEmail(null), throwsArgumentError);
      });
    });

    group("validate password", () {
      test("should return true if password is valid", () {
        expect(LoginValidator.isValidPassword("TestPassword456"), true);
      });

      test("should return true if password is valid", () {
        expect(() => LoginValidator.isValidPassword(null), throwsArgumentError);
      });
    });
  });
}
