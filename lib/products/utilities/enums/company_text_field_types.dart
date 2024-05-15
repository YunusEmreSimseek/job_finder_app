import 'package:flutter/material.dart';

enum CompanyTextFieldTypes {
  title(hintText: 'Title', prefixIconData: Icons.title, keyboardType: TextInputType.text),
  content(hintText: 'Content', prefixIconData: Icons.content_paste, keyboardType: TextInputType.text),
  ;

  final String hintText;
  final IconData prefixIconData;
  final TextInputType keyboardType;
  const CompanyTextFieldTypes({required this.hintText, required this.prefixIconData, required this.keyboardType});
}
