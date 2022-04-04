import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallChangesPage extends StatelessWidget {
  const SmallChangesPage({
    Key? key,
  }) : super(key: key);

  static const String route = 'small-changes';
  static const String title = 'Text Selection Toolbar Changes';
  static const String subtitle = 'Example of small changes to the text selection toolbar';

  @override
  Widget build(BuildContext context) {
    late final ContextualMenuAreaState? state;
    return Scaffold(
      appBar: AppBar(
        title: const Text(SmallChangesPage.title),
      ),
      // TODO(justinmc): Maybe the "Area" name is misleading.
      body: ContextualMenuArea(
        // TODO(justinmc): Display different items depending on selection.
        // Have to look up EditableText with global key.
        // Alternative: Special ContextualMenuArea that passes EditableTextState
        // in buildMenu.
        buildMenu: (BuildContext context, Offset primaryAnchor, Offset? secondaryAnchor) {
          return CupertinoDesktopTextSelectionToolbar(
            anchor: primaryAnchor,
            children: <Widget>[
              CupertinoDesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: () {
                  // Does nothing but close the menu for now...
                  state!.disposeContextualMenu();
                },
                text: 'Back',
              ),
            ],
          );
        },
        child: _DesktopContextualMenuGestureDetector(
          child: Builder(
            builder: (BuildContext context) {
              state = ContextualMenuArea.of(context);
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(height: 20.0),
                  // TODO(justinmc): Once you've made TextSelectionToolbarButtons public,
                  // then pass in buildContextualMenu here as part of the demo.
                  const TextField(),
                  Container(height: 200.0),
                  const CupertinoTextField(),
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
    _contextualMenuAreaState.showContextualMenu(details.globalPosition);
  }

  void _onTap() {
    _contextualMenuAreaState.disposeContextualMenu();
  }

  ContextualMenuAreaState get _contextualMenuAreaState {
    final ContextualMenuAreaState? state = ContextualMenuArea.of(context);
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
      onTap: _contextualMenuAreaState.contextualMenuIsVisible ? _onTap : null,
      child: widget.child,
    );
  }
}


