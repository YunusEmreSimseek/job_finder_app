import 'package:job_finder_app/products/models/company_model.dart';
import 'package:job_finder_app/products/services/company/company_service.dart';

final class CompanyManager {
  final ICompanyService _companyService;

  CompanyManager(this._companyService);

  Future<List<CompanyModel>?> getAllCompanies() async {
    final response = await _companyService.getAllCompanies();
    return response;
  }

  Future<CompanyModel?> getCompanyById(String companyId) async {
    final response = await _companyService.getCompanyById(companyId);
    return response;
  }

  Future<bool> addCompany(CompanyModel companyModel) async {
    final response = await _companyService.addCopmany(companyModel);
    return response;
  }
}
