import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CrazyButtonsPage extends StatelessWidget {
  CrazyButtonsPage({
    Key? key,
  }) : super(key: key);

  static const String route = 'crazy-buttons';
  static const String title = 'Crazy Buttons';
  static const String subtitle = 'The usual buttons, but crazy looking';

  final TextEditingController _controller = TextEditingController(
    text: 'Show the menu to see weird-looking buttons.',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(CrazyButtonsPage.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(height: 20.0),
          TextField(
            controller: _controller,
            maxLines: 2,
            minLines: 2,
            buildContextMenu: (BuildContext context, EditableTextState editableTextState, Offset primaryAnchor, [Offset? secondaryAnchor]) {
              return TextSelectionToolbarButtonDatasBuilder(
                editableTextState: editableTextState,
                builder: (BuildContext context, List<ContextMenuButtonData> buttonDatas) {
                  return DefaultTextSelectionToolbar(
                    primaryAnchor: primaryAnchor,
                    secondaryAnchor: secondaryAnchor,
                    // Build the default buttons, but make them look crazy.
                    // Note that in a real project you may want to build
                    // different buttons depending on the platform.
                    children: buttonDatas.map((ContextMenuButtonData buttonData) {
                      assert(debugCheckHasCupertinoLocalizations(context));
                      final CupertinoLocalizations localizations = CupertinoLocalizations.of(context);
                      return CupertinoButton(
                        borderRadius: null,
                        color: const Color(0xffaaaa00),
                        disabledColor: const Color(0xffaaaaff),
                        onPressed: buttonData.onPressed,
                        padding: const EdgeInsets.all(10.0),
                        pressedOpacity: 0.7,
                        child: SizedBox(
                          width: 200.0,
                          child: Text(
                            CupertinoTextSelectionToolbarButton.getButtonLabel(buttonData, localizations),
                          ),
                        ),
                      );
                    }).toList(),
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
