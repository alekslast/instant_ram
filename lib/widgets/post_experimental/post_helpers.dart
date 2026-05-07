import 'package:flutter/material.dart';
import 'package:instant_ram/helpers/format_time_since_post_upload.dart';
import 'package:instant_ram/models/post_model.dart';

class PostHelpers {
  static Widget buildDateWidget(DateTime creationDate) {
    return formatTimeSincePostUpload(creationDate);
  }

  static bool isVideo(PostModel post) {
    return post.type == 'video';
  }
}
