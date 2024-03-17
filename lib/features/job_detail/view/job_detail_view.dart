import 'package:flutter/material.dart';
import 'package:job_finder_app/products/enums/job_skills.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/rows/job_date.dart';
import 'package:job_finder_app/products/widgets/rows/job_location.dart';
import 'package:job_finder_app/products/widgets/texts/app_bar_title_text.dart';
import 'package:job_finder_app/products/widgets/texts/general_bold_text.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:job_finder_app/products/widgets/texts/large_title_text.dart';
import 'package:job_finder_app/products/widgets/texts/subtitle_text.dart';
import 'package:job_finder_app/products/widgets/texts/title_text.dart';
import 'package:kartal/kartal.dart';

final class JobDetailView extends StatefulWidget {
  const JobDetailView({super.key, required this.post});
  final PostViewModel post;
  @override
  State<JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> {
  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: ProjectPadding.allNormal(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarTitleText(post.title ?? '', context: context),
            context.sized.emptySizedHeightBoxLow3x,
            _postInformations(post, context),
            context.sized.emptySizedHeightBoxLow3x,
            context.sized.emptySizedHeightBoxLow,
            _userInfoAndImages(context, post),
            context.sized.emptySizedHeightBoxLow3x,
            LargeTitleText('Job Description', context: context),
            context.sized.emptySizedHeightBoxLow3x,
            GeneralText(post.content ?? '', context: context, textAlign: TextAlign.start, maxLines: 13),
            context.sized.emptySizedHeightBoxLow3x,
            LargeTitleText('Skills Required', context: context),
            context.sized.emptySizedHeightBoxLow3x,
            _skillsLwb(context, post),
            context.sized.emptySizedHeightBoxLow3x,
            _applyButton(context)
          ],
        ),
      ),
    );
  }

  ElevatedButton _applyButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: Padding(
          padding: context.padding.normal,
          child: TitleText('Apply Now', context: context),
        ));
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

  Row _userInfoAndImages(BuildContext context, PostViewModel post) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          post.user!.imageUrl ?? '',
          height: 60,
        ),
        context.sized.emptySizedWidthBoxNormal,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralBoldText(post.user!.name ?? '', context: context),
            context.sized.emptySizedHeightBoxLow,
            SubtitleText(post.user!.location ?? '', context: context),
          ],
        ),
        const Spacer(),
        SizedBox(
          height: 50,
          child: Image.network(
            post.company!.imageUrl ?? '',
            height: 75,
          ),
        )
      ],
    );
  }

  Row _postInformations(PostViewModel post, BuildContext context) {
    return Row(
      children: [
        JobDate(date: post.date!, context: context),
        context.sized.emptySizedWidthBoxLow3x,
        JobLocation(location: post.location ?? '', context: context),
        context.sized.emptySizedWidthBoxLow3x,
        Row(
          children: [
            const Icon(Icons.style),
            context.sized.emptySizedWidthBoxLow,
            SizedBox(width: context.sized.dynamicWidth(.1), child: GeneralText(post.toWorkStyle(), context: context))
          ],
        ),
        context.sized.emptySizedWidthBoxLow3x,
        Row(
          children: [
            const Icon(Icons.euro),
            context.sized.emptySizedWidthBoxLow,
            SizedBox(
                width: context.sized.dynamicWidth(.1), child: GeneralText('${post.pricePerHour}/h', context: context)),
          ],
        )
      ],
    );
  }
}
