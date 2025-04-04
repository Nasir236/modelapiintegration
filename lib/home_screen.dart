// ignore_for_file: override_on_non_overriding_member

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modelapiintegration/model/post_model.dart';

class Apiclass extends StatefulWidget {
  const Apiclass({super.key});

  @override
  State<Apiclass> createState() => _ApiclassState();
}

class _ApiclassState extends State<Apiclass> {
  List<PostModel> postdata = [];

  Future<List<PostModel>> getpostApi() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    for (var eachMap in responseBody) {
      postdata.add(PostModel.fromJson(eachMap));
    }
    return postdata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Integration'),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
        future: getpostApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data?[index].id.toString() ?? "No ID"),
                  subtitle: Text(
                    (snapshot.data?[index].name.toString() ?? "No Name"),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
