import 'package:flutter/material.dart';
import 'package:flutter_tanstack_query/flutter_tanstack_query.dart';
import 'package:instant_ram/services/api_service.dart';
import 'package:instant_ram/services/post_provider.dart';
import 'package:instant_ram/widgets/add_comment_comment_modal.dart';
import 'package:instant_ram/widgets/other_comment.dart';
import 'package:instant_ram/widgets/post/post_caption.dart';
import 'package:provider/provider.dart';

class CaptionAndCommentsModal extends StatelessWidget {
  const CaptionAndCommentsModal({super.key});

  @override
  Widget build(BuildContext context) {
    // final post = context.watch<PostProvider>().globalPost;
    // final postId = post?.id ?? 0;
    // final postCaption = post?.caption ?? '';
    // final authorNickname = post?.authorName ?? '';

    final postId = context.select<PostProvider, int>(
      (provider) => provider.globalPost?.id ?? 0,
    );
    final postCaption = context.select<PostProvider, String>(
      (provider) => provider.globalPost?.caption ?? '',
    );
    final authorNickname = context.select<PostProvider, String>(
      (provider) => provider.globalPost?.authorName ?? '',
    );

    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return UseQuery(
      options: QueryOptions(
        queryKey: ['comments-for-$postId'],
        queryFn: () => ApiService.fetchComments(postId),
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                  child: ListView.builder(
                    itemCount: (result.data?.length ?? 0) + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return PostCaption(
                          caption: postCaption,
                          nickname: authorNickname,
                        );
                      }

                      final comment = result.data![index - 1];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: OtherComment(
                          authorName: comment.authorNickname,
                          likes: comment.likes,
                          text: comment.text,
                        ),
                      );
                    },
                  ),
                ),

                Positioned(
                  bottom: keyboardHeight,
                  child: Container(
                    height: 50,
                    color: Color.fromRGBO(28, 28, 34, 1),
                    child: AddCommentCommentModal(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
