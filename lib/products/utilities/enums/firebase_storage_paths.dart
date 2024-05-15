// ignore_for_file: constant_identifier_names

enum FirebaseStoragePaths {
  user_images('User Images'),
  company_images('Company Images'),
  files('files'),
  ;

  const FirebaseStoragePaths(this.value);
  final String value;
}
