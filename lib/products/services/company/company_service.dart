import 'package:job_finder_app/products/enums/firebase_collections.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:logger/logger.dart';

abstract class ICompanyService {
  Future<CompanyModel?> getCompanyById(String companyId);
  Future<List<CompanyModel>?> getAllCompany();
}

final class CompanyService implements ICompanyService {
  final _companyReference = FirebaseCollections.company.reference;

  @override
  Future<List<CompanyModel>?> getAllCompany() async {
    final response = await _companyReference
        .withConverter(
            fromFirestore: (snapshot, options) => CompanyModel().fromFirebase(snapshot),
            toFirestore: (value, options) => value.toJson())
        .get();

    if (response.docs.isNotEmpty) {
      Logger().i('Companies found');
      final companies = response.docs.map((e) => e.data()).toList();
      return companies;
    }
    Logger().i('Companies not found');
    return null;
  }

  @override
  Future<CompanyModel?> getCompanyById(String companyId) async {
    final response = await _companyReference
        .where('id', isEqualTo: companyId)
        .withConverter(
          fromFirestore: (snapshot, options) => CompanyModel().fromFirebase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    if (response.docs.isNotEmpty) {
      Logger().i('Company found');
      final company = response.docs.map((e) => e.data()).first;
      return company;
    }
    Logger().i('Company not found');
    return null;
  }
}
