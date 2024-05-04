part of 'company_cubit.dart';

final class CompanyState extends Equatable implements BaseState {
  const CompanyState({this.companies});

  final List<CompanyModel>? companies;

  CompanyState copyWith({List<CompanyModel>? companies}) {
    return CompanyState(companies: companies ?? this.companies);
  }

  @override
  List<Object?> get props => [companies];
}
