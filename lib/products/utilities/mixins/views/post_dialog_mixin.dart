import 'package:flutter/material.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:job_finder_app/products/utilities/enums/job_skills.dart';
import 'package:job_finder_app/products/utilities/enums/work_styles.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/states/company/company_cubit.dart';
import 'package:logger/logger.dart';

mixin PostDialogMixin<T extends StatefulWidget> on BaseViewMixin<T>, PostTransactionsMixin {
  late final TextEditingController workTitleController;
  late final TextEditingController contentController;
  late final TextEditingController locationController;
  late final TextEditingController pricePerHourController;
  late final TextEditingController workingStyleController;
  final ValueNotifier<List<DropdownMenuItem<CompanyModel>>> companyItemsValueNotifier =
      ValueNotifier<List<DropdownMenuItem<CompanyModel>>>([]);
  final ValueNotifier<List<DropdownMenuItem<WorkStyles>>> workStylesValueNotifier =
      ValueNotifier<List<DropdownMenuItem<WorkStyles>>>([]);
  late final ValueNotifier<List<DropdownMenuItem<JobSkills>>> jobSkillItems =
      ValueNotifier<List<DropdownMenuItem<JobSkills>>>([]);
  CompanyModel? selectedCompany;
  WorkStyles? selectedWorkStyle;
  final ValueNotifier<List<JobSkills>> selectedJobSkillsValueNotifier = ValueNotifier<List<JobSkills>>([]);
  List<JobSkills>? selectedJobSkills;

  @override
  void initState() {
    super.initState();
    mapCompaniesToDropDownItems();
    workTitleController = TextEditingController();
    contentController = TextEditingController();
    locationController = TextEditingController();
    pricePerHourController = TextEditingController();
    workingStyleController = TextEditingController();
    mapJobSkillsToDropDownItems();
    mapWorkStylesToDropDownItems();
  }

  @override
  void dispose() {
    super.dispose();
    workTitleController.dispose();
    contentController.dispose();
    locationController.dispose();
    pricePerHourController.dispose();
    workingStyleController.dispose();
  }

  void mapJobSkillsToDropDownItems() {
    final items = JobSkills.values
        .map((e) => DropdownMenuItem<JobSkills>(
            value: e,
            child: Row(
              children: [
                SizedBox(width: 50, child: Text(e.name)),
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  value: selectedJobSkillsValueNotifier.value.contains(e),
                  onChanged: (value) {},
                ),
              ],
            )))
        .toList();
    jobSkillItems.value = items;
  }

  void mapCompaniesToDropDownItems() {
    final companies = getCubit<CompanyCubit>().state.companies;
    if (companies == null) return;
    final items = companies.map((e) => DropdownMenuItem<CompanyModel>(value: e, child: Text(e.title ?? ''))).toList();
    companyItemsValueNotifier.value = items;
  }

  void mapWorkStylesToDropDownItems() {
    const workStyles = WorkStyles.values;
    final items = workStyles.map((e) => DropdownMenuItem<WorkStyles>(value: e, child: Text(e.name))).toList();
    workStylesValueNotifier.value = items;
  }

  void changeSelectedCompany(CompanyModel value) {
    Logger().i('Selected Company  : ${value.title}');
    selectedCompany = value;
  }

  void onChangedJobSkills(JobSkills value) {
    Logger().i('Selected Job Skills  : ${value.name}');
    if (selectedJobSkillsValueNotifier.value.contains(value)) {
      selectedJobSkillsValueNotifier.value.remove(value);
    } else {
      selectedJobSkillsValueNotifier.value.add(value);
    }

    mapJobSkillsToDropDownItems();
  }

  void changeSelectedWorkStyle(WorkStyles value) {
    Logger().i('Selected Work Style  : ${value.name}');
    selectedWorkStyle = value;
  }

  void closeDialog() {
    Navigator.pop(context);
  }
}
