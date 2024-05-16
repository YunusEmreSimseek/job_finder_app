final class CreateUserCommand {
  final String name;
  final String email;
  final String password;

  CreateUserCommand({required this.name, required this.email, required this.password});
}
