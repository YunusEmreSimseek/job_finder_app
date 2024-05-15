import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/constants/string_constant.dart';

enum CreateAdTextFieldType {
  companyName(StringConstant.postCompanyName, Icons.business, TextInputType.text),
  workTitle(StringConstant.postWorkTitle, Icons.business_center, TextInputType.text),
  pricePerHour(StringConstant.postPricePerHour, Icons.price_change, TextInputType.number),
  location(StringConstant.postLocation, Icons.location_city_rounded, TextInputType.text),
  content(StringConstant.postContent, Icons.message, TextInputType.text),
  ;

  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  const CreateAdTextFieldType(this.hintText, this.prefixIcon, this.keyboardType);
}
