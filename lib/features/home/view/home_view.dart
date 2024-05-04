import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/features/home/mixin/home_mixin.dart';
import 'package:job_finder_app/features/job_detail/view/job_detail_view.dart';
import 'package:job_finder_app/products/constants/string_constant.dart';
import 'package:job_finder_app/products/enums/icon_size.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/cards/job_posting_card.dart';
import 'package:job_finder_app/products/widgets/texts/app_bar_title_text.dart';
import 'package:kartal/kartal.dart';

part 'sub_view/post_search_delegate.dart';

final class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with BaseViewMixin, HomeMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => showSearch(context: context, delegate: PostSearchDelegate(state.posts)),
              icon: Icon(
                Icons.search_outlined,
                size: IconSize.mid.value,
              )),
          title: AppBarTitleText(StringConstant.home, context: context),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: ProjectPadding.allNormalDynamic(context),
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
      );
    });
  }
}
