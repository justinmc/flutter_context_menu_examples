import 'package:flutter/material.dart';

class GlobalSelectionPage extends StatelessWidget {
  GlobalSelectionPage({
    Key? key,
  }) : super(key: key);

  static const String route = 'global-selection';
  static const String title = 'Global Selection Example';
  static const String subtitle = 'Context menus in and out of global selection';

  final TextEditingController _controller = TextEditingController(
    text: 'Right click anywhere outside of a field to show a custom menu.',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(GlobalSelectionPage.title),
      ),
      body: ContextMenu(
        buildContextMenu: (BuildContext context, ContextMenuController controller, Offset primaryAnchor, Offset? secondaryAnchor) {
          return DefaultTextSelectionToolbar(
            primaryAnchor: primaryAnchor,
            secondaryAnchor: secondaryAnchor,
            buttonDatas: <ContextualMenuButtonData>[
              ContextualMenuButtonData(
                onPressed: () {
                  controller.dispose();
                  Navigator.of(context).pop();
                },
                label: 'Back',
              ),
            ],
          );
        },
        child: Center(
          child: SelectionArea(
            child: SizedBox(
              width: 100.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text('Row 1'),
                  Text('Row 2'),
                  Text('Row 3'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    /*
    return Scaffold(
      appBar: AppBar(
        title: const Text(GlobalSelectionPage.title),
      ),
      body: ContextMenu(
        buildContextMenu: (BuildContext context, ContextMenuController controller, Offset primaryAnchor, Offset? secondaryAnchor) {
          return DefaultTextSelectionToolbar(
            primaryAnchor: primaryAnchor,
            secondaryAnchor: secondaryAnchor,
            buttonDatas: <ContextualMenuButtonData>[
              ContextualMenuButtonData(
                onPressed: () {
                  controller.dispose();
                  Navigator.of(context).pop();
                },
                label: 'Back',
              ),
            ],
          );
        },
        child: SelectionArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(height: 20.0),
              const Text('I am plain text'),
              Container(height: 200.0),
              TextField(controller: _controller),
              Container(height: 100.0),
              const Text('I am plain text'),
            ],
          ),
        ),
      ),
    );
    */
  }
}

