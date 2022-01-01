
import 'dart:async';

import 'package:astro/Model/addres.dart';
import 'package:astro/Model/panchang.dart';
import 'package:astro/screens/astro/astro_screen.dart';
import 'package:astro/screens/panchang/panchang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class panchangui extends StatefulWidget {
  Panchang? panchangmodel;Addres? addres;
  panchangui({this.panchangmodel,this.addres});

  @override
  _panchanguiState createState() => _panchanguiState();
}

class _panchanguiState extends State<panchangui> {
  DateTime currentDate = DateTime.now();bool data = false;
  List<Datum>? searchresults;
  String placeid = 'ChIJL_P_CXMEDTkRw0ZdG-0GVvw';
  String? month;int? day,monthnumber,year;
  String hintlocation = 'Delhi,India';TextEditingController location = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        month = formatter.format(pickedDate);
        day = pickedDate.day;
        monthnumber = pickedDate.month;
        year = pickedDate.year;
      });
    context.read<PanchangCubit>().getpanchang({"day":day,"month":monthnumber,"year":year,"placeId":placeid});
  }
  DateFormat formatter = DateFormat('MMMM');
  DateTime now = DateTime.now();

  @override
  void initState() {
    day=currentDate.day;
    monthnumber = currentDate.month;
    year = currentDate.year;
    // TODO: implement initState
    super.initState();
    month = formatter.format(DateTime.now());
    context.read<PanchangCubit>().getpanchang({"day":2,"month":7,"year":2021,"placeId":placeid});
    Timer(Duration(seconds: 3), () {
      setState(() {
        data = true;
      });
     
    });

  }

  searchPlaces(String searchTerm) async {

   var search = await BlocProvider.of<PanchangCubit>(context)!.getAutoCompletePlaces(searchTerm);
   searchresults = search.data!;//placesService.getAutocomplete(autcomplete);
    setState(() {
      searchresults;
    });
    // notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    return Scaffold(body: SingleChildScrollView(child:data?Container(height: 900,color: Colors.white,width: MediaQuery.of(context).size.width,child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

      Container(padding: EdgeInsets.symmetric(horizontal: 16),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [




        Column(children:[
          SizedBox(height: 50,),
          Container(height: 25,child:Image.asset('assets/hamburger.png'))]),
        Column(children:[
          SizedBox(height: 45,),
         // Text('ASTRO',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color(0xff515152)),),
          Container(height: 40,child:Image.asset('assets/astro.png'))]),
        Column(children:[
          SizedBox(height: 50,),
          Container(height: 25,child:Image.asset('assets/profile.png'))]),
      ]),),SizedBox(height: 20,),
      Row(children: [SizedBox(width: 16,),Icon(Icons.arrow_back_ios,size: 15,),SizedBox(width: 5,),Text('Daily Panchang',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xff000000)),)],),
      SizedBox(height: 10,),
      Container(padding: EdgeInsets.symmetric(horizontal: 16),child:Text('India is a Country known for its festival but knowing exactr datescan sometimes be difficulr. '
          'To ensure yo do not miss critical dates we bring daily panchang',
        style: TextStyle(height: 1.3,fontSize: 12,fontWeight: FontWeight.w500,color:
        Color(0xff6b6b6b)),)),SizedBox(height: 10,),
      Container(height: 150,width: MediaQuery.of(context).size.width,margin: EdgeInsets.symmetric(horizontal: 16),decoration: BoxDecoration(color: Color(0xfffff2e8)),child: Column(children: [
        SizedBox(height: 24,),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 10),width: MediaQuery.of(context).size.width/3.5,child:
          Center(child:Text('Date:',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: Color(0xff000000))),),),
          Container(height: 40,color: Colors.white,width: MediaQuery.of(context).size.width/1.8,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
          [ Padding(padding: EdgeInsets.only(left:10),child:Text('${currentDate.day.toString()}th ${month}, ${currentDate.year}' ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: Color(0xff000000)),)),
            InkWell(
              onTap: () => _selectDate(context),
              child: Icon(Icons.arrow_drop_down)
            ),],),)

        ],),SizedBox(height: 20,),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 10),width: MediaQuery.of(context).size.width/3.5,child:
          Center(child:Text('Location:',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: Color(0xff000000))),),),
          Container(height: 40,color: Colors.white,width: MediaQuery.of(context).size.width/1.8,child:  Container(padding: EdgeInsets.only(left: 10),child: TextField(controller: location,

            textAlign: TextAlign.justify,
            obscureText: false,
            style: TextStyle(
                fontSize: 15,fontWeight: FontWeight.w300,color: Color(0xff000000)),
            onChanged: (value) =>

                searchPlaces(value),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintlocation,
              suffixIcon: Icon(Icons.search),
              //isDense: true,
              // hintText: "5342 Mauricio Walks",
              hintStyle: TextStyle(height: 2,fontSize: 15,fontWeight: FontWeight.w300,color: Color(0xff000000)
                /*color: Colors.black,
                fontFamily: 'Gilroy',
                fontSize: 16.0,
                fontWeight: FontWeight.w400,*/
              ),
              contentPadding: EdgeInsets.only(bottom: 11),
              focusedBorder: UnderlineInputBorder(),
            ),
          ),))

        ],),


      ],),),SizedBox(height: 20,),
      Stack(children: [Column(children: [
        Row(children: [Padding(padding: EdgeInsets.only(left: 16,bottom: 10),child: Text('Tithi',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xff000000)),),),]),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('Tithi Number:',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/2,child: Text(widget.panchangmodel!.data!.tithi!.details!.tithiNumber.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),SizedBox(height: 2,),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('Tithi Name:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/1.8,child: Text(widget.panchangmodel!.data!.tithi!.details!.tithiName.toString(),style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('Special:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/1.8,child: Text(widget.panchangmodel!.data!.tithi!.details!.special.toString(),style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),SizedBox(height: 8,),
        Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('Summary:',style: TextStyle(height: 1.2,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/1.8,child: Text(widget.panchangmodel!.data!.tithi!.details!.summary.toString(),style: TextStyle(height: 1.2,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('Deity:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/1.8,child: Text('${widget.panchangmodel!.data!.tithi!.details!.deity.toString()}',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('End Time:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/1.8,child: Text('${widget.panchangmodel!.data!.tithi!.endTime!.hour.toString()}hr ${widget.panchangmodel!.data!.tithi!.endTime!.minute.toString()}min ${widget.panchangmodel!.data!.tithi!.endTime!.second.toString()}sec',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),
        SizedBox(height: 20,),
      ],),
        if (searchresults != null &&
            searchresults!.length != 0)
          Row(children:[SizedBox(width: MediaQuery.of(context).size.width/2.8,),Container(
            height: 200.0,width:150, //검색어 리스트도 맵이랑 같은height
           // width: double.infinity, //리스트 아래로 무한대
            decoration: BoxDecoration(
                color: Colors.white,
                //backgroundBlendMode: BlendMode.darken
            ),
          ),]),
        if (searchresults != null &&
            searchresults!.length != 0)
         Row(children: [ SizedBox(width: MediaQuery.of(context).size.width/2.8,),Container(
            height: 200.0,width: 150,
            child: ListView.builder(padding: EdgeInsets.all(0),
                itemCount: searchresults!.length,
                itemBuilder: (contex, index) {
                  return Container(padding: EdgeInsets.only(left: 10),height: 40,width: 150,child: InkWell(onTap: (){setState(() {
                    placeid = searchresults![index].placeId.toString();
                    context.read<PanchangCubit>().getpanchang({"day":day,"month":monthnumber,"year":year,"placeId":placeid});
                    location.text= searchresults![index].placeName.toString();
                    searchresults!.length = 0;
                    
                  });},
                    child: Text(
                      searchresults![index].placeName.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                   /* title: Text(
                      searchresults![index].placeName.toString(),
                      style: TextStyle(color: Colors.white),
                    ),*/
                    /*onTap: () async{
                     /* setSelectedLocation(
                          searchResults![index].placeId.toString());
                      locations = (await locationFromAddress(searchResults![index].description.toString())).cast<Location>() ;
                      // print('heren  is code $locations');
                      setState(() {

                        _destLatitude = locations![0].latitude;
                        _destLongitude = locations![0].longitude;
                        _lastMapPosition = LatLng(_destLatitude, _destLongitude);
                        // _onAddMarkerButtonPressed();
                      });
                      print(locations);*/
                    },*/
                  );
                }),
          )])


      ],),

      Padding(padding: EdgeInsets.only(left: 16,bottom: 10),child: Text('Nakshatra',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xff000000)),),),
      Row(children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Nakshatra Number:',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/2,child: Text('3',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),SizedBox(height: 2,),
      Row(children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Nakshatra Name:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/1.8,child: Text('Kritika',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),
      Row(children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Ruler:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/1.8,child: Text('Sun',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),
      Row(children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Deity:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/1.8,child: Text('${widget.panchangmodel!.data!.tithi!.details!.deity.toString()}',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),
      Row(children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Special:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/1.8,child: Text(widget.panchangmodel!.data!.tithi!.details!.special.toString(),style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),SizedBox(height: 8,),
      Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Summary:',style: TextStyle(height: 1.2,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/1.8,child: Text(widget.panchangmodel!.data!.tithi!.details!.summary.toString(),style: TextStyle(height: 1.2,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),



    ],),):Container(height: 500,child: Center(child: CircularProgressIndicator(),))),bottomNavigationBar: Container(height: 70,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      Container(padding: EdgeInsets.only(left: 26),child:Column(children: [SizedBox(height: 15,),
        Container(height: 22,child:Image.asset('assets/home.png'),),
        Text('Home',style: TextStyle(height: 1.8,fontSize: 10,fontWeight: FontWeight.w300,color: Color(0xfffa9345))),
      ],),),
      InkWell(onTap: (){Navigator.push(context, new MaterialPageRoute(builder: (__) => new AstroScreen()));},
        child: Column(children: [SizedBox(height: 15,),
          Container(height: 22,child:Image.asset('assets/talk.png'),),
          Text('Talk to Astrologer',style: TextStyle(letterSpacing: -.4,height: 1.8,fontSize: 10,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),
        ],),
      ),
      Column(children: [SizedBox(height: 15,),
        Container(height: 22,child:Image.asset('assets/ask.png'),),
        Text('Ask Question',style: TextStyle(height: 1.8,fontSize: 10,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),
      ],),
      Container(padding: EdgeInsets.only(right: 26),
        child: Column(children: [SizedBox(height: 15,),
          Container(height: 22,child:Image.asset('assets/reports.png'),),
          Text('Reports',style: TextStyle(height: 1.8,fontSize: 10,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),
        ],),
      ),
   /* Column(children: [SizedBox(height: 10,),
        Container(height: 22,child:Icon(Icons.chat),),
        Text('Chat with Astrologer',style: TextStyle(letterSpacing: -0.7,height: 1.8,fontSize: 10,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),
      ],)*/
    ],),),);
  }
}
