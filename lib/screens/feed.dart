import 'package:flutter/material.dart';
import 'package:ifs_network/widgets/feed/menu_bar.dart';
import 'package:ifs_network/widgets/feed/posts.dart';

class Feed extends StatelessWidget {
  final postagens = ['GRA', 'SI'];
  @override
  Widget build(BuildContext context) {
    // double maxHeight = MediaQuery.of(context).size.height * 0.836;
    return Column(
      children: [
        MenuBar(),
        Expanded(
          child: Container(
            color: Colors.grey[50],
              child: ListView.builder(
            itemCount: postagens.length,
            itemBuilder: (ctx, i) {
              return Posts(postagens[i]);
            },
          )),
        )
      ],
    );
  }
}
