import 'package:flutter/material.dart';
import 'package:ono/constants.dart';
import 'package:ono/model/listModel.dart';
import 'package:ono/screens/home/homeScreen.dart';
import 'package:ono/screens/onoDef.dart';
import '../../model/emotionButton.dart';
import 'package:ono/model/dummyData.dart';

// This is for 2 emotions chosen
class onoList extends StatefulWidget {
  const onoList(
      {Key? key,
      required this.indexOno,
      required this.mainEmotion,
      required this.emotionButton,
      required this.subEmotion})
      : super(key: key);
  // ADJUST THIS
  final EmotionButton emotionButton;
  final int indexOno;
  final String mainEmotion;
  final String subEmotion;

  @override
  State<onoList> createState() => _onoList();
}

class _onoList extends State<onoList> {
  late List<listModel> onoDataList;
  late List<listModel> parsedList;

  @override
  void initState() {
    onoDataList = dummyData
        .map((x) => listModel.fromJson(x as Map<String, Object>))
        .toList();
    parsedList = [];
    super.initState();
  }

  int quantity = 1;

  get indexNum => widget.indexOno;
  get button => widget.mainEmotion;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchBar(),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // pop everything and return to home
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false);
                },
                child: const Icon(
                  Icons.home,
                  size: 30,
                ),
              )),
        ],
        backgroundColor: bgColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: mainPink,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [],
            ),
          ),
          createList()
        ],
      ),
    );
  }
/*   
  Widget createList(){
    
  } */

  Widget createList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            /*children: <Widget>[
              Text("     ${widget.emotionButton.name} > ${widget.emotionButton.secondEmotionList[indexNum]}",
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(fontWeight: FontWeight.w400, color: desaturatedBlue),
              ),
*/ /*              IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {})*/ /*
            ],*/
          ),
          getList()
        ],
      ),
    );
  }

  Widget getList() {
    onoDataList.forEach((item) {
      print(widget.mainEmotion);
      if (item.mainemotion == widget.mainEmotion.toLowerCase() &&
          item.subemotion == widget.subEmotion.toLowerCase()) {
        parsedList.add(item);
      }
    });
    return Column(
        children: parsedList.map((x) {
      return onoTile(x);
    }).toList());
  }

  Widget onoTile(listModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
        color: lightBgColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: darkBgColor,
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 14,
            color: darkBgColor,
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 35,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: lightBgColor,
              ),
              child: Text(
                model.letter,
                textAlign: TextAlign.left,
                textScaleFactor: 2,
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return onoDef(model: model);
                },
              ),
            );
          },
          title: Text(model.onomatopoeia),
          subtitle: Text(
            model.transliteration,
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: mainPink,
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: lightBgColor, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  /* Clear the search field */
                },
              ),
              hintText: 'Search...',
              border: InputBorder.none),
        ),
      ),
    );
  }
}
