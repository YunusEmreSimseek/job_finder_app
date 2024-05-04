// ignore_for_file: constant_identifier_names

enum WorkStyles {
  FullTime(true),
  PartTime(false),
  ;

  final bool value;
  const WorkStyles(this.value);
}
