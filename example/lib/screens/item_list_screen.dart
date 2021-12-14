import 'package:arcore_flutter_plugin_example/models/item_model.dart';
import 'package:arcore_flutter_plugin_example/screens/ar_view_screen.dart';
import 'package:arcore_flutter_plugin_example/screens/recommendationItem.dart';
import 'package:flutter/material.dart';

class ItemListScreen extends StatelessWidget {

  final List<ItemModel> items = [
    ItemModel(
      "Chair",
      "Yellow chair",
      "images/single_sofa.png",
      "images/single_sofa_label.png",
      12000,
    ),
    ItemModel(
      "Double Bed",
      "Double Bed with 2 lamps",
      "images/bed_double.png",
      "images/single_sofa_label.png",
      13999,
    ),
    ItemModel(
      "Grey Sofa",
      "Grey sofa",
      "images/sofa_grey.png",
      "images/single_sofa_label.png",
      11000,
    ),
    ItemModel(
      "Single Sofa",
      "White Sofa",
      "images/sofa_white.png",
      "images/single_sofa_label.png",
      10000,
    ),
    ItemModel(
      "Sofa",
      "Comfortable sofa",
      "images/_white_sofa.png",
      "images/single_sofa_label.png",
      21899,
    )
  ];
  @override
  Widget build(BuildContext buildContext){
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          children: <Widget>[
             SizedBox(height: 20),
             Padding(
               padding: EdgeInsets.all(24),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 Text('AR', style: TextStyle(fontSize: 48, color: Colors.white),),
                 Text(' Orders', style: TextStyle(fontSize: 48, color: Colors.white,fontWeight: FontWeight.w100),),
                 Text('List', style: TextStyle(fontSize: 48, color: Colors.white,fontWeight: FontWeight.w100),),
               ],
             ),
             ),Expanded(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 6),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)
                      ),
                    ),
                    child:  ListView.separated(
                      itemBuilder:  (BuildContext context, int index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context,  MaterialPageRoute(
                                builder: (context) => RecommendationItem()));
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Image.asset("${items[index].pic}", width: 60),
                              ),
                              Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(items[index].name, style: TextStyle(fontSize: 16, color: Colors.black),),
                                      Text(items[index].detail, style: TextStyle(fontSize: 10, color: Colors.black87),),
                                    ],
                                ),
                              ),
                              Container(
                                width: 60,
                                child: Text(items[index].price.toString(), style: TextStyle(fontSize: 14, color: Colors.blueGrey),),
                              )
                            ]
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext buildcontext, int index) => Divider(),
                      itemCount: items.length,
                    )
                  ),
                ))
          ],
        )
      )
    );
  }
}