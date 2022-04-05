//import 'dart:collection' show LinkedHashMap;

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallChangesPage extends StatelessWidget {
  SmallChangesPage({
    Key? key,
  }) : super(key: key);

  static const String route = 'small-changes';
  static const String title = 'Text Selection Toolbar Changes';
  static const String subtitle = 'Example of small changes to the text selection toolbar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SmallChangesPage.title),
      ),
        // TODO(justinmc): Display different items depending on selection.
        // Have to look up EditableText with global key.
        // Alternative: Special ContextualMenuArea that passes EditableTextState
        // in buildMenu.
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(height: 20.0),
          // TODO(justinmc): Once you've made TextSelectionToolbarButtons public,
          // then pass in buildContextualMenu here as part of the demo.
          TextField(
            buildContextualMenu: (BuildContext context, EditableTextState editableTextState, Offset primaryAnchor, Offset? secondaryAnchor) {

              return DefaultTextSelectionToolbar(
                primaryAnchor: primaryAnchor,
                secondaryAnchor: secondaryAnchor,
                editableTextState: editableTextState,
              );
              /*
                builder: (BuildContext context, LinkedHashMap<DefaultContextualMenuButtonType, ContextualMenuButtonData> buttonDatas) {
                  return DefaultTextSelectionToolbarButtons(
                    buttonDatas: buttonDatas,
                  );
                },
              );
              */
            },
          ),
        ],
      ),
    );
  }
}
