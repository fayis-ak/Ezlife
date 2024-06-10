import 'package:demo_project/bottom.dart';
import 'package:demo_project/collections/controler.dart';
import 'package:demo_project/model/bookmodel.dart';
import 'package:demo_project/sduledgasthouse.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class bookinggust extends StatefulWidget {
  const bookinggust({super.key});

  @override
  State<bookinggust> createState() => _bookingpageState();
}

class _bookingpageState extends State<bookinggust> {
   final roomcont = TextEditingController();
  String? _selectedUserType;
  List<String> usertype = [
    'Part Hall',
    'Swimming pool',
    'Truf',
    'Guest house',
    'Gym'
  ];
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedEndTime;

  // Future<void> timepicker() async {
  //   TimeOfDay? pickedFile =
  //       await showTimePicker(context: context, initialTime: TimeOfDay.now());

  //   setState(() {
  //     _selectedTime = pickedFile;
  //   });
  // }

  Future<void> showStartTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> showEndTimePicker() async {
    TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedEndTime != null) {
      setState(() {
        _selectedEndTime = pickedEndTime;
      });
    }
  }

  DateTime selecdate = DateTime.now();
  TimeOfDay? _selectedend;

  Future<void> timepickerto() async {
    TimeOfDay? pickedFile =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    setState(() {
      _selectedend = pickedFile;
    });
  }

  DateTime selecdated = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Center(child: Text(" Booking")),
              backgroundColor: Color.fromARGB(44, 24, 255, 216),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => bottomnavipage(
                          indexnum: 0,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_back_ios_new)),
              bottom: TabBar(
                tabs: [
                  Tab(text: "Booking"),
                  Tab(text: "Scheduled"),
                ],
              ),
            ),
            body: TabBarView(children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                //  width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                          width: 400,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/house.jpeg'), // Replace 'assets/image.jpg' with your image path
                                fit: BoxFit
                                    .cover, // Adjust how the image fits inside the container
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                "@book Now",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Enjoy Your Life",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Maximum eight Hours is Allowed!",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                      SizedBox(
                        height: 39,
                        child: TextFormField(
                          controller: roomcont,
                          decoration: InputDecoration(
                            // filled: true,
                            //labelText: "Room No",
                            hintText: "Room No",
                            // prefixIcon: Icon(Icons.person),
                            // fillColor: Color(0xFFF3EEEE),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 250, top: 15),
                        child: Text(
                          "Time:",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              height: 39,
                              width: 120,
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: _selectedTime != null
                                      ? _selectedTime!.format(context)
                                      : "From",
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.timer_outlined),
                                    onPressed: () async {
                                      await showStartTimePicker();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: SizedBox(
                              height: 39,
                              width: 120,
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: _selectedEndTime != null
                                      ? _selectedEndTime!.format(context)
                                      : "To",
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.timer_outlined),
                                    onPressed: () async {
                                      await showEndTimePicker();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 55,
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              // filled: true,
                              hintText: selecdate != null
                                  ? "${selecdate!.day}/${selecdate!.month}/${selecdate!.year}"
                                  : "Date",
                              // hintText: " Name",
                              // prefixIcon: Icon(Icons.person),
                              // fillColor: Color(0xFFF3EEEE),
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    final DateTime? date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(3000));

                                    if (selecdate != null) {
                                      setState(() {
                                        selecdate = date!;
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.date_range))),
                        ),
                      ),
                       DropdownButtonFormField(
                          decoration: InputDecoration(hintText: " Booking for"),
                          items: usertype.map((e) {
                            return DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedUserType = value.toString();
                              // log(_selectedUserType.toString());
                            });
                          },
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: SizedBox(
                          width: 100,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 12, 184, 193)),
                            onPressed: () async{
                               if (_selectedTime != null &&
                                    _selectedEndTime != null) {
                                  await Controller().addBook(
                                    BookModel(
                                        RoomeNo: roomcont.text,
                                        From: _selectedTime!.format(context),
                                        to: _selectedEndTime!.format(context),
                                        Date: selecdate.toString(),
                                        Type: _selectedUserType.toString()),
                                  );
                                } else {
                                  print(
                                      '------------------------------------------------------error mone -------------------------------------');
                                }

                                print(
                                    '----------------${_selectedTime!.format(context)}==========================================');
                              },
                            
                            child: Text(
                              "Ok",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bookingshedulegast(),
            ])));
  }
}
