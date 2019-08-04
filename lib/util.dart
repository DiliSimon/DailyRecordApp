import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Post> fetchPost(String t, int i) async {
  var val = i.toString();
  var url = 'http://cct-test.org/sguo/AppBackend/dailyRecord.php?text=' + t + '&val=' + val;
  print(url);
  final response =
  await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('response get');
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}