import 'package:job_finder_app/products/services/company/company_manager.dart';
import 'package:job_finder_app/products/services/company/company_service.dart';
import 'package:job_finder_app/products/utilities/states/company/company_cubit.dart';

mixin CompanyTransactionsMixin {
  final CompanyManager companyServiceManager = CompanyManager(CompanyService.instance);

  Future<void> getAndSetCompanies() async {
    await companyServiceManager.getAllCompanies().then((value) {
      if (value != null) {
        CompanyCubit.instance.setCompanies(value);
      }
    });
  }
}
