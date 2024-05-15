import 'package:flutter/material.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/images/company_icon.dart';
import 'package:job_finder_app/products/widgets/rows/job_date.dart';
import 'package:job_finder_app/products/widgets/rows/job_location.dart';
import 'package:job_finder_app/products/widgets/rows/job_price_per_hour.dart';
import 'package:job_finder_app/products/widgets/texts/semi_title_text.dart';
import 'package:job_finder_app/products/widgets/texts/small_text.dart';
import 'package:kartal/kartal.dart';

class JobCard extends Card {
  JobCard({
    super.key,
    required PostViewModel post,
    required BuildContext context,
    required Widget button,
  }) : super(
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
                _jobStyleAndPriceColumn(post, context, button),
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
          SizedBox(
            width: context.sized.dynamicWidth(.55),
            child: SemiTitleText(
              post.title ?? '',
              context: context,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
          ),
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
        context.sized.emptySizedWidthBoxLow,
        JobLocation(location: post.location ?? '', context: context),
      ],
    );
  }

  static SizedBox _jobStyleAndPriceColumn(PostViewModel post, BuildContext context, Widget button) {
    return SizedBox(
      width: context.sized.dynamicWidth(.13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          context.sized.emptySizedHeightBoxLow,
          button,
          context.sized.emptySizedHeightBoxLow,
          SmallText(post.toWorkStyle(), context: context),
          context.sized.emptySizedHeightBoxLow,
          JobPricePerHour(pricePerHour: post.pricePerHour ?? '', context: context),
        ],
      ),
    );
  }
}
