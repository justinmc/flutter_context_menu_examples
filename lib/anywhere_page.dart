import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnywherePage extends StatelessWidget {
  AnywherePage({
    Key? key,
  }) : super(key: key);

  static const String route = 'anywhere';
  static const String title = 'Contextual Menu Anywhere Example';
  static const String subtitle = 'A ContextualMenu outside of a text field.';

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
        buildMenu: (BuildContext context, Offset primaryAnchor, Offset? secondaryAnchor) {
          return CupertinoDesktopTextSelectionToolbar(
            anchor: primaryAnchor,
            children: <Widget>[
              CupertinoDesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: () {
                  contextualMenuController!.hide();
                  Navigator.of(context).pop();
                },
                text: 'Back',
              ),
            ],
          );
        },
        child: _DesktopContextualMenuGestureDetector(
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

// TODO(justinmc): This should be provided by the framework.
class _DesktopContextualMenuGestureDetector extends StatefulWidget {
  const _DesktopContextualMenuGestureDetector({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  State<_DesktopContextualMenuGestureDetector> createState() => _DesktopContextualMenuGestureDetectorState();
}

class _DesktopContextualMenuGestureDetectorState extends State<_DesktopContextualMenuGestureDetector> {
  void _onSecondaryTapUp(TapUpDetails details) {
    _contextualMenuController.show(context, details.globalPosition);
  }

  void _onTap() {
    _contextualMenuController.hide();
  }

  ContextualMenuController get _contextualMenuController {
    final ContextualMenuController? state = InheritedContextualMenu.of(context);
    assert(state != null, 'No ContextualMenuArea found above in the Widget tree.');
    return state!;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // TODO(justinmc): Secondary tapping when the menu is open should fade out
      // and then fade in to show again at the new location.
      onSecondaryTapUp: _onSecondaryTapUp,
      // TODO(justinmc): Ok to look this up in build?
      onTap: _contextualMenuController.isVisible ? _onTap : null,
      child: widget.child,
    );
  }
}


