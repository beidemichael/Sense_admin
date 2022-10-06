import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_admin/service/database.dart';
import 'package:provider/provider.dart';

import '../../../models/models.dart';
import 'edit.dart';

class PublishedPage extends StatefulWidget {
  const PublishedPage({Key? key}) : super(key: key);

  @override
  State<PublishedPage> createState() => _PublishedPageState();
}

class _PublishedPageState extends State<PublishedPage> {
  editPopup(BuildContext context, News news) {
    Edit alert = Edit(news: news);

    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<List<News>?>(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: news?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: news![index].active
                    ? Colors.purple.shade50
                    : Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 2.0, //effect of softening the shadow
                    spreadRadius: 0.1, //effecet of extending the shadow
                    offset: Offset(
                        0.0, //horizontal
                        3.0 //vertical
                        ),
                  ),
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 1.0, //effect of softening the shadow
                    spreadRadius: 0.1, //effecet of extending the shadow
                    offset: Offset(
                        0.0, //horizontal
                        -1.0 //vertical
                        ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Container(
                    //   //image
                    //    width: MediaQuery.of(context).size.width,
                    //   height: 100,
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey[200],
                    //   ),
                    //   child: news[index].image != ''
                    //       ? ClipRRect(
                    //           child: CachedNetworkImage(

                    //             fit: BoxFit.cover,
                    //             imageUrl: news[index].image,
                    //             progressIndicatorBuilder:
                    //                 (context, url, downloadProgress) =>
                    //                     Center(
                    //               child: Container(
                    //                 height: 30,
                    //                 width: 30,
                    //                 child: CircularProgressIndicator(
                    //                     valueColor:
                    //                         AlwaysStoppedAnimation<Color>(
                    //                             Colors.purple[300]!),
                    //                     value: downloadProgress.progress),
                    //               ),
                    //             ),
                    //             errorWidget: (context, url, error) =>
                    //                 Icon(Icons.error),
                    //           ),
                    //         )
                    //       : Center(
                    //           child: Icon(
                    //             Icons.newspaper_rounded,
                    //             size: 150,
                    //             color: Colors.grey[400],
                    //           ),
                    //         ),
                    // ),
                    Text(
                      news[index].headline,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: news[index].active
                              ? Colors.purple[900]
                              : Colors.grey[600]),
                    ),
                    Text(
                      news[index].description,
                      maxLines: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0,
                          color: news[index].active
                              ? Colors.purple[900]
                              : Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            editPopup(context, news[index]);
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            child: Center(
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: Colors.green[800]),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.green[200],
                            ),
                          ),
                        ),
                        Switch(
                          // This bool value toggles the switch.
                          value: news[index].active,
                          activeColor: Colors.purple,
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              DatabaseService().newsActiveState(
                                  news[index].documentId, news[index].active);
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            DatabaseService()
                                .deleteNews(news[index].documentId);
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            child: Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: Colors.red[800]),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.red[200],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Published by: ' + news[index].author,
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 15.0,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Views: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15.0,
                                    color: Colors.purple[500]),
                              ),
                              Text(
                                news[index].readerList.length.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.0,
                                    color: Colors.purple[500]),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Bookmarks: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15.0,
                                    color: Colors.purple[500]),
                              ),
                              Text(
                                news[index].bookmarks.length.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.0,
                                    color: Colors.purple[500]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
