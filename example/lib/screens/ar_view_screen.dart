import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin_example/screens/item_list_screen.dart';
import 'package:arcore_flutter_plugin_example/models/item_model.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArViewScreen extends StatefulWidget {

  String itemImg;
  List<ItemModel> items;
  int currentIndex;

  ArViewScreen({this.itemImg, this.items, this.currentIndex});
  @override
  _ArViewScreenState createState() => _ArViewScreenState();
}

class _ArViewScreenState extends State<ArViewScreen>{

  ArCoreController arCoreController;
  ArCoreHitTestResult hitTestResult;

  void whenArCoreViewCreated(ArCoreController controller){
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onNodeTapHandler(name);
    arCoreController.onPlaneTap = controlOnPlaneTap;
  }

  void onNodeTapHandler(String name){
    arCoreController.removeNode(nodeName: name);
    widget.currentIndex = widget.currentIndex+1 % widget.items.length;
    addItemImagetoScene(hitTestResult);
  }

  void controlOnPlaneTap(List<ArCoreHitTestResult> results){
    final hit = results.first;
    hitTestResult = hit;
    addItemImagetoScene(hitTestResult);
  }


  Future addItemImagetoScene(ArCoreHitTestResult hitTestResult) async{
    final bytes  = (await rootBundle.load(widget.items[widget.currentIndex].pic)).buffer.asUint8List();
    final imageItem = ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 600,height: 600),
      position: hitTestResult.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
      rotation: hitTestResult.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
    );
    arCoreController.addArCoreNodeWithAnchor(imageItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: whenArCoreViewCreated,
        enableTapRecognizer: true,
      )
    );
  }
}