import 'RequestItemBody.dart';
import 'package:flutter/material.dart';
import '../models/RequestHeaderEntry.dart';

class RequestHeaderItem extends StatefulWidget {
  final orderingIndex;
  final displayString;
  final Function requestSaveCallback;
  final Function requestDeleteCallback;
  final RequestHeaderEntry requestItem;

  RequestHeaderItem({
    // TODO: come back and fix this nonsense. We need fix this contract lol
    this.requestItem,
    this.displayString,
    this.requestSaveCallback,
    @required this.orderingIndex,
    @required this.requestDeleteCallback,
  });

  _RequestHeaderItemState createState() => _RequestHeaderItemState();
}

class _RequestHeaderItemState extends State<RequestHeaderItem>
    with SingleTickerProviderStateMixin {
  Widget title;
  Widget openIcon;
  Widget removeIcon;

  void saveRequest(requestDescription) {
    if (widget.requestSaveCallback != null) {
      widget.requestSaveCallback(requestDescription);
    }
  }

  void deleteRequest() {
    if (widget.requestItem != null) {
      widget.requestDeleteCallback(widget.requestItem);
    } else {
      widget.requestDeleteCallback(widget.displayString);
    }
  }

  _handleOpenModal() {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => RequestItemBodyState(
            requests: widget.requestItem.requests,
            praises: widget.requestItem.praises));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    var textToDisplay;
    if (widget.displayString != null && widget.displayString.length > 0) {
      textToDisplay = widget.displayString;
    } else if (widget.requestItem != null &&
        widget.requestItem.description != null) {
      textToDisplay = widget.requestItem.description;
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    // Build the TextField based on if there is text in the request item object.
    if (textToDisplay != 'Input new request here') {
      title = Container(
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          obscureText: false,
          controller: TextEditingController(text: textToDisplay),
        ),
        width: screenWidth - 75,
      );

      openIcon = Container(
        child: TextButton(
          child: Icon(
            Icons.open_in_new,
            color: Colors.black,
            semanticLabel: "Arrow button to toggle panel open and close.",
          ),
          onPressed: _handleOpenModal,
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
          ),
        ),
        width: 35,
      );

      removeIcon = Container(
        child: TextButton(
            child: Icon(
              Icons.delete,
              color: Colors.black,
              semanticLabel: "Trash can to delete the current entry.",
            ),
            onPressed: this.deleteRequest,
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
            )),
        width: 35,
      );

      if (widget.requestSaveCallback != null) {
        children.add(openIcon);
      }
      children.add(title);
      children.add(removeIcon);
    } else {
      title = Container(
        child: TextField(
          autofocus: true,
          onSubmitted: saveRequest,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: 'Input new request here',
          ),
        ),
        width: screenWidth,
        margin: EdgeInsets.only(left: 15),
      );

      children.add(title);
    }

    return Wrap(
      spacing: 1.0,
      runSpacing: 5.0,
      children: children,
    );
  }
}
