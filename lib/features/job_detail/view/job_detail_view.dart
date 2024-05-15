import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/features/job_detail/mixin/job_detail_mixin.dart';
import 'package:job_finder_app/products/utilities/constants/string_constant.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:job_finder_app/products/utilities/enums/job_skills.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/buttons/favourite_button.dart';
import 'package:job_finder_app/products/widgets/core/app_bar_with_title.dart';
import 'package:job_finder_app/products/widgets/images/company_icon.dart';
import 'package:job_finder_app/products/widgets/rows/job_date.dart';
import 'package:job_finder_app/products/widgets/rows/job_location.dart';
import 'package:job_finder_app/products/widgets/texts/general_button_text.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:job_finder_app/products/widgets/texts/semi_title_text.dart';
import 'package:job_finder_app/products/widgets/texts/small_text.dart';
import 'package:job_finder_app/products/widgets/texts/subtitle_text.dart';
import 'package:job_finder_app/products/widgets/texts/title_text.dart';
import 'package:kartal/kartal.dart';

final class JobDetailView extends StatefulWidget {
  const JobDetailView({super.key, required this.post});
  final PostViewModel post;
  @override
  State<JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> with PostTransactionsMixin, BaseViewMixin, JobDetailMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        final post = state.posts!.firstWhere((element) => element.id == widget.post.id);
        return Scaffold(
          appBar: AppBarWithTitle.onlyTitle(context: context, titleText: StringConstant.postDetail),
          body: Padding(
            padding: ProjectPadding.allNormal(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // AppBarTitleText(post.title ?? '', context: context),
                    TitleText(post.title ?? '', context: context),
                    const Spacer(),
                    FavouriteButton(
                      post: post,
                      // iconsize: IconSize.mid,
                      iconsize: IconSize.def,
                    ),
                  ],
                ),
                context.sized.emptySizedHeightBoxLow3x,
                _companyRow(context, post),
                context.sized.emptySizedHeightBoxLow3x,
                _postInformations(post, context),
                context.sized.emptySizedHeightBoxLow3x,
                // LargeTitleText('Job Description', context: context),
                SemiTitleText('Job Description', context: context),
                context.sized.emptySizedHeightBoxLow3x,
                // GeneralText(post.content ?? '', context: context, textAlign: TextAlign.start, maxLines: 13),
                GeneralText(post.content ?? '', context: context, textAlign: TextAlign.start, maxLines: 13),
                context.sized.emptySizedHeightBoxLow3x,
                // LargeTitleText('Skills Required', context: context),
                SemiTitleText('Skills Required', context: context),
                context.sized.emptySizedHeightBoxLow3x,
                _skillsLwb(context, post),
                context.sized.emptySizedHeightBoxLow3x,
                _applyButton(context)
              ],
            ),
          ),
        );
      },
    );
  }

  Row _companyRow(BuildContext context, PostViewModel post) {
    return Row(
      children: [
        CompanyIcon(context: context, imageUrl: post.company!.imageUrl ?? ''),
        context.sized.emptySizedWidthBoxNormal,
        // TitleText(post.company!.title ?? '', context: context),
        SubtitleText(post.company!.title ?? '', context: context),
      ],
    );
  }

  Row _postInformations(PostViewModel post, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        JobDate(date: post.date!, context: context),
        // context.sized.emptySizedWidthBoxLow3x,
        JobLocation(location: post.location ?? '', context: context),
        // context.sized.emptySizedWidthBoxLow3x,
        Row(
          children: [
            const Icon(Icons.style),
            context.sized.emptySizedWidthBoxLow,
            SizedBox(width: context.sized.dynamicWidth(.1), child: SmallText(post.toWorkStyle(), context: context))
          ],
        ),
        // context.sized.emptySizedWidthBoxLow3x,
        Row(
          children: [
            const Icon(Icons.euro),
            context.sized.emptySizedWidthBoxLow,
            SizedBox(
                width: context.sized.dynamicWidth(.1), child: SmallText('${post.pricePerHour}/h', context: context)),
          ],
        )
      ],
    );
  }

  SizedBox _skillsLwb(BuildContext context, PostViewModel post) {
    return SizedBox(
      width: double.infinity,
      height: context.sized.dynamicHeight(.06),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: post.jobSkills?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Padding(padding: context.padding.onlyRightNormal, child: post.jobSkills?[index].toImage());
        },
      ),
    );
  }

  ElevatedButton _applyButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async => await applyToJob(),
        child: Padding(
          padding: context.padding.normal,
          // child: TitleText('Apply Now', context: context),
          child: GeneralButtonText('Apply Now', context: context),
        ));
  }
}
