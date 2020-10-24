import 'package:flutter/material.dart';

class Posts extends StatelessWidget {
  final String texto;

  Posts(this.texto);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
      shadowColor: Colors.grey[50],
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  height: 60,
                  color: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://www.socialismocriativo.com.br/wp-content/uploads/2020/06/bob-esponja-calca-quadrada-nickelodeon-viacomcbs-3778837.jpg'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text('Bob Esponja'),
                          )
                        ],
                      ),
                      IconButton(icon: Icon(Icons.more_vert), onPressed: null)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Happy birthday to me!!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child: Image.network(
                              'https://i1.wp.com/telaviva.com.br/wp-content/uploads/2020/01/bob-esponja--scaled.jpg?resize=450%2C300&ssl=1')),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: 270,
                  height: 33,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Comentar',
                      hintStyle: TextStyle(
                        color: Colors.grey[300],
                      )
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.message_outlined, color: Colors.teal,), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
