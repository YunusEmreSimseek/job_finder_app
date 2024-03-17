import 'package:flutter/material.dart';
import 'package:job_finder_app/features/job_detail/view/job_detail_view.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/cards/job_posting_card.dart';
import 'package:kartal/kartal.dart';

final class JobPostingCardItem extends InkWell {
  JobPostingCardItem({super.key, required BuildContext context, required PostViewModel job})
      : super(
            onTap: () {
              context.route.navigateToPage(JobDetailView(post: job));
            },
            child: JobPostingCard(post: job, context: context));
}
