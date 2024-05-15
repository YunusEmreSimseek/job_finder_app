import 'package:job_finder_app/products/widgets/buttons/edit_buton.dart';
import 'package:job_finder_app/products/widgets/cards/job_card.dart';

final class JobMyPostingCard extends JobCard {
  JobMyPostingCard({super.key, required super.post, required super.context})
      : super(button: EditButton(context: context, post: post));
}
