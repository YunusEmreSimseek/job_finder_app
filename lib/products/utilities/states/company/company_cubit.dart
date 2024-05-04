import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:job_finder_app/products/utilities/states/base/base_state.dart';

part 'company_state.dart';

final class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(const CompanyState());

  Future<void> setCompanies(List<CompanyModel> companies) async {
    emit(state.copyWith(companies: companies));
  }
}
