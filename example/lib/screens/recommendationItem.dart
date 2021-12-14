import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/services.dart';

class RecommendationItem extends StatefulWidget {
  @override
  _RecommendationItemState createState() => _RecommendationItemState();
}

class _RecommendationItemState extends State<RecommendationItem> {
  ArCoreController arCoreController;

  String itemSelected;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Recommendation Gallery'),
        ),
        body: Stack(
          children: <Widget>[
            ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
              enableTapRecognizer: true,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ListObjectSelection(
                onTap: (value) {
                  itemSelected = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void _addItem(ArCoreHitTestResult hitTestResult) async{
    if (itemSelected != null) {
      //"https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf"
      final bytes  = (await rootBundle.load(itemSelected)).buffer.asUint8List();
      final itemNode = ArCoreNode(
        image: ArCoreImage(bytes: bytes, width: 500,height: 500),
        position: hitTestResult.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
        rotation: hitTestResult.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
      );

      arCoreController.addArCoreNodeWithAnchor(itemNode);
    } else {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(content: Text('Select an Item!')),
      );
    }
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addItem(hit);
  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Text(' Remove item ?'),
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  arCoreController.removeNode(nodeName: name);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

class ListObjectSelection extends StatefulWidget {
  final Function onTap;

  ListObjectSelection({this.onTap});

  @override
  _ListObjectSelectionState createState() => _ListObjectSelectionState();
}

class _ListObjectSelectionState extends State<ListObjectSelection> {

  List<String> objectsFileName = [
    "images/single_sofa.png",
    "images/sofa_white.png",
    "images/_white_sofa.png",
    "images/sofa_grey.png",
    "images/bed_double.png",
  ];

  String selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: ListView.builder(
        itemCount: objectsFileName.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected = objectsFileName[index];
                widget.onTap(objectsFileName[index]);
              });
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Container(
                color:
                selected == objectsFileName[index] ? Colors.red : Colors.transparent,
                padding: selected == objectsFileName[index] ? EdgeInsets.all(8.0) : null,
                child: Image.asset(objectsFileName[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
