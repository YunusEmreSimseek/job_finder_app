import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/constants/string_constant.dart';
import 'package:job_finder_app/products/utilities/extensions/validation_extension.dart';

enum AuthTextFieldType {
  email(
    func: TextFieldTypeValids.emailType,
    hintText: StringConstant.email,
    prefixIconData: Icons.email_rounded,
    keyboardType: TextInputType.emailAddress,
  ),
  password(
    func: TextFieldTypeValids.passwordType,
    hintText: StringConstant.password,
    prefixIconData: Icons.password_rounded,
    isPassword: true,
    keyboardType: TextInputType.text,
  ),
  confirmPassword(
    func: TextFieldTypeValids.passwordType,
    hintText: StringConstant.confirmPassword,
    prefixIconData: Icons.password_rounded,
    isPassword: true,
    keyboardType: TextInputType.text,
  ),
  name(
    func: TextFieldTypeValids.nameType,
    hintText: StringConstant.name,
    prefixIconData: Icons.align_vertical_top,
    keyboardType: TextInputType.text,
  ),
  phone(
    func: TextFieldTypeValids.phoneType,
    hintText: StringConstant.phone,
    prefixIconData: Icons.phone,
    keyboardType: TextInputType.phone,
  ),
  text(
    func: null,
    hintText: '',
    prefixIconData: Icons.text_fields,
    keyboardType: TextInputType.text,
  );

  final String? Function(String?)? func;
  final String hintText;
  final IconData prefixIconData;
  final bool isPassword;
  final TextInputType keyboardType;
  const AuthTextFieldType(
      {required this.func,
      required this.hintText,
      required this.prefixIconData,
      this.isPassword = false,
      required this.keyboardType});
}

@immutable
final class TextFieldTypeValids {
  static String? emailType(String? value) {
    if (!value!.isValidEmail) {
      return StringConstant.validationEmail;
    }
    return null;
  }

  static String? passwordType(String? value) {
    if (!value!.isPasswordValid) {
      return StringConstant.validationPassword;
    }
    return null;
  }

  static String? nameType(String? value) {
    if (value!.isEmpty) {
      return StringConstant.validationName;
    }
    return null;
  }

  static String? phoneType(String? value) {
    if (!value!.isValidPhone && value.isNotEmpty) {
      return StringConstant.validationPhone;
    }
    return null;
  }
}
