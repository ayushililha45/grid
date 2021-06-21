import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid/model/apimodel.dart';
import 'package:grid/service/apiService.dart';

void main(List<String> args) {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hit Api'),
        ),
        body: ApiBody(),
      ),
    );
  }
}

class ApiBody extends StatefulWidget {
  @override
  _ApiBodyState createState() => _ApiBodyState();
}

class _ApiBodyState extends State<ApiBody> {
  late List<Todolist> list;
  ApiService apiService = new ApiService();
  bool isGettinData = false;

  Future getData() async {
    try {
      await apiService.getData().then((value) {
        setState(() {
          list = value;
        });
      }).whenComplete(() {
        setState(() {
          isGettinData = true;
        });
      });
    } catch (e) {
      setState(() {
        isGettinData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isGettinData
          ? ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {             
                return GridView.builder(
                    itemCount:list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.landscape ? 3: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      childAspectRatio: (2 / 1),
                    ),
                    itemBuilder: (context,index,) {
                      return GestureDetector(
                        onTap:(){
                          Navigator.of(context).pushNamed(list[index].title);
                        },
                        child:Container(
                        color: list[index].completed == true ? Colors.green : Colors.red,
                        child: Column(
                            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                            children: [
                              //Icon(items[index].icon),
                              Text(list[index].title,style: TextStyle(fontSize: 18, color: Colors.black),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          

              })
          : Center(
              child: (new Card(
              child: TextButton(
                child: Text('Press here for api'),
                onPressed: () => getData(),
              ),
            ))),
    );
  }
}
