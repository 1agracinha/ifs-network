import 'package:flutter/material.dart';

class MenuSuspenso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(children: [
          IconButton(
              icon: Icon(
                Icons.access_alarm,
                color: Theme.of(context).primaryColor,
                size: 35,
              ),
              onPressed: null),
          Text("Aff",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
              ))
        ]),
        Column(children: [
          IconButton(
              icon: Icon(
                Icons.access_alarm,
                color: Theme.of(context).primaryColor,
                size: 35,
              ),
              onPressed: null),
          Text("Aff",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
              ))
        ]),
        Column(children: [
          IconButton(
              icon: Icon(
                Icons.access_alarm,
                color: Theme.of(context).primaryColor,
                size: 35,
              ),
              onPressed: null),
          Text("Aff",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
              ))
        ]),
        Column(children: [
          IconButton(
              icon: Icon(
                Icons.access_alarm,
                color: Theme.of(context).primaryColor,
                size: 35,
              ),
              onPressed: null),
          Text("Aff",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
              ))
        ]),
      ],
    );
  }
}
