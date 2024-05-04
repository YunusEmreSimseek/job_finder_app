import 'package:flutter/material.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/buttons/favourite_button.dart';
import 'package:job_finder_app/products/widgets/images/company_icon.dart';
import 'package:job_finder_app/products/widgets/rows/job_date.dart';
import 'package:job_finder_app/products/widgets/rows/job_location.dart';
import 'package:job_finder_app/products/widgets/rows/job_price_per_hour.dart';
import 'package:job_finder_app/products/widgets/texts/subtitle_text.dart';
import 'package:job_finder_app/products/widgets/texts/title_text.dart';
import 'package:kartal/kartal.dart';

class JobPostingCard extends Card {
  JobPostingCard({super.key, required PostViewModel post, required BuildContext context})
      : super(
            child: Padding(
          padding: context.padding.low,
          child: SizedBox(
            height: context.sized.dynamicHeight(.125),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CompanyIcon(context: context, imageUrl: post.company!.imageUrl ?? ''),
                context.sized.emptySizedWidthBoxNormal,
                _jobPostBody(context, post),
                context.sized.emptySizedWidthBoxLow,
                _jobStyleAndPriceColumn(post, context)
              ],
            ),
          ),
        ));

  static SizedBox _jobPostBody(BuildContext context, PostViewModel post) {
    return SizedBox(
      width: context.sized.dynamicWidth(.55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText(post.title ?? '', context: context),
          context.sized.emptySizedHeightBoxLow,
          _jobDateAndLocationRow(post, context),
        ],
      ),
    );
  }

  static Row _jobDateAndLocationRow(PostViewModel post, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        JobDate(date: post.date!, context: context),
        context.sized.emptySizedWidthBoxLow3x,
        JobLocation(location: post.location ?? '', context: context),
      ],
    );
  }

  static SizedBox _jobStyleAndPriceColumn(PostViewModel post, BuildContext context) {
    return SizedBox(
      width: context.sized.dynamicWidth(.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FavouriteButton(
            post: post,
          ),
          SubtitleText(post.toWorkStyle(), context: context),
          context.sized.emptySizedHeightBoxLow,
          JobPricePerHour(pricePerHour: post.pricePerHour ?? '', context: context),
        ],
      ),
    );
  }
}
