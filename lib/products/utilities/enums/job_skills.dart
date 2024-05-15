import 'package:flutter/material.dart';

enum JobSkills {
  flutter('assets/icons/ic_flutter.png'),
  design('assets/icons/ic_designer.png'),
  web('assets/icons/ic_web.png'),
  java('assets/icons/ic_java.png'),
  adobe('assets/icons/ic_adobe.png'),
  ;

  const JobSkills(this.imageAddress);
  final String imageAddress;
}

extension JobSkillsExtension on JobSkills {
  Image toImage() {
    return Image.asset(
      imageAddress,
      height: 10,
    );
  }
}
