import 'package:flutter/material.dart';
import 'package:job_finder_app/products/constants/string_constant.dart';
import 'package:job_finder_app/products/utilities/extensions/validation_extension.dart';

enum TextFieldType {
  email(
    func: TextFieldTypeValids.emailType,
    hintText: StringConstant.email,
    prefixIcon: Icon(Icons.email_rounded),
    keyboardType: TextInputType.emailAddress,
  ),
  password(
    func: TextFieldTypeValids.passwordType,
    hintText: StringConstant.password,
    prefixIcon: Icon(Icons.password_rounded),
    isPassword: true,
    keyboardType: TextInputType.text,
  ),
  confirmPassword(
    func: TextFieldTypeValids.passwordType,
    hintText: StringConstant.confirmPassword,
    prefixIcon: Icon(Icons.password_rounded),
    isPassword: true,
    keyboardType: TextInputType.text,
  ),
  name(
    func: TextFieldTypeValids.nameType,
    hintText: StringConstant.name,
    prefixIcon: Icon(Icons.align_vertical_top),
    keyboardType: TextInputType.name,
  ),
  phone(
    func: TextFieldTypeValids.phoneType,
    hintText: StringConstant.phone,
    prefixIcon: Icon(Icons.phone),
    keyboardType: TextInputType.phone,
  ),
  text(
    func: null,
    hintText: '',
    prefixIcon: Icon(Icons.text_fields),
    keyboardType: TextInputType.text,
  );

  final String? Function(String?)? func;
  final String hintText;
  final Icon prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  const TextFieldType(
      {required this.func,
      required this.hintText,
      required this.prefixIcon,
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
    if (!value!.isValidPhone) {
      return StringConstant.validationPhone;
    }
    return null;
  }
}
