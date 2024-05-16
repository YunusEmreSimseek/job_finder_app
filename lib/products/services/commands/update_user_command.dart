final class UpdateUserCommand {
  final String userId;
  final String name;
  final String email;
  final String password;
  final String? imageUrl;
  final DateTime? birthDate;
  final String? phone;

  UpdateUserCommand(
      {required this.userId,
      required this.name,
      required this.email,
      required this.password,
      this.imageUrl,
      this.birthDate,
      this.phone});
}
