import 'package:flutter/material.dart';

import 'category_title.dart';

class AboutBookSection extends StatelessWidget {
  const AboutBookSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          CategoryTitle(title: "About The Book"),
          Text(
            "Looking for the big picture of building APIs? This book is for you! Building APIs that consumers love should certainly be the goal of any API initiative. However, it is easier said than done. It requires getting the architecture for your APIs right. This book equips you with both foundations and best practices for API architecture. This book is for you if you want to understand the big picture of API design and development, you want to define an API architecture, establish a platform for APIs or simply want to build APIs your consumers love. This book is NOT for you, if you are looking for a step-by step guide for building APIs, focusing on every detail of the correct application of REST principles. In this case I recommend the book \"API Design\" of the API-University Series. What is API architecture? Architecture spans the bigger picture of APIs and can be seen from several perspectives: API architecture may refer to the architecture of the complete solution consisting not only of the API itself, but also of an API client such as a mobile app and several other components. API solution architecture explains the components and their relations within the software solution. API architecture may refer to the technical architecture of the API platform. When building, running and exposing not only one, but several APIs, it becomes clear that certain building blocks of the API, runtime functionality and management functionality for the API need to be used over and over again. An API platform provides an infrastructure for developing, running and managing APIs. API architecture may refer to the architecture of the API portfolio. The API portfolio contains all APIs of the enterprise and needs to be managed like a product. API portfolio architecture analyzes the functionality of the API and organizes, manages and reuses the APIs. API architecture may refer to the design decisions for a particular API proxy. To document the design decisions, API description languages are used. We explain the use of API description languages (RAML and Swagger) on many examples. This book covers all of the above perspectives on API architecture. However, to become useful, the architecture needs to be put into practice. This is why this book covers an API methodology for design and development. An API methodology provides practical guidelines for putting API architecture into practice. It explains how to develop an API architecture into an API that consumers love. A lot of the information on APIs is available on the web. Most of it is published by vendors of API products. I am always a bit suspicious of technical information pushed by product vendors. This book is different. In this book, a product-independent view on API architecture is presented. The API-University Series is a modular series of books on API-related topics. Each book focuses on a particular API topic, so you can select the topics within APIs, which are relevant for you.",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
