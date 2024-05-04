import 'package:job_finder_app/products/enums/firebase_collections.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:logger/logger.dart';

part 'company_service.dart';

final class CompanyServiceManager {
  final ICompanyService _companyService;

  CompanyServiceManager(this._companyService);

  Future<List<CompanyModel>?> getAllCompanies() async {
    final response = await _companyService.getAllCompanies();
    return response;
  }

  Future<CompanyModel?> getCompanyById(String companyId) async {
    final response = await _companyService.getCompanyById(companyId);
    return response;
  }
}
