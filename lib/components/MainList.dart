import "dart:developer";
import 'RequestList.dart';
import 'RequestHeaderItem.dart';
import 'package:flutter/material.dart';
import '../models/RequestHeaderEntry.dart';
import '../utilities/StorageInterface.dart';

class MainList extends StatefulWidget {
  @override
  _MainListState createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  List<RequestHeaderEntry> entries = <RequestHeaderEntry>[];

  @override
  void initState() {
    super.initState();
    StorageInterface.getSavedEntries().then((List<RequestHeaderEntry> results) {
      entries.addAll(results);
      entries
          .add(new RequestHeaderEntry(description: "Input new request here"));
      setState(() {
        return entries;
      });
    }).catchError((error) {
      log("error $error");
    });
  }

  void saveNewRequestItem(requestDescription) {
    setState(() {
      // We need to remove the addition item because we want it to appear at
      // the end of the list. If we don't remove it and re-add it,
      // it will always appear at it's initial position from initState.
      entries.removeAt(entries.length - 1);
      entries.add(new RequestHeaderEntry(description: requestDescription));
      entries
          .add(new RequestHeaderEntry(description: "Input new request here"));
    });

    StorageInterface.saveEntries(entries);
  }

  void handleRemoveRequestItem(RequestHeaderEntry request) {
    setState(() {
      if (request != null) {
        entries.remove(request);
      }
    });

    StorageInterface.saveEntries(entries);
  }

  @override
  Widget build(BuildContext context) {
    return RequestList(
      entryCount: entries.length,
      builder: (index) {
        return RequestHeaderItem(
          orderingIndex: index,
          requestItem: entries[index],
          requestSaveCallback: saveNewRequestItem,
          requestDeleteCallback: handleRemoveRequestItem,
        );
      },
    );
  }
}
