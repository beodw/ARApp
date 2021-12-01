import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AR Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  void onTapHandler(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('onNodeTap on $name')),
    );
  }


  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    
    final moonMaterial = ArCoreMaterial(color: Colors.grey);
    
    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: 0.03,
    );
    
    final moon = ArCoreNode(
      shape: moonShape,
      position: vector.Vector3(0.2, 0, 0),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    final earthMaterial = ArCoreMaterial(
          color: Color.fromARGB(120, 66, 134, 244)
        );
    
    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius: 0.1,
    );
    
    final earth = ArCoreNode(
        shape: earthShape,
        children: [moon],
        position: plane.pose.translation + vector.Vector3(0.0, 1.0, 0.0),
        rotation: plane.pose.rotation);

    arCoreController.addArCoreNodeWithAnchor(earth);
  }

  void _onArCoreViewCreated(ArCoreController controller){
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
          ),
    );
  }
}
