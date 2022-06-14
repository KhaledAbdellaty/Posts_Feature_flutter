import '../../domain/entities/post_entity.dart';

class PostModel extends Post {
  const PostModel({required String title, required String body, int? id})
      : super(title: title, body: body, id: id);
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }
  Map<String, dynamic> toJson() {
    final map = {'id': id, 'title': title, 'body': body};
    return map;
  }
}
