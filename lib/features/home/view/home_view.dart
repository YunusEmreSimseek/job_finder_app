import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/features/home/mixin/home_mixin.dart';
import 'package:job_finder_app/features/job_detail/view/job_detail_view.dart';
import 'package:job_finder_app/products/utilities/constants/string_constant.dart';
import 'package:job_finder_app/products/utilities/enums/font_size.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/company_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/cards/job_posting_card.dart';
import 'package:job_finder_app/products/widgets/core/app_bar_with_title.dart';
import 'package:job_finder_app/products/widgets/decorator/padding_decorator.dart';
import 'package:kartal/kartal.dart';

part 'sub_view/post_search_delegate.dart';

final class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with PostTransactionsMixin, BaseViewMixin, CompanyTransactionsMixin, HomeMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBarWithTitle.onlyLeading(
            titleText: StringConstant.home, context: context, leading: _searchButton(context, state)),
        body: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () async => await onPageRefreshed(),
            // child: Padding(
            //   padding: ProjectPadding.allNormalDynamic(context),
            child: PaddingDecorator.all(
              padding: context.sized.dynamicHeight(.015),
              child: SizedBox(
                height: context.sized.dynamicHeight(.75),
                child: ListView.builder(
                  itemCount: state.posts?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final currentItem = state.posts![index];
                    return Padding(
                      padding: context.padding.onlyBottomLow,
                      child: InkWell(
                          onTap: () => context.route.navigateToPage(JobDetailView(post: currentItem)),
                          child: JobPostingCard(post: currentItem, context: context)),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  IconButton _searchButton(BuildContext context, PostState state) {
    return IconButton(
        onPressed: () => showSearch(context: context, delegate: PostSearchDelegate(state.posts)),
        icon: Icon(Icons.search_outlined, size: IconSize.mid.value));
  }
}
