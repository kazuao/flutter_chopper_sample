import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_chopper_sample/model/built_post.dart';
import 'package:provider/provider.dart';

import 'data/post_api_service.dart';

class SinglePostPage extends StatelessWidget {
  final int postId;

  const SinglePostPage({Key key, this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chopper Blog')),
      // body: FutureBuilder<Response>(
      body: FutureBuilder<Response<BuiltPost>>(
        future: Provider.of<PostApiService>(context).getPost(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // final Map post = json.decode(snapshot.data.bodyString);
            final post = snapshot.data.body;
            return _buildPost(post);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  // Padding _buildPost(Map post) {
  Padding _buildPost(BuiltPost post) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            // post['title'],
            post.title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          // Text(post['body']),
          Text(post.body),
        ],
      ),
    );
  }
}
