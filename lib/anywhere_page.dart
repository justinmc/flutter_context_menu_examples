import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnywherePage extends StatelessWidget {
  AnywherePage({
    Key? key,
  }) : super(key: key);

  static const String route = 'anywhere';
  static const String title = 'Contextual Menu Anywhere Example';
  static const String subtitle = 'A ContextualMenu outside of a text field';

  final TextEditingController _controller = TextEditingController(
    text: 'Right click anywhere outside of a field to show a custom menu.',
  );

  @override
  Widget build(BuildContext context) {
    late final ContextualMenuController? contextualMenuController;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AnywherePage.title),
      ),
      body: InheritedContextualMenu(
        buildMenu: (BuildContext context, ContextualMenuController controller, Offset primaryAnchor, Offset? secondaryAnchor) {
          return DefaultTextSelectionToolbar(
            primaryAnchor: primaryAnchor,
            secondaryAnchor: secondaryAnchor,
            buttonDatas: <ContextualMenuButtonData>[
              ContextualMenuButtonData(
                onPressed: () {
                  contextualMenuController!.hide();
                  Navigator.of(context).pop();
                },
                label: 'Back',
              ),
            ],
          );
        },
        child: ContextualMenuGestureDetector(
          child: Builder(
            builder: (BuildContext context) {
              contextualMenuController = InheritedContextualMenu.of(context);
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(height: 20.0),
                  const TextField(),
                  Container(height: 200.0),
                  CupertinoTextField(controller: _controller),
                  Container(height: 100.0),
                  Container(
                    color: Colors.white,
                    child: EditableText(
                      controller: TextEditingController(),
                      focusNode: FocusNode(),
                      style: Typography.material2018().black.subtitle1!,
                      cursorColor: Colors.blue,
                      backgroundCursorColor: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
