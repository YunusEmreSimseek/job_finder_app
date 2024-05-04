import 'package:flutter/material.dart';
import 'package:job_finder_app/products/constants/string_constant.dart';

enum CreateAdTextFieldType {
  companyName(StringConstant.postCompanyName, Icon(Icons.business), TextInputType.text),
  workTitle(StringConstant.postWorkTitle, Icon(Icons.business_center), TextInputType.text),
  pricePerHour(StringConstant.postPricePerHour, Icon(Icons.price_change), TextInputType.text),
  location(StringConstant.postLocation, Icon(Icons.location_city_rounded), TextInputType.text),
  content(StringConstant.postContent, Icon(Icons.message), TextInputType.text),
  ;

  final String hintText;
  final Icon prefixIcon;
  final TextInputType keyboardType;
  const CreateAdTextFieldType(this.hintText, this.prefixIcon, this.keyboardType);
}
