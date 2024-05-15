import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:job_finder_app/products/utilities/enums/firebase_collections.dart';
import 'package:logger/logger.dart';

abstract class ICompanyService {
  Future<CompanyModel?> getCompanyById(String companyId);
  Future<List<CompanyModel>?> getAllCompanies();
  Future<bool> addCopmany(CompanyModel companyModel);
}

final class CompanyService implements ICompanyService {
// Singleton
  static CompanyService? _instance;
  static CompanyService get instance {
    _instance ??= CompanyService._init();
    return _instance!;
  }

  CompanyService._init();

  final _companyReference = FirebaseCollections.company.reference;

  @override
  Future<List<CompanyModel>?> getAllCompanies() async {
    final response = await _companyReference
        .withConverter(
            fromFirestore: (snapshot, options) => CompanyModel().fromFirebase(snapshot),
            toFirestore: (value, options) => value.toJson())
        .get();

    if (response.docs.isNotEmpty) {
      Logger().d('Companies found');
      final companies = response.docs.map((e) => e.data()).toList();
      return companies;
    }
    Logger().e('Companies not found');
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
      Logger().d('Company found : ${response.docs.first.data()}');
      final company = response.docs.map((e) => e.data()).first;
      return company;
    }
    Logger().e('Company not found');
    return null;
  }

  @override
  Future<bool> addCopmany(CompanyModel companyModel) async {
    final response = await _companyReference.add(companyModel.toJson());
    if (response.id.isNotEmpty) {
      Logger().d('Company added');
      await _addIdIntoCompany(response);
      return true;
    }
    Logger().e('Company not added');
    return false;
  }

  Future<void> _addIdIntoCompany(DocumentReference docRef) async {
    await docRef.update({'id': docRef.id});
  }
}
