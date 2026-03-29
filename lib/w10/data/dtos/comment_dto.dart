import 'package:advance_flutter/w10/model/comment/comment.dart';

class CommentDto {
  static const String commentTextKey = 'commentText';

  static Comment fromJson(String id, Map<String, dynamic> json) {
    assert(json[commentTextKey] is String);

    return Comment(
      id: id,
      commentText: json[commentTextKey]
    );
  }

  static Map<String, dynamic> toJson(Comment comment) {
    return {
      commentTextKey: comment.commentText
    };
  }
}
