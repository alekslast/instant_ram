import 'package:flutter/material.dart';
import 'package:flutter_tanstack_query/flutter_tanstack_query.dart';
import 'package:instant_ram/models/post_model.dart';
import 'package:instant_ram/services/api_service.dart';
import 'package:instant_ram/widgets/post_experimental/post_widget.dart';
import 'package:instant_ram/widgets/stories_scrollbar.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UseQuery(
        options: QueryOptions<List<PostModel>>(
          queryKey: ['posts'],
          queryFn: () => ApiService.fetchPosts(),
          staleTime: Duration(minutes: 5),
          cacheTime: Duration(minutes: 30),
          refetchOnWindowFocus: true,
          refetchOnReconnect: true,
        ),
        builder: (context, result) {
          if (result.isLoading && !result.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.isError && !result.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error" ${result.error}'),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () => result.refetch(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: result.refetch,
            child: ListView.separated(
              itemCount: (result.data?.length ?? 0) + 1,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return StoriesScrollbar();
                }

                final post = result.data![index - 1];
                return PostWidget(post: post);
              },
            ),
          );
        },
      ),
    );
  }
}
