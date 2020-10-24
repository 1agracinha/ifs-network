import 'package:flutter/material.dart';
import 'package:ifs_network/widgets/feed/menu_suspenso.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Container(
            height: 80,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                ),
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10)),
                          color: Colors.grey[100],
                        ),
                        width: 220,
                        height: 33,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          style: TextStyle(
                            height: 1,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 10, bottom: 10, top: 0, right: 0),
                          ),
                        )),
                    InkWell(
                      onTap: () {},
                      splashColor: Colors.grey,
                      child: Container(
                          height: 33,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(10)),
                            color: Colors.grey[100],
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey[500],
                          )),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.dehaze_rounded,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                )
              ],
            ),
          ),
        ),
        AnimatedContainer(
            decoration: BoxDecoration(
              boxShadow: _expanded
                  ? [
                      BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          offset: Offset.fromDirection(1.0, 5.0))
                    ]
                  : null,
              color: Colors.white,
            ),
            width: double.infinity,
            duration: Duration(milliseconds: 400),
            height: _expanded ? 80 : 0,
            child: _expanded ? MenuSuspenso() : null)
      ],
    );
  }
}
