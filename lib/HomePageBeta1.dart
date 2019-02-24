import 'package:flutter/material.dart';
import 'SecondPage.dart';

class HomePageBeta extends StatefulWidget {

  final String title;

  HomePageBeta({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageWidget();
  }


}

class _HomePageWidget extends State<HomePageBeta> {

  int _count = 0;
  var editController = TextEditingController();

  void _increment() {
    setState(() {
      _count++;
      print("increment clicked!");
    });
  }

  void _alert({message : String}) {

  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold (
//      appBar: AppBar(title: Text(widget.title),),
//      body: Row(
//        children: <Widget>[
//          Expanded(
//            child: TextField(
//              controller: editController,
//            ),
//          ),
//          RaisedButton(
//            child: Text("click me"),
//            onPressed: (){
//              showDialog(context: context,
//              builder: (_) {
//                return AlertDialog (
//                  content: Text(editController.text),
//                  actions: <Widget>[
//                    FlatButton(
//                      child: Text('OK'),
//                      onPressed: () => Navigator.pop(context),
//                    )
//                  ],
//                );
//              });
//            },
//          ),
//          TestWidget()
//        ],
//
//      ),
//    );
//  }

  List<int> items = List.generate(20, (i) => i);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _getMore();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  Future<List<int>> fakeRequest(int from, int to) async {
    return Future.delayed(Duration(seconds: 2), () {
        return List.generate(to - from, (i) => i + from);
    });
  }

  void _getMore() async{
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });
      List<int> newItems = await fakeRequest(items.length, items.length + 10);
      setState(() {
        items.addAll(newItems);
        isPerformingRequest = false;
      });
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(opacity: isPerformingRequest ? 1 : 0,
        child: new CircularProgressIndicator(),),
      ));
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
        appBar: AppBar(title: Text(widget.title),),
        body: Center(
          child: ListView.builder(itemBuilder: (context, index) {
            if (index == 0) {
              return new GestureDetector(
                child: Text("Jump to Second Page"),
                onTap: () {jumpToSecondPage(context);},
              );
            } else if (index == items.length) {
              return _buildProgressIndicator();
            } else {
              return ListTile(title: new Text("Number $index"),);
            }
          }, itemCount: items.length + 1,
          controller: _scrollController,),

        ),
      floatingActionButton: FloatingActionButton(onPressed: () {jumpToSecondPage(context);},
      tooltip: "click me", child: Icon(Icons.add),),
    );
  }

  void jumpToSecondPage(BuildContext context) {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new SecondPage();
    }));
  }

}

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: Text('text'),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      width: 80.0,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5.0)
      ),
    );
  }

}