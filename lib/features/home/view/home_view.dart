import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/features/home/mixin/home_mixin.dart';
import 'package:job_finder_app/features/job_detail/view/job_detail_view.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/widgets/cards/job_posting_card.dart';
import 'package:job_finder_app/products/widgets/texts/large_title_text.dart';
import 'package:kartal/kartal.dart';

final class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with BaseViewMixin, HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: ProjectPadding.allNormalDynamic(context),
          child: Column(
            children: [
              LargeTitleText('Ana Sayfa', context: context),
              context.sized.emptySizedHeightBoxLow3x,
              BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  return SizedBox(
                    height: context.sized.dynamicHeight(.6),
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
