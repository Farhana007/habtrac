import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {


  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingTapped;
  final Function(BuildContext)? deleteTapped;


  const HabitTile ({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.deleteTapped,
    required this.settingTapped
});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              //setting option
              
             SlidableAction(
                 onPressed:settingTapped,

               backgroundColor: Colors.green,
               icon: Icons.edit,


               borderRadius: BorderRadius.circular(12),
             
             ),

              //delete option
              SlidableAction(
                onPressed:deleteTapped,
                backgroundColor: Colors.redAccent,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(12),

              )
            ]
        ),
        child: Container(

           padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13)
            ),

           child: Row(
             children: [
               //check Box
               Checkbox(
                 value:habitCompleted,
                   onChanged:onChanged,
               ),
               //habit name
               Text(habitName,style: TextStyle(
                 color: Colors.black,
                 fontSize: 21,
                 fontWeight: FontWeight.w500
               ),),
             ],
           ),


        ),
      ),
    );
  }
}
