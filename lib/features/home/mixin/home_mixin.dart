import 'package:job_finder_app/features/home/view/home_view.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/company_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';

mixin HomeMixin on BaseViewMixin<HomeView>, PostTransactionsMixin, CompanyTransactionsMixin {
  Future<void> onPageRefreshed() {
    return Future.delayed(const Duration(seconds: 1), () async {
      await getAndSetCompanies();
      await getAllPostsAndConvertToViewModel();
    });
  }
}
