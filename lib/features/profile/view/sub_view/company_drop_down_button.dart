part of '../profile_view.dart';

final class _CompanyDropDownButton extends StatelessWidget {
  const _CompanyDropDownButton({
    required this.selectedCompany,
    required this.items,
    required this.changeCompany,
  });

  final ValueNotifier<CompanyModel?> selectedCompany;
  final List<DropdownMenuItem<CompanyModel>> items;
  final void Function(CompanyModel?) changeCompany;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.general.colorScheme.secondary),
        borderRadius: BorderRadius.all(context.border.normalRadius),
      ),
      width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(.062),
      child: ValueListenableBuilder<CompanyModel?>(
          valueListenable: selectedCompany,
          builder: (context, value, child) {
            return DropdownButton<CompanyModel>(
              padding: context.padding.normal,
              menuMaxHeight: context.sized.dynamicHeight(.2),
              isExpanded: true,
              icon: const Icon(Icons.business),
              underline: const SizedBox.shrink(),
              value: selectedCompany.value,
              items: items,
              onChanged: (value) => changeCompany(value),
            );
          }),
    );
  }
}
