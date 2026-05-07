import 'package:flutter/material.dart';
import 'package:flutter_tanstack_query/flutter_tanstack_query.dart';
import 'package:instant_ram/models/comment_model.dart';
import 'package:instant_ram/services/api_service.dart';
import 'package:instant_ram/widgets/add_comment_comment_modal.dart';
import 'package:instant_ram/widgets/other_comment.dart';

class CommentsModal extends StatelessWidget {
  const CommentsModal({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return UseQuery(
      options: QueryOptions<List<CommentModel>>(
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
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.separated(
                    itemCount: result.data?.length ?? 0,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final comment = result.data![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
