import 'dart:collection';

import 'package:flutter/material.dart';

class ReorderedButtonsPage extends StatelessWidget {
  ReorderedButtonsPage({
    Key? key,
  }) : super(key: key);

  static const String route = 'reordered-buttons';
  static const String title = 'Reordered Buttons';
  static const String subtitle = 'The usual buttons, but in a different order.';

  final TextEditingController _controllerNormal = TextEditingController(
    text: 'This button has the default buttons for reference.',
  );

  final TextEditingController _controllerReordered = TextEditingController(
    text: 'This field has reordered buttons.',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ReorderedButtonsPage.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controllerNormal,
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: _controllerReordered,
            buildContextualMenu: (BuildContext context, ContextualMenuController controller, EditableTextState editableTextState, Offset primaryAnchor, Offset? secondaryAnchor) {
              return TextSelectionToolbarButtonDatasBuilder(
                editableTextState: editableTextState,
                builder: (BuildContext context, List<ContextualMenuButtonData> buttonDatas) {
                  // Reorder the button datas by type.
                  final HashMap<DefaultContextualMenuButtonType, ContextualMenuButtonData> buttonDatasMap =
                      HashMap<DefaultContextualMenuButtonType, ContextualMenuButtonData>();
                  for (ContextualMenuButtonData buttonData in buttonDatas) {
                    buttonDatasMap[buttonData.type] = buttonData;
                  }
                  final List<ContextualMenuButtonData> reorderedButtonDatas = <ContextualMenuButtonData>[
                    if (buttonDatasMap.containsKey(DefaultContextualMenuButtonType.selectAll))
                      buttonDatasMap[DefaultContextualMenuButtonType.selectAll]!,
                    if (buttonDatasMap.containsKey(DefaultContextualMenuButtonType.paste))
                      buttonDatasMap[DefaultContextualMenuButtonType.paste]!,
                    if (buttonDatasMap.containsKey(DefaultContextualMenuButtonType.copy))
                      buttonDatasMap[DefaultContextualMenuButtonType.copy]!,
                    if (buttonDatasMap.containsKey(DefaultContextualMenuButtonType.cut))
                      buttonDatasMap[DefaultContextualMenuButtonType.cut]!,
                  ];
                  return DefaultTextSelectionToolbar(
                    primaryAnchor: primaryAnchor,
                    secondaryAnchor: secondaryAnchor,
                    buttonDatas: reorderedButtonDatas,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

