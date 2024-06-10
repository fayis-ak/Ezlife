import 'package:demo_project/collections/controler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class bookingshedule extends StatefulWidget {
  const bookingshedule({super.key});

  @override
  State<bookingshedule> createState() => _bookingsheduleState();
}

class _bookingsheduleState extends State<bookingshedule> {
  Controller controller = Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder(
            future: controller.bookingdet("Swimming pool"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = controller.bookModel;
              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 350,
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "date",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                      itemCount: data!.length,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          height: 180,
                          width: 320,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 100,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25, left: 6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Room no :${data[index].RoomeNo}",
                                      style: TextStyle(fontSize: 18)),
                                  Text("Date:${data[index].Date}",
                                      style: TextStyle(fontSize: 18)),
                                  Text("From:${data[index].From}",
                                      style: TextStyle(fontSize: 18)),
                                  Text("To:${data[index].to}",
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
