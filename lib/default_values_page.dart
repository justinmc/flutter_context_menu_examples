import 'package:flutter/material.dart';

class DefaultValuesPage extends StatelessWidget {
  DefaultValuesPage({
    Key? key,
  }) : super(key: key);

  static const String route = 'default-values';
  static const String title = 'Default API Values Example';
  static const String subtitle = 'Shows what happens when you pass various things into buildContextMenu.';

  final TextEditingController _controllerNone = TextEditingController(
    text: "When buildContextMenu isn't given at all.",
  );

  final TextEditingController _controllerNull = TextEditingController(
    text: "When buildContextMenu is explicitly given null.",
  );

  final TextEditingController _controllerCustom = TextEditingController(
    text: "When something custom is passed to buildContextMenu.",
  );

  DialogRoute _showDialog (BuildContext context, String message) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
        AlertDialog(title: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(DefaultValuesPage.title),
      ),
      body: ContextMenu(
        buildContextMenu: (BuildContext context, Offset primaryAnchor, [Offset? secondaryAnchor]) {
          return DefaultTextSelectionToolbar(
            primaryAnchor: primaryAnchor,
            secondaryAnchor: secondaryAnchor,
            buttonDatas: <ContextMenuButtonData>[
              ContextMenuButtonData(
                onPressed: () {
                  ContextMenuController.hide();
                  Navigator.of(context).pop();
                },
                label: 'Back',
              ),
            ],
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controllerNone,
            ),
            TextField(
              controller: _controllerNull,
              buildContextMenu: null,
            ),
            TextField(
              controller: _controllerCustom,
              buildContextMenu: (BuildContext context, EditableTextState editableTextState, Offset primaryAnchor, [Offset? secondaryAnchor]) {
                return TextSelectionToolbarButtonDatasBuilder(
                  editableTextState: editableTextState,
                  builder: (BuildContext context, List<ContextMenuButtonData> buttonDatas) {
                    return DefaultTextSelectionToolbar(
                      primaryAnchor: primaryAnchor,
                      secondaryAnchor: secondaryAnchor,
                      buttonDatas: <ContextMenuButtonData>[
                        ContextMenuButtonData(
                          label: 'Custom button',
                          onPressed: () {
                            ContextMenuController.hide();
                            Navigator.of(context).push(_showDialog(context, 'You clicked the custom button.'));
                          },
                        ),
                        ...buttonDatas,
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
