import 'package:flutter/material.dart';
import '../stub/app_apis_stub.dart'
    if (dart.library.html) '../web/web_app_apis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Web App requestFullscreen Test',
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.green,
        backgroundColor: Colors.white,
      ),
      home: const MyHomePage(title: 'Flutter Web App Test Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AppApis apis1 = AppApis('document-body-video-player');

  final AppApis apis2 = AppApis('html-element-view-video-player');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'document.body!.append(divTag) approach',
                style: Theme.of(context).primaryTextTheme.headlineSmall,
              ),
              IconButton(
                key: const Key('request_fullscreen_button1'),
                onPressed: () => apis1.toggleFullscreen(),
                icon: const Icon(Icons.fullscreen),
              ),
              SizedBox(
                width: size.width,
                height: ((size.width * 9) / 16),
                child: apis1.videoPlayerWidget(context),
              ),
              const Divider(height: 3.0),
              Text(
                'HtmlElementView approach',
                style: Theme.of(context).primaryTextTheme.headlineSmall,
              ),
              IconButton(
                key: const Key('request_fullscreen_button2'),
                onPressed: () => apis2.toggleFullscreen(),
                icon: const Icon(Icons.fullscreen_sharp),
              ),
              SizedBox(
                width: size.width,
                height: ((size.width * 9) / 16),
                child: apis2.videoPlayerWidget(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
