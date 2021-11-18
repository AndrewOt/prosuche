import './RequestList.dart';
import './RequestHeaderItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RequestItemBodyState extends StatefulWidget {
  final List<String> praises;
  final List<String> requests;

  RequestItemBodyState({this.requests, this.praises});

  RequestItemBody createState() => RequestItemBody();
}

class RequestItemBody extends State<RequestItemBodyState> {
  List<String> praiseDataList;
  List<String> requestDataList;

  @override
  void initState() {
    super.initState();
    // praiseDataList = widget.praises != null ? widget.praises : [];
    // requestDataList = widget.requests != null ? widget.requests : [];
    // praiseDataList.add("Input new praises here");
    // requestDataList.add("Input new request here");
  }

  @override
  Widget build(BuildContext context) {
    Widget praiseList = SizedBox.shrink();
    Widget requestList = SizedBox.shrink();

    // Build request list
    if (widget.requests != null) {
      if (widget.requests.length > 0) {
        requestList = RequestList(
          entryCount: widget.requests.length,
          builder: (index) {
            RequestHeaderItem(
              orderingIndex: index,
              displayString: widget.requests[index],
              requestDeleteCallback: () {},
            );
          },
        );
      }
    }

    // Build praise list
    if (widget.praises != null) {
      if (widget.praises.length > 0) {
        praiseList = RequestList(
          entryCount: widget.praises.length,
          builder: (index) {},
        );
      }
    }

    return Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0))
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Text("Requests"),
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
          ),
          requestList,
          Container(
            child: Text("Praises"),
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
          ),
          praiseList,
        ],
      ),
    );
  }
}
