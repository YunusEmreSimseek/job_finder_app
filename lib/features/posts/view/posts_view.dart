import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/features/posts/mixin/posts_mixin.dart';
import 'package:job_finder_app/products/utilities/constants/string_constant.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/company_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/job_applicants_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/widgets/cards/job_my_posting_card.dart';
import 'package:job_finder_app/products/widgets/cards/job_posting_card.dart';
import 'package:job_finder_app/products/widgets/core/app_bar_with_title.dart';
import 'package:job_finder_app/products/widgets/dialogs/text_dialog.dart';
import 'package:job_finder_app/products/widgets/fields/dropdown_form_field.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

final class PostsView extends StatefulWidget {
  const PostsView({super.key});
  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView>
    with PostTransactionsMixin, BaseViewMixin, JobApplicantsTransactionsMixin, CompanyTransactionsMixin, PostsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithTitle.onlyActions(
          titleText: StringConstant.postsTitle, context: context, actions: _addPostButton()),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async => await onPageRefreshed(),
          child: Padding(
            padding: ProjectPadding.allNormalDynamic(context),
            child: Center(
              child: Column(
                children: [
                  DropDownFormField<int>(
                      value: 0,
                      items: [
                        // DropdownMenuItem<int>(value: 0, child: Text(StringConstant.postsFavourite)),
                        DropdownMenuItem<int>(
                            value: 0, child: GeneralText(StringConstant.postsFavourite, context: context)),
                        // DropdownMenuItem<int>(value: 1, child: Text(StringConstant.postMyPosts))
                        DropdownMenuItem<int>(
                            value: 1, child: GeneralText(StringConstant.postMyPosts, context: context))
                      ],
                      onChanged: (value) => onChangedDropDownButton(value),
                      prefixIconData: Icons.style),
                  context.sized.emptySizedHeightBoxLow3x,
                  ValueListenableBuilder(
                    valueListenable: isCreatedPosts,
                    builder: (context, value, child) => BlocBuilder<PostCubit, PostState>(
                      builder: (context, state) {
                        return SizedBox(
                          height: context.sized.dynamicHeight(.6),
                          child: ListView.builder(
                            itemCount: value ? state.createdPosts?.length ?? 0 : state.favouritesPosts?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final currentItem = value ? state.createdPosts![index] : state.favouritesPosts![index];
                              return Padding(
                                padding: context.padding.onlyBottomLow,
                                child: Dismissible(
                                  key: Key(currentItem.id!),
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (direction) async => await confirmDismissed(),
                                  onDismissed: (direction) async {
                                    safeOperation(() async => await removePost(currentItem.id!));
                                    TextDialog.show(context: context, text: 'Post has been deleted');
                                  },
                                  child: InkWell(
                                      onTap: () => value
                                          ? showApplicantsDialog(currentItem)
                                          : navigateToJobDetailView(currentItem),
                                      child: value
                                          ? JobMyPostingCard(post: currentItem, context: context)
                                          : JobPostingCard(post: currentItem, context: context)),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconButton _addPostButton() =>
      IconButton(icon: Icon(Icons.add_circle, size: IconSize.def.value), onPressed: () => showCreatePostDialog());
}
