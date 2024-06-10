import 'package:demo_project/home_user.dart';
import 'package:demo_project/controller/helperprovider.dart';
import 'package:demo_project/selladd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class buy_sell extends StatefulWidget {
  const buy_sell({super.key});

  @override
  State<buy_sell> createState() => _buy_sellState();
}

class _buy_sellState extends State<buy_sell> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(" Buy/Sell")),
          backgroundColor: Color.fromARGB(44, 24, 255, 216),
          actions: [
            Text(
              "Add",
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => selladd()));
                },
                icon: Icon(
                  Icons.add,
                  size: 40,
                ))
          ],
        ),
        body: Container(
          height: 900,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(child: Consumer<HelperProvider>(
                builder: (context, instance, child) {
                  return StreamBuilder(
                    stream: instance.getAllProduct().asStream(),
                    builder: (context, snapshot) {
                      final data = instance.allproduct;
                      return data.isEmpty
                          ? Center(
                              child: Text('No Product'),
                            )
                          : ListView.separated(
                              itemCount: data.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 30,
                                );
                              },
                              itemBuilder: (context, index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: 170,
                                    width: 320,
                                    child: Padding(
                                      padding: const EdgeInsets.only(),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  data[index].productname,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 60),
                                                child: Container(
                                                  width: 150,
                                                  height: 70,
                                                  child: Image.network(
                                                      data[index].Productimage),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  data[index].ProdcutPeice,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 160,
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.chat,
                                                    size: 30,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            );
                    },
                  );
                },
              )),
            ],
          ),
        ));
  }
}
