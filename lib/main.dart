import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SelectionArea(
              child: Text('Does VO know about this text here?'),
            ),
            SizedBox(height: 32.0),
            TextField(),
            SizedBox(height: 32.0),
            _MathEditor(),
          ],
        ),
      ),
    );
  }
}

class _MathEditor extends StatefulWidget {
  const _MathEditor({super.key});

  @override
  State<_MathEditor> createState() => __MathEditorState();
}

class __MathEditorState extends State<_MathEditor> {
  final FocusNode _focusNode = FocusNode();
  String value = '';

  void _handleFocusChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      container: true,
      label: 'math editor: $value',
      child: Focus(
        focusNode: _focusNode,
        onKeyEvent: (FocusNode focusNode, KeyEvent keyEvent) {
          if (keyEvent.character != null) {
            setState(() {
              value += keyEvent.character!;
            });
            print('justin typed $value');
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: GestureDetector(
          onTap: () {
            _focusNode.requestFocus();
          },
          child: Container(
            width: 256.0,
            height: 32.0,
            color: _focusNode.hasFocus ? Colors.red : Colors.brown,
            child: Text(value),
          ),
        ),
      ),
    );
  }
}
