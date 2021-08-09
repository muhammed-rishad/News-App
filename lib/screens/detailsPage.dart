

import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/service/image_picker.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height/2.5,
                width: MediaQuery.of(context).size.width/1.1,
                child: Image.network(context.read<NewsProvider>().articles.urlToImage??'https://st4.depositphotos.com/14953852/22772/v/1600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg',
                  fit: BoxFit.cover,),
              ),
              SizedBox(height: 10,),
              Text(context.read<NewsProvider>().articles.title??'No title Available',
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 10,),
              Text(context.read<NewsProvider>().articles.content??'No content Available'),
              ImagePic()
            ],
          ),
        ),
      ),
    );
  }
}
