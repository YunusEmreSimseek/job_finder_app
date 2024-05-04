import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/features/posts/mixin/posts_mixin.dart';
import 'package:job_finder_app/products/constants/string_constant.dart';
import 'package:job_finder_app/products/enums/icon_size.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/widgets/cards/job_posting_card.dart';
import 'package:job_finder_app/products/widgets/fields/dropdown_form_field.dart';
import 'package:job_finder_app/products/widgets/loading/loading_with_child.dart';
import 'package:job_finder_app/products/widgets/texts/app_bar_title_text.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

final class PostsView extends StatefulWidget {
  const PostsView({super.key});
  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> with BaseViewMixin, PostsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitleText(StringConstant.postsTitle, context: context),
        actions: [
          LoadingWithChild(
              child: IconButton(icon: Icon(Icons.add_circle, size: IconSize.def.value), onPressed: () => createAd()))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: ProjectPadding.allNormalDynamic(context),
          child: Center(
            child: Column(
              children: [
                DropDownFormField(
                    value: 0,
                    items: [
                      DropdownMenuItem<int>(
                        value: 0,
                        child: GeneralText(
                          StringConstant.postsFavourite,
                          context: context,
                        ),
                      ),
                      DropdownMenuItem<int>(
                        value: 1,
                        child: GeneralText(
                          StringConstant.postMyPosts,
                          context: context,
                        ),
                      )
                    ],
                    onChanged: (value) => onChangedDropDownButton(value),
                    prefixIcon: const Icon(Icons.style)),
                // DropdownButtonFormField(
                //   value: 0,
                //   padding: context.padding.horizontalHigh,
                //   isExpanded: true,
                //   items: const [
                //     DropdownMenuItem<int>(
                //       value: 0,
                //       child: Text('favourite posts'),
                //     ),
                //     DropdownMenuItem<int>(
                //       value: 1,
                //       child: Text('My Posts'),
                //     )
                //   ],
                //   onChanged: (value) => onChangedDropDownButton(value ?? 0),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ElevatedButton(
                //         onPressed: () => changePostSourceToFavourites(),
                //         child: GeneralText(StringConstant.adsFavouriteAds, context: context)),
                //     context.sized.emptySizedWidthBoxHigh,
                //     ElevatedButton(
                //         onPressed: () => changePostSourceToCreated(),
                //         child: GeneralText(StringConstant.adsMyAds, context: context)),
                //   ],
                // ),
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
                              child: InkWell(
                                  onTap: () =>
                                      value ? navigateToEditDialog(currentItem) : navigateToJobDetailView(currentItem),
                                  child: JobPostingCard(post: currentItem, context: context)),
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
    );
  }
}
