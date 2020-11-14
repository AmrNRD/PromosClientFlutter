
import 'user_model.dart';

class Post {
  int id;
  String content;
  String image;
  User user;
  DateTime lastUpdate;

  Post({this.id, this.content, this.image, this.user,this.lastUpdate});

  factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
      //This will be used to convert JSON objects that
      //are coming from querying the database and converting
      //it into a Post object
      id: data['id'],
      content: data['content'],
      image: data['image'],
      user: User.fromJson(data['user']),
      lastUpdate: DateTime.tryParse(data['last_update'].toString())
    );
  }

}
