import 'package:flutter/material.dart';
import 'package:habtrac/components/habit_tile.dart';
import 'package:habtrac/components/my_fab.dart';
import 'package:habtrac/components/new_habit.dart';
import 'package:habtrac/data/habit_data.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'package:habtrac/components/monthly_summary.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HabitDataBase db =  HabitDataBase();
  final _myBox = Hive.box ("Habit_Database");

  @override
  void initState (){
    // if there is no curent habit means  first time app running

    // create default data
    if(_myBox.get("CURRENT_HABIT_LIST") == null){
      db.createDefaultData();
    }
    // there are alredy existing data
    else{
      db.loadData();
    }

    //updating the database

    db.updateData();
    super.initState();
  }

  
  
  //if checkbox got tapped
   
   void checkBoxTapped (bool? value, int index){
     setState(() {
       db.todaysHabitList[index][1] = value;
     });
     db.updateData();
   }
   // create new Habit
  final _newHabitController = TextEditingController();
  void createNewHabit(){
     //show a dialog box user to create new Habit
     showDialog(
         context: context,
         builder:(context) {
           return EnterNewHabit(
             controller: _newHabitController,
             onSave: saveNewHabit,
             onCancel: cancelNewHabit,
           );
         }
     );
  }

  //save new habit

  void saveNewHabit(){

    //add new habit to the list
    setState(() {
      db.todaysHabitList.add([_newHabitController.text, false]);
    });

    //clear textfield
    _newHabitController.clear();
    //pop the dialog box
    Navigator.of(context).pop();
    db.updateData();

  }

  //cancel new habit
  void cancelNewHabit(){
     //clear textfield
    _newHabitController.clear();
    //pop the dialog box
    Navigator.of(context).pop();
  }

  //setting open
   void openHabitSetting(int index){
    showDialog(context: context,
        builder: (contex){
       return EnterNewHabit(
           controller:  _newHabitController,
           onSave: () => saveExistingHabit(index),
           onCancel:  cancelNewHabit,
       );
        }
    );
   }

  // save exsiting habit with a new Name

  void saveExistingHabit(int index){
    setState(() {
      db.todaysHabitList[index][0] = _newHabitController.text;
    });

    _newHabitController.clear();

    Navigator.pop(context);
    db.updateData();
  }

  //delete Habit

  void deleteHabit(int index){
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(


        backgroundColor: Colors.black45,
        title: Text("Habit Tracker"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewHabit,
      ),

      body: ListView(
        children: [


          //monthly summary heatmap
          MonthlySummary(
              startDate: _myBox.get("START_DATE"),
              datasets: db.heatMapDataSet
          ),

          Center(
            child: Container(
                margin: EdgeInsets.only(top: 25,bottom: 25),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12),
                   color: Colors.teal[300]
                 ),
                height: 40,
              width: 250,


              child:     Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("List Your Daily Habit",textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),),
              ),
            ),
          ),

          ListView.builder(

            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context , index){
              return HabitTile(

                habitName: db.todaysHabitList[index][0],
                habitCompleted: db.todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value,index),
                settingTapped: (context) => openHabitSetting(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },


          ),

          // list of habits



        ],
      )
    );
  }
}
