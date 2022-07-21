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
            contextMenuBuilder: (BuildContext context, EditableTextState editableTextState, Offset primaryAnchor, [Offset? secondaryAnchor]) {
              return EditableTextContextMenuButtonDatasBuilder(
                editableTextState: editableTextState,
                builder: (BuildContext context, List<ContextMenuButtonData> buttonDatas) {
                  // Reorder the button datas by type.
                  final HashMap<ContextMenuButtonType, ContextMenuButtonData> buttonDatasMap =
                      HashMap<ContextMenuButtonType, ContextMenuButtonData>();
                  for (ContextMenuButtonData buttonData in buttonDatas) {
                    buttonDatasMap[buttonData.type] = buttonData;
                  }
                  final List<ContextMenuButtonData> reorderedButtonDatas = <ContextMenuButtonData>[
                    if (buttonDatasMap.containsKey(ContextMenuButtonType.selectAll))
                      buttonDatasMap[ContextMenuButtonType.selectAll]!,
                    if (buttonDatasMap.containsKey(ContextMenuButtonType.paste))
                      buttonDatasMap[ContextMenuButtonType.paste]!,
                    if (buttonDatasMap.containsKey(ContextMenuButtonType.copy))
                      buttonDatasMap[ContextMenuButtonType.copy]!,
                    if (buttonDatasMap.containsKey(ContextMenuButtonType.cut))
                      buttonDatasMap[ContextMenuButtonType.cut]!,
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
