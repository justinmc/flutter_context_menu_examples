import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'context_menu_region.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    Key? key,
  }) : super(key: key);

  static const String route = 'image';
  static const String title = 'ContextMenu on an Image';
  static const String subtitle = 'A ContextMenu the displays on an Image widget';
  static const String url = '$kCodeUrl/image_page.dart';

  DialogRoute _showDialog (BuildContext context) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
        const AlertDialog(title: Text('Image saved! (not really though)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ImagePage.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () async {
              if (!await launchUrl(Uri.parse(url))) {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(height: 200.0),
          ContextMenuRegion(
            contextMenuBuilder: (BuildContext context, Offset offset) {
              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: TextSelectionToolbarAnchors(
                  primaryAnchor: offset,
                ),
                buttonItems: <ContextMenuButtonItem>[
                  ContextMenuButtonItem(
                    onPressed: () {
                      ContextMenuController.removeAny();
                      Navigator.of(context).push(_showDialog(context));
                    },
                    label: 'Save',
                  ),
                ],
              );
            },
            child: const SizedBox(
              width: 200.0,
              height: 200.0,
              child: FlutterLogo(),
            ),
          ),
          Container(height: 20.0),
          const Text(
            'Right click or long press on the image to see a special menu.',
          ),
        ],
      ),
    );
  }
}
