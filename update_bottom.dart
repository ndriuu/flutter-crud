import 'package:flutter/material.dart';
import 'package:siuu/realtime_database.dart';

final TextEditingController gasValveController = TextEditingController();
final TextEditingController dirtValveController = TextEditingController();

void updateBottomSheet(BuildContext context,name,id,address) {
  gasValveController.text = name;
  dirtValveController.text = address;
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.blue[100],
      builder: (BuildContext context){
        return Padding(
          padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: MediaQuery.of(context).viewInsets.bottom+20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text("Create Your items", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
                )),
              ),
              TextField(
                controller: gasValveController,
                decoration: const InputDecoration(
                labelText: "Name",
                hintText: "eg.Elon"
                ),
              ),
              TextField(
                controller: dirtValveController,
                decoration: const InputDecoration(
                    labelText: "Address",
                    hintText: "eg.Elon"
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    databaseReference.child(id).update({
                      'name':gasValveController.text.toString(),
                      'address' : dirtValveController.text.toString(),
                    });
                    Navigator.pop(context);
                    }, child: const Text("Updated"))
            ],
          ),
        );
      });
}