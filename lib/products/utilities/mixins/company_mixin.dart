import 'package:flutter/material.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:job_finder_app/products/services/company/company_service.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';

mixin CompanyMixin<T extends StatefulWidget> on BaseViewMixin<T> {
  final ICompanyService _companyService = CompanyService();
  DropdownButton<CompanyModel> companyDropdownButton() {
    return DropdownButton<CompanyModel>(
      items: const [],
      onChanged: (value) {},
      hint: const Text('Select company'),
    );
  }

  Future<List<DropdownMenuItem<CompanyModel>>?> getAllCompanies() async {
    final companies = await _companyService.getAllCompany();
    if (companies == null) return null;
    final items = companies
        .map((e) => DropdownMenuItem<CompanyModel>(
            value: e,
            child: GeneralText(
              e.title ?? '',
              context: context,
            )))
        .toList();
    setState(() {});
    return items;
  }
}
