import 'package:flutter/material.dart';

class ModifiedActionPage extends StatelessWidget {
  ModifiedActionPage({
    Key? key,
  }) : super(key: key);

  static const String route = 'modified-action';
  static const String title = 'Modified Action';
  static const String subtitle = 'The copy button copies but also shows a menu.';

  final TextEditingController _controller = TextEditingController(
    text: 'Try using the copy button.',
  );

  DialogRoute _showDialog (BuildContext context) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
        const AlertDialog(title: Text('Copied, but also showed this dialog.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ModifiedActionPage.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            buildContextualMenu: (BuildContext context, ContextualMenuController controller, EditableTextState editableTextState, Offset primaryAnchor, Offset? secondaryAnchor) {
              return TextSelectionToolbarButtonDatasBuilder(
                editableTextState: editableTextState,
                builder: (BuildContext context, List<ContextualMenuButtonData> buttonDatas) {
                  // Modify the copy buttonData to show a dialog after copying.
                  final int copyButtonIndex = buttonDatas.indexWhere(
                    (ContextualMenuButtonData buttonData) {
                      return buttonData.type == DefaultContextualMenuButtonType.copy;
                    },
                  );
                  if (copyButtonIndex >= 0) {
                    final ContextualMenuButtonData copyButtonData =
                        buttonDatas[copyButtonIndex];
                    buttonDatas[copyButtonIndex] = copyButtonData.copyWith(
                      onPressed: () {
                        copyButtonData.onPressed();
                        Navigator.of(context).push(_showDialog(context));
                      },
                    );
                  }
                  return DefaultTextSelectionToolbar(
                    primaryAnchor: primaryAnchor,
                    secondaryAnchor: secondaryAnchor,
                    buttonDatas: buttonDatas,
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
