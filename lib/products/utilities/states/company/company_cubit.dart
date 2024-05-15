import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:job_finder_app/products/utilities/states/base/base_state.dart';

part 'company_state.dart';

final class CompanyCubit extends Cubit<CompanyState> {
  static CompanyCubit? _instance;
  static CompanyCubit get instance {
    _instance ??= CompanyCubit._init();
    return _instance!;
  }

  CompanyCubit._init() : super(const CompanyState());

  Future<void> setCompanies(List<CompanyModel> companies) async {
    emit(state.copyWith(companies: companies));
  }
}
