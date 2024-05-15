import 'package:job_finder_app/products/widgets/buttons/favourite_button.dart';
import 'package:job_finder_app/products/widgets/cards/job_card.dart';

final class JobPostingCard extends JobCard {
  JobPostingCard({super.key, required super.post, required super.context})
      : super(
          button: FavouriteButton(post: post),
        );
}
