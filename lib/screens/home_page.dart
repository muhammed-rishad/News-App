import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/screens/detailsPage.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<News>news;
  Future<News>getNews()async{
    News news=await context.read<NewsProvider>().getNews();
    return news;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<NewsProvider>(
          builder: (context,provider,child){
            if(provider.status==1){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(provider.status==3){
              return Center(
                child: Text('Something error!,Check your Internet connection'),
              );
            }else{
              return ListView.builder(
                  itemCount:provider.news.articles.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        context.read<NewsProvider>().setArticles(provider.news.articles[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailsPage()),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                height: MediaQuery.of(context).size.height/5,
                                width: MediaQuery.of(context).size.width/3,
                                child: Image.network(
                                  provider.news.articles[index].urlToImage??'https://st4.depositphotos.com/14953852/22772/v/1600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(provider.news.articles[index].title??'Title not available',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    SizedBox(height: 10,),
                                    Text(provider.news.articles[index].content??'Content not available')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    news=getNews();
  }
}


