part of '../home_view.dart';

final class PostSearchDelegate extends SearchDelegate {
  final List<PostViewModel>? posts;
  PostSearchDelegate(this.posts)
      : postsTitles = posts?.map((e) => e.title!).toList(),
        postsLocations = posts?.map((e) => e.location!).toList();

  List<String>? postsTitles;
  List<String>? postsLocations;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String>? resultForTitle =
        postsTitles?.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();

    List<String>? resultForLocations =
        postsLocations?.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();

    final postsByTitles = posts?.where((element) => resultForTitle!.contains(element.title)).toList();
    final postsByLocations = posts?.where((element) => resultForLocations!.contains(element.location)).toList();

    return ListView.builder(
      itemCount: (postsByTitles!.isNotEmpty)
          ? postsByTitles.length
          : (postsByLocations!.isNotEmpty ? postsByLocations.length : 0),
      itemBuilder: (BuildContext context, int index) {
        if (postsByTitles.isEmpty) {
          final post = postsByLocations![index];

          return InkWell(
              onTap: () => context.route.navigateToPage(JobDetailView(post: post)),
              child: JobPostingCard(post: post, context: context));
        }
        final post = postsByTitles[index];

        return InkWell(
            onTap: () => context.route.navigateToPage(JobDetailView(post: post)),
            child: JobPostingCard(post: post, context: context));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String>? resultForTitle =
        postsTitles?.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();

    List<String>? resultForLocations =
        postsLocations?.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();

    final postsByTitles = posts?.where((element) => resultForTitle!.contains(element.title)).toList();
    final postsByLocations = posts?.where((element) => resultForLocations!.contains(element.location)).toList();

    return Padding(
      padding: context.padding.low,
      child: ListView.builder(
        itemCount: (postsByTitles!.isNotEmpty)
            ? postsByTitles.length
            : (postsByLocations!.isNotEmpty ? postsByLocations.length : 0),
        itemBuilder: (BuildContext context, int index) {
          if (postsByTitles.isEmpty) {
            final post = postsByLocations![index];

            return InkWell(
                onTap: () => context.route.navigateToPage(JobDetailView(post: post)),
                child: JobPostingCard(post: post, context: context));
          }
          final post = postsByTitles[index];

          return InkWell(
              onTap: () => context.route.navigateToPage(JobDetailView(post: post)),
              child: JobPostingCard(post: post, context: context));
        },
      ),
    );
  }
}
