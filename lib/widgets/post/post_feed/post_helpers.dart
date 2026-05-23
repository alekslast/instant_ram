import 'package:flutter/cupertino.dart';
import 'package:instant_ram/helpers/format_time_since_post_upload.dart';

class PostHelpers {
  static Widget buildDateWidget(DateTime creationDate) {
    return formatTimeSincePostUpload(creationDate);
  }

  static bool isVideo(String postType) {
    return postType == 'video';
  }
}
