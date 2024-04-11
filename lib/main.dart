import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';
void main()
{
  runApp(MaterialApp(debugShowMaterialGrid: false,debugShowCheckedModeBanner: false,home: Text_Editor(),));
}

class Text_Editor extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, debugShowMaterialGrid: false,
      title: 'Flutter Text Editor',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: Text_edit(title: 'Text Editor'),
    );
  }
}

class Text_edit extends StatefulWidget {
  Text_edit({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Text_editState createState() => _Text_editState();
}

class _Text_editState extends State<Text_edit> {
  String result = '';
  final HtmlEditorController _text_ = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          _text_.clearFocus();
        }
      },
      child: Scaffold(
        appBar: PreferredSize(child:
        AppBar(backgroundColor: Colors.lightGreen.shade800,
          title: Text("Text Edit"),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  if (kIsWeb) {
                    _text_.reloadWeb();
                  } else {
                    _text_.editorController!.reload();
                  }
                })
          ],
        ), preferredSize: Size(0, 55)),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Row(children: [
              Container(child: Text(widget.title),),
            ],),
            HtmlEditor(
              controller: _text_,
              htmlEditorOptions: HtmlEditorOptions(
                hint: 'Type Text ',
                shouldEnsureVisible: true,
              ),
              htmlToolbarOptions: HtmlToolbarOptions(
                toolbarPosition: ToolbarPosition.aboveEditor,

                toolbarType: ToolbarType.nativeScrollable,

                onButtonPressed:
                    (ButtonType type, bool? status, Function? updateStatus) {

                  return true;
                },
                onDropdownChanged: (DropdownType type, dynamic changed,
                    Function(dynamic)? updateSelectedItem) {
                  return true;
                },
                mediaLinkInsertInterceptor:
                    (String url, InsertFileType type) {

                  return true;
                },
                mediaUploadInterceptor:
                    (PlatformFile file, InsertFileType type) async {
                  return true;
                },
              ),
              otherOptions: OtherOptions(height: 550),
              callbacks: Callbacks(
                  onBeforeCommand: (String? currentHtml) {},
                  onChangeContent: (String? changed) {},
                  onEnter: () {},
                  onFocus: () {},
                  onBlur: () {},
                  onChangeCodeview: (String? changed) {},
                  onChangeSelection: (EditorSettings settings) {},
                  onDialogShown: () {},
                  onBlurCodeview: () {},
                  onInit: () {},
                  onImageUploadError: (FileUpload? file, String? base64Str,
                      UploadError error) {
                    print(describeEnum(error));
                    print(base64Str ?? '');
                    if (file != null) {}
                  },
                  onKeyDown: (int? keyCode) {},
                  onKeyUp: (int? keyCode) {},
                  onMouseDown: () {},
                  onMouseUp: () {},
                  onNavigationRequestMobile: (String url) {
                    return NavigationActionPolicy.ALLOW;
                  },
                  onPaste: () {},
                  onScroll: () {}),
              plugins: [
                SummernoteAtMention(
                    getSuggestionsMobile: (String value) {
                      var mentions = <String>['test1', 'test2', 'test3'];
                      return mentions
                          .where((element) => element.contains(value))
                          .toList();
                    },
                    mentionsWeb: ['test1', 'test2', 'test3'],
                    onSelect: (String value) {
                      print(value);
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red.shade300),
                    onPressed: () {
                      _text_.undo();
                    },
                    child:
                        Text('Undo', style: TextStyle(color: Colors.white)),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red.shade300),
                    onPressed: () {
                      _text_.clear();
                    },
                    child:
                        Text('Reset', style: TextStyle(color: Colors.white)),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red.shade300),
                    onPressed: () async {
                      var txt = await _text_.getText();
                      if (txt.contains('src=\"data:')) {
                        txt =
                            '<text removed due to base-64 data, displaying the text could cause the app to crash>';
                      }
                      setState(() {
                        result = txt;
                      });
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red.shade300),
                    onPressed: () {
                      _text_.redo();
                    },
                    child: Text(
                      'Redo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

//
//
// import 'dart:math';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// void main() => runApp(App());
//
// const kCanvasSize = 200.0;
//
// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: ImageGenerator(),
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class ImageGenerator extends StatefulWidget {
//   final Random rd;
//   final int numColors;
//
//   ImageGenerator()
//       : rd = Random(),
//         numColors = Colors.primaries.length;
//
//   @override
//   _ImageGeneratorState createState() => _ImageGeneratorState();
// }
//
// class _ImageGeneratorState extends State<ImageGenerator> {
//   ByteData ? imgBytes;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: ElevatedButton(
//                 child: Text('Generate image'), onPressed: generateImage),
//           ),
//           imgBytes != null
//               ? Center(
//               child: Image.memory(
//                 Uint8List.view(imgBytes!.buffer),
//                 width: kCanvasSize,
//                 height: kCanvasSize,
//               ))
//               : Container()
//         ],
//       ),
//     );
//   }
//
//   void generateImage() async {
//     final color = Colors.primaries[widget.rd.nextInt(widget.numColors)];
//
//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder,
//         Rect.fromPoints(Offset(0.0, 0.0), Offset(kCanvasSize, kCanvasSize)));
//
//     final stroke = Paint()
//       ..color = Colors.grey
//       ..style = PaintingStyle.stroke;
//
//     canvas.drawRect(Rect.fromLTWH(0.0, 0.0, kCanvasSize, kCanvasSize), stroke);
//
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//
//     canvas.drawCircle(
//         Offset(
//           widget.rd.nextDouble() * kCanvasSize,
//           widget.rd.nextDouble() * kCanvasSize,
//         ),
//         20.0,
//         paint);
//
//     final picture = recorder.endRecording();
//     final img = await picture.toImage(200, 200);
//     final pngBytes = await img.toByteData(format: ImageByteFormat.png);
//
//     setState(() {
//       imgBytes = pngBytes;
//     });
//   }
// }
