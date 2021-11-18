import '../models/RequestHeaderEntry.dart';
import 'package:flutter/material.dart';

class RequestList extends StatefulWidget {
  final int entryCount;
  final Function builder;

  RequestList({
    @required this.builder,
    @required this.entryCount,
  });

  @override
  _RequestListState createState() => _RequestListState();
}

// TODO: Make this component stateless
class _RequestListState extends State<RequestList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              color: Colors.black,
              height: 1,
              indent: 14,
            ),
        itemCount: widget.entryCount,
        itemBuilder: (BuildContext context, int index) {
          return widget.builder(index);
        });
  }
}
