
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habtrac/datetime/date_time.dart';


// referece our box
final _myBox = Hive.box("Habit_Database");

class HabitDataBase {
  List todaysHabitList = [];

  Map <DateTime,int> heatMapDataSet = {};

  // create Iniatial default data

  void createDefaultData(){
    todaysHabitList = [
      ["Read", false],
      ["Workout",false],

    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }


  //load the data that already exist
     void loadData(){
     // check if its a new day or not a new day

    if( _myBox.get(todaysDateFormatted()) == null){
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      // Set all habit completed to  false since its a new day
      for ( int i = 0; i<todaysHabitList.length; i++){
        todaysHabitList[i][1] = false;
      }
    }

    // if not new day load todays list
    else{
     todaysHabitList = _myBox.get(todaysDateFormatted());
    }


  }


 // update the database

  void updateData(){
    //update todays entry

    _myBox.put(todaysDateFormatted(), todaysHabitList);

    //update universal habit list in case it changed (new habit, edit habit, delete habit)

    _myBox.put("CURRENT_HABIT_LIST",todaysHabitList);
    //calculate habit complete percentagef for each day
    calculatePercentages();

    //load the heat map

    loadHeatMap();


  }


// crating calculate and load heat map methods

  void calculatePercentages(){
    int countCompleted = 0;
    for(int i = 0 ; i<todaysHabitList.length; i++){
       if(todaysHabitList[i][1] == true){
         countCompleted++;
       }
    }

    String percent = todaysHabitList.isEmpty?"0.0"
      : (countCompleted / todaysHabitList.length).toStringAsFixed(1);

    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}",percent);
  }

  void loadHeatMap(){
      DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

      //count the number of the date to load
      int daysInBetween = DateTime.now().difference(startDate).inDays;


      for(int i = 0; i<daysInBetween + 1; i++){
        String yyyymmdd = convertDateTimeToString(
          startDate.add(Duration(days: i)),
        );

        double strengthAsPercent = double.parse(
          _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
        );

        int year = startDate.add(Duration(days: i)).year;


        int month = startDate.add(Duration(days: i)).month;


        int day = startDate.add(Duration(days: i)).day;

        final percentForDay = <DateTime,int>{
          DateTime(year,month,day): (10 * strengthAsPercent).toInt(),
        };

        heatMapDataSet.addEntries(percentForDay.entries);
       print(heatMapDataSet);
      }
  }



}
