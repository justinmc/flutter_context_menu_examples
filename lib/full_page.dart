import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'context_menu_region.dart';

class FullPage extends StatelessWidget {
  FullPage({
    Key? key,
  }) : super(key: key);

  static const String route = 'full';
  static const String title = 'Full Example';
  static const String subtitle = 'Combining everything';

  final TextEditingController _controller = TextEditingController(
    text: 'Custom menus everywhere. me@example.com',
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
        title: const Text(FullPage.title),
      ),
      body: ContextMenuRegion(
        contextMenuBuilder: (BuildContext context, Offset primaryAnchor, [Offset? secondaryAnchor]) {
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
            ContextMenuRegion(
              contextMenuBuilder: (BuildContext context, Offset primaryAnchor, [Offset? secondaryAnchor]) {
                return DefaultTextSelectionToolbar(
                  primaryAnchor: primaryAnchor,
                  secondaryAnchor: secondaryAnchor,
                  buttonDatas: <ContextMenuButtonData>[
                    ContextMenuButtonData(
                      onPressed: () {
                        ContextMenuController.hide();
                        Navigator.of(context).push(_showDialog(context, 'Image saved! (not really though)'));
                      },
                      label: 'Save',
                    ),
                  ],
                );
              },
              child: SizedBox(
                width: 200.0,
                height: 200.0,
                child: Image.asset('flutter.jpg'),
              ),
            ),
            Container(height: 20.0),
            TextField(
              controller: _controller,
              contextMenuBuilder: (BuildContext context, EditableTextState editableTextState, Offset primaryAnchor, [Offset? secondaryAnchor]) {
                return EditableTextContextMenuButtonDatasBuilder(
                  editableTextState: editableTextState,
                  builder: (BuildContext context, List<ContextMenuButtonData> buttonDatas) {
                    final TextEditingValue value = editableTextState.textEditingValue;
                    if (_isValidEmail(value.selection.textInside(value.text))) {
                      buttonDatas.insert(0, ContextMenuButtonData(
                        label: 'Send email',
                        onPressed: () {
                          ContextMenuController.hide();
                          Navigator.of(context).push(_showDialog(context, 'You clicked send email'));
                        },
                      ));
                    }
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
      ),
    );
  }
}

bool _isValidEmail(String text) {
  return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
    .hasMatch(text);
}
