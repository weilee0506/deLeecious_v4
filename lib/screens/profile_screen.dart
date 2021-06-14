import 'package:deleecious_v4/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../provider/login.dart';
import '../models/restautants.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  var _restaurants_data1 = [
    {
      "id": "1",
      "name": "賢夫美食",
      "address": "臺北市中正區羅斯福路四段92號79攤",
      "lng.": "121.535",
      "lat.": "25.01365",
      "time": "10:00-18:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e46ad142756dd434ce25fe7-%E8%B3%A2%E5%A4%AB%E7%BE%8E%E9%A3%9F"
    },
    {
      "id": "2",
      "name": "東雛菊-風味鍋物",
      "address": "臺北市中正區汀州路三段127號",
      "lng.": "121.5306",
      "lat.": "25.01639",
      "time": "11:30-15:00, 17:30-22:00",
      "cuisine_type": "中式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e7f5d4c2756dd7a62627b62-%E6%9D%B1%E9%9B%9B%E8%8F%8A-%E9%A2%A8%E5%91%B3%E9%8D%8B%E7%89%A9"
    },
    {
      "id": "3",
      "name": "俄羅斯城堡",
      "address": "臺北市大安區羅斯福路三段333巷14號",
      "lng.": "121.5325",
      "lat.": "25.01749",
      "time": "12:00-15:00, 17:00-21:30",
      "cuisine_type": "俄羅斯式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a67406c03a104df53ca398-%E4%BF%84%E7%BE%85%E6%96%AF%E5%9F%8E%E5%A0%A1"
    },
    {
      "id": "4",
      "name": "福二漢堡製造所",
      "address": "臺北市中正區汀洲路三段229號",
      "lng.": "121.534",
      "lat.": "25.01401",
      "cuisine_type": "中式|義式|美式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/6020b390d6895d231a95c479-%E7%A6%8F%E4%BA%8C%E6%BC%A2%E5%A0%A1%E8%A3%BD%E9%80%A0%E6%89%80"
    },
    {
      "id": "5",
      "name": "麻煮MiNi麻辣煲 公館店",
      "address": "臺北市中正區汀州路三段273號1樓",
      "lng.": "121.5355",
      "lat.": "25.01249",
      "time": "11:30-14:00, 17:00-23:00",
      "cuisine_type": "中式",
      "rating": "3.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/600f741d02935e535fd8ad52-%E9%BA%BB%E7%85%AEMiNi%E9%BA%BB%E8%BE%A3%E7%85%B2-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "6",
      "name": "日日裝茶 公館台大店",
      "address": "臺北市大安區新生南路三段96之4號",
      "lng.": "121.5331",
      "lat.": "25.01717",
      "time": "11:00-22:00",
      "cuisine_type": "飲料",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f97bfe2d6895d2108d82b3b-%E6%97%A5%E6%97%A5%E8%A3%9D%E8%8C%B6-%E5%85%AC%E9%A4%A8%E5%8F%B0%E5%A4%A7%E5%BA%97"
    },
    {
      "id": "7",
      "name": "66屋丼飯",
      "address": "臺北市中正區羅斯福路四段92號66攤位",
      "lng.": "121.535",
      "lat.": "25.01371",
      "time": "11:00-20:00",
      "cuisine_type": "中式|日式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/601655ac8c906d3847207611-66%E5%B1%8B%E4%B8%BC%E9%A3%AF"
    },
    {
      "id": "8",
      "name": "BFF Gossip Brunch 早午餐",
      "address": "臺北市中正區羅斯福路三段244巷14號",
      "lng.": "121.5307",
      "lat.": "25.01654",
      "time": "11:00-21:00",
      "cuisine_type": "義式|美式|法式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ca63b822261391078e82de9-BFF-Gossip-Brunch-%E6%97%A9%E5%8D%88"
    },
    {
      "id": "9",
      "name": "湛盧咖啡台大館",
      "address": "臺北市中正區羅斯福路三段284巷2號",
      "lng.": "121.5319",
      "lat.": "25.01606",
      "time": "11:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d404cc03a103ee86c57a8-%E6%B9%9B%E7%9B%A7%E5%92%96%E5%95%A1%E5%8F%B0%E5%A4%A7%E9%A4%A8"
    },
    {
      "id": "10",
      "name": "異‧香料館",
      "address": "臺北市大安區羅斯福路三段269巷6號",
      "lng.": "121.5305",
      "lat.": "25.01934",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "印式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d262fc03a103ee86c45dd-%E7%95%B0%E2%80%A7%E9%A6%99%E6%96%99%E9%A4%A8"
    },
    {
      "id": "11",
      "name": "炸鷄大獅北市公館店",
      "address": "臺北市中正區羅斯福路三段316巷3號",
      "lng.": "121.5325",
      "lat.": "25.01579",
      "time": "11:30-22:30",
      "cuisine_type": "美式|台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/60079c8802935e20bccdf61f-%E7%82%B8%E9%B7%84%E5%A4%A7%E7%8D%85%E5%8C%97%E5%B8%82%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "12",
      "name": "茗香園冰室(公館店)",
      "address": "臺北市中正區羅斯福路四段132號2F",
      "lng.": "121.5358",
      "lat.": "25.01298",
      "time": "11:30-15:00, 17:00-21:30",
      "cuisine_type": "港式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c219e7423679c1c11954e96-%E8%8C%97%E9%A6%99%E5%9C%92%E5%86%B0%E5%AE%A4(%E5%85%AC%E9%A4%A8%E5%BA%97)"
    },
    {
      "id": "13",
      "name": "雄記蔥抓餅",
      "address": "臺北市中正區羅斯福路四段108巷2號",
      "lng.": "121.5353",
      "lat.": "25.01329",
      "time": "15:30-00:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5caf4d8a2756dd4c1c074ae1-%E9%9B%84%E8%A8%98%E8%94%A5%E6%8A%93%E9%A4%85"
    },
    {
      "id": "14",
      "name": "Flovie花漾薇漫",
      "address": "臺北市中正區羅斯福路三段244巷10弄19號",
      "lng.": "121.5315",
      "lat.": "25.01612",
      "time": "10:30-21:00",
      "cuisine_type": "義式",
      "rating": "5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ff67fee2261391b95567929-Flovie%E8%8A%B1%E6%BC%BE%E8%96%87%E6%BC%AB"
    },
    {
      "id": "15",
      "name": "3 Idiots Toast & Curry",
      "address": "臺北市大安區羅斯福路三段283巷28號",
      "lng.": "121.5317",
      "lat.": "25.01887",
      "time": "11:30-14:30, 17:30-21:30",
      "cuisine_type": "印式",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58791c512756dd4b7d640760-3-Idiots-Toast-%26-Cur"
    },
    {
      "id": "16",
      "name": "光一肆號",
      "address": "臺北市大安區新生南路三段76巷2號",
      "lng.": "121.5335",
      "lat.": "25.01923",
      "time": "10:00-21:00",
      "cuisine_type": "美式|義式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ad3752222613912b901ea63-%E5%85%89%E4%B8%80%E8%82%86%E8%99%9F"
    },
    {
      "id": "17",
      "name": "曉鹿鳴樓",
      "address": "臺北市大安區羅斯福路四段85號",
      "lng.": "121.5368",
      "lat.": "25.01305",
      "time": "11:00-14:30, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5bc1f4ca22613966a60c3f9c-%E6%9B%89%E9%B9%BF%E9%B3%B4%E6%A8%93"
    },
    {
      "id": "18",
      "name": "Moody Belly",
      "address": "臺北市中正區羅斯福路四段136巷6弄23號",
      "lng.": "121.5358",
      "lat.": "25.01217",
      "time": "12:00-20:00",
      "cuisine_type": "韓式",
      "rating": "4.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5feb36b402935e7cfd86dc64-Moody-Belly"
    },
    {
      "id": "19",
      "name": "辛殿麻辣鍋 公館店",
      "address": "臺北市中正區羅斯福路三段316巷9弄1號",
      "lng.": "121.5318",
      "lat.": "25.01557",
      "time": "00:00-01:30, 11:30-00:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5f90fe0902935e35cd626b65-%E8%BE%9B%E6%AE%BF%E9%BA%BB%E8%BE%A3%E9%8D%8B-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "20",
      "name": "赤神日式豬排",
      "address": "臺北市中正區羅斯福路3段286巷4弄14號",
      "lng.": "121.5318",
      "lat.": "25.01579",
      "time": "11:30-22:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d53ebc03a103ee86c6421-%E8%B5%A4%E7%A5%9E%E6%97%A5%E5%BC%8F%E8%B1%AC%E6%8E%92"
    },
    {
      "id": "21",
      "name": "狠台 台式炒飯炒麵",
      "address": "臺北市中正區羅斯福路四段92號水源市場15號攤",
      "lng.": "121.535",
      "lat.": "25.01371",
      "time": "11:15-14:00, 16:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe745088c906d4bc548dd17-%E7%8B%A0%E5%8F%B0-%E5%8F%B0%E5%BC%8F%E7%82%92%E9%A3%AF%E7%82%92%E9%BA%B5"
    },
    {
      "id": "22",
      "name": "阿布都中東料理Abdu Arabian Cuisine",
      "address": "臺北市大安區新生南路三段106號二樓之一",
      "lng.": "121.5328",
      "lat.": "25.01678",
      "time": "17:30-21:00",
      "cuisine_type": "中東式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fe60d398c906d5744f7ad11-%E9%98%BF%E5%B8%83%E9%83%BD%E4%B8%AD%E6%9D%B1%E6%96%99%E7%90%86Abdu-Arabian-"
    },
    {
      "id": "23",
      "name": "小原田 公館店",
      "address": "臺北市大安區羅斯福路三段277號2F",
      "lng.": "121.5311",
      "lat.": "25.01816",
      "time": "11:30-14:30, 17:30-21:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e04c08d22613936edcf9e08-%E5%B0%8F%E5%8E%9F%E7%94%B0-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "24",
      "name": "兩點(手作茶飲+車輪餅)公館店",
      "address": "臺北市中正區汀州路三段185號",
      "lng.": "121.5329",
      "lat.": "25.01476",
      "time": "12:00-21:00",
      "cuisine_type": "飲料",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e7f5d4f2756dd7a62627b64-%E5%85%A9%E9%BB%9E(%E6%89%8B%E4%BD%9C%E8%8C%B6%E9%A3%B2%2B%E8%BB%8A%E8%BC%AA%E9%A4%85)%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "25",
      "name": "和牛涮樂日式涮涮鍋 公館店",
      "address": "臺北市中正區汀州路三段92號",
      "lng.": "121.535",
      "lat.": "25.01371",
      "time": "11:30-23:00",
      "cuisine_type": "日式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fe16052226139731a906b91-%E5%92%8C%E7%89%9B%E6%B6%AE%E6%A8%82%E6%97%A5%E5%BC%8F%E6%B6%AE%E6%B6%AE%E9%8D%8B-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "26",
      "name": "Box巴克斯韭菜盒子蛋餅公館店",
      "address": "臺北市中正區羅斯福路三段316巷8弄14號",
      "lng.": "121.5326",
      "lat.": "25.01532",
      "time": "07:00-21:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5bd9babc2756dd2e250176f0-Box%E5%B7%B4%E5%85%8B%E6%96%AF%E9%9F%AD%E8%8F%9C%E7%9B%92%E5%AD%90%E8%9B%8B%E9%A4%85%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "27",
      "name": "義饗食堂",
      "address": "臺北市中正區羅斯福路四段83號2樓",
      "lng.": "121.5364",
      "lat.": "25.01338",
      "time": "12:00-14:30, 18:00-21:30",
      "cuisine_type": "義式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559da9aac03a103ee86c9700-%E7%BE%A9%E9%A5%97%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "28",
      "name": "十杯極致手作茶飲─公館店",
      "address": "臺北市中正區汀州路三段277號",
      "lng.": "121.5355",
      "lat.": "25.0124",
      "time": "11:00-23:00",
      "cuisine_type": "飲料",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fdcbb262756dd79f8c3b632-%E5%8D%81%E6%9D%AF%E6%A5%B5%E8%87%B4%E6%89%8B%E4%BD%9C%E8%8C%B6%E9%A3%B2%E2%94%80%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "29",
      "name": "YU POKÉ-夏威夷生魚飯",
      "address": "臺北市中正區羅斯福路四段24巷12弄4號",
      "lng.": "121.5329",
      "lat.": "25.01498",
      "time": "11:30-20:30",
      "cuisine_type": "夏威夷式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ca402ba2261390af6989b96-YU-POK%C3%89-%E5%A4%8F%E5%A8%81%E5%A4%B7%E7%94%9F%E9%AD%9A%E9%A3%AF"
    },
    {
      "id": "30",
      "name": "成真咖啡 臺北台大店",
      "address": "臺北市大安區新生南路三段110號",
      "lng.": "121.5327",
      "lat.": "25.01669",
      "time": "11:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5d84b2172261390b5c7b56a7-%E6%88%90%E7%9C%9F%E5%92%96%E5%95%A1-%E5%8F%B0%E5%8C%97%E5%8F%B0%E5%A4%A7%E5%BA%97"
    },
    {
      "id": "31",
      "name": "貓食光 Time With Cats",
      "address": "臺北市大安區羅斯福路三段297之1號1樓",
      "lng.": "121.5317",
      "lat.": "25.01764",
      "time": "12:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fe00c7002935e78c0bcb4ef-%E8%B2%93%E9%A3%9F%E5%85%89-Time-With-Cats"
    },
    {
      "id": "32",
      "name": "霞飛驛PoSt義大利麵",
      "address": "臺北市大安區新生南路三段60巷8號",
      "lng.": "121.5334",
      "lat.": "25.01999",
      "time": "11:00-14:30, 17:00-21:30",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d1de2c03a103ee86c40da-%E9%9C%9E%E9%A3%9B%E9%A9%9BPoSt%E7%BE%A9%E5%A4%A7%E5%88%A9%E9%BA%B5"
    },
    {
      "id": "33",
      "name": "貳樓餐廳 Second Floor Cafe 公館店",
      "address": "臺北市中正區羅斯福路三段316巷9弄7號",
      "lng.": "121.5316",
      "lat.": "25.01578",
      "time": "10:00-22:30",
      "cuisine_type": "義式|美式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559daf31c03a103ee86c9b21-%E8%B2%B3%E6%A8%93%E9%A4%90%E5%BB%B3-Second-Floor-Ca"
    },
    {
      "id": "34",
      "name": "池先生 Kopitiam 公館店",
      "address": "臺北市中正區羅斯福路三段284巷10號",
      "lng.": "121.5318",
      "lat.": "25.01597",
      "time": "11:30-15:30, 17:00-20:45",
      "cuisine_type": "東南亞",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59dbbacd2756dd1e89198c9f-%E6%B1%A0%E5%85%88%E7%94%9F-Kopitiam-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "35",
      "name": "墨洋拉麵",
      "address": "臺北市中正區羅斯福路四段136巷10號",
      "lng.": "121.5354",
      "lat.": "25.01259",
      "time": "12:00-14:00, 17:00-21:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f1eddfed6895d462756373b-%E5%A2%A8%E6%B4%8B%E6%8B%89%E9%BA%B5"
    },
    {
      "id": "36",
      "name": "泰味鮮",
      "address": "臺北市中正區羅斯福路三段316巷8弄3之4號",
      "lng.": "121.5326",
      "lat.": "25.01564",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "泰式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f3557b622613979f8854fcd-%E6%B3%B0%E5%91%B3%E9%AE%AE"
    },
    {
      "id": "37",
      "name": "母女の店泰式簡餐",
      "address": "臺北市中正區羅斯福路三段286巷4弄10號",
      "lng.": "121.5319",
      "lat.": "25.01592",
      "time": "11:30-14:00, 17:00-20:30",
      "cuisine_type": "泰式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56ce98852756dd1c6e19f154-%E6%AF%8D%E5%A5%B3%E3%81%AE%E5%BA%97%E6%B3%B0%E5%BC%8F%E7%B0%A1%E9%A4%90"
    },
    {
      "id": "38",
      "name": "愛樂廚房",
      "address": "臺北市中正區羅斯福路三段282號2樓",
      "lng.": "121.5321",
      "lat.": "25.0165",
      "time": "11:30-14:30, 17:00-22:00",
      "cuisine_type": "韓式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d0180c03a103ee86c3299-%E6%84%9B%E6%A8%82%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "39",
      "name": "YumYum 好吃好吃2號店",
      "address": "臺北市中正區羅斯福路三段316巷16號2樓",
      "lng.": "121.5324",
      "lat.": "25.01545",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "美式",
      "rating": "3.6",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5dd358658c906d1ce32e9354-YumYum-%E5%A5%BD%E5%90%83%E5%A5%BD%E5%90%832%E8%99%9F%E5%BA%97"
    },
    {
      "id": "40",
      "name": "何太守港式菠蘿包專賣店",
      "address": "臺北市中正區汀州路三段167號",
      "lng.": "121.5323",
      "lat.": "25.01527",
      "time": "11:00-22:00",
      "cuisine_type": "港式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ae8ad182756dd5d801ddfaf-%E4%BD%95%E5%A4%AA%E5%AE%88%E6%B8%AF%E5%BC%8F%E8%8F%A0%E8%98%BF%E5%8C%85%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "41",
      "name": "Half_coffee",
      "address": "臺北市中正區羅斯福路三段286巷4弄4號1樓",
      "lng.": "121.5321",
      "lat.": "25.01599",
      "time": "13:00-20:00",
      "cuisine_type": "咖啡",
      "rating": "4.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e684faf22613924ff3eb9e7-Half_coffee"
    },
    {
      "id": "42",
      "name": "順園小館",
      "address": "臺北市中正區汀州路三段281號",
      "lng.": "121.5356",
      "lat.": "25.01238",
      "time": "11:00-14:00, 16:30-21:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d63abc03a103ee86c6e04-%E9%A0%86%E5%9C%92%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "43",
      "name": "泰街頭",
      "address": "臺北市大安區溫州街74巷6號1樓",
      "lng.": "121.5322",
      "lat.": "25.01983",
      "time": "11:30-14:30, 17:00-21:00",
      "cuisine_type": "泰式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56feb87b2756dd4eead641d4-%E6%B3%B0%E8%A1%97%E9%A0%AD"
    },
    {
      "id": "44",
      "name": "朕點麻小面",
      "address": "臺北市中正區汀州路三段77號",
      "lng.": "121.5286",
      "lat.": "25.01779",
      "time": "16:00-23:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b1039b72756dd5361ca15f4-%E6%9C%95%E9%BB%9E%E9%BA%BB%E5%B0%8F%E9%9D%A2"
    },
    {
      "id": "45",
      "name": "黛黛茶 DailyDae公館秀泰店-歐風水果茶",
      "address": "臺北市中正區羅斯福路四段136巷3號",
      "lng.": "121.5355",
      "lat.": "25.01272",
      "time": "10:00-23:00",
      "cuisine_type": "飲料",
      "rating": "4.8",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fb4d99ed6895d43254a9492-%E9%BB%9B%E9%BB%9B%E8%8C%B6-DailyDae%E5%85%AC%E9%A4%A8%E7%A7%80%E6%B3%B0%E5%BA%97-%E6%AD%90%E9%A2%A8"
    },
    {
      "id": "46",
      "name": "保護傘 Aegis",
      "address": "臺北市大安區新生南路三段68號之2號一樓",
      "lng.": "121.5337",
      "lat.": "25.01968",
      "time": "11:30-20:30",
      "cuisine_type": "港式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5eccb81c8c906d5425f34f73-%E4%BF%9D%E8%AD%B7%E5%82%98-Aegis"
    },
    {
      "id": "47",
      "name": "太學口糯米腸包香腸",
      "address": "臺北市中正區羅斯福路三段286巷18號",
      "lng.": "121.5324",
      "lat.": "25.01586",
      "time": "11:30-00:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fb4f6af02935e6d981f984b-%E5%A4%AA%E5%AD%B8%E5%8F%A3%E7%B3%AF%E7%B1%B3%E8%85%B8%E5%8C%85%E9%A6%99%E8%85%B8"
    },
    {
      "id": "48",
      "name": "潮味決‧湯滷專門店 臺北公館分社",
      "address": "臺北市中正區羅斯福路三段284巷8號1樓北側",
      "lng.": "121.5319",
      "lat.": "25.01602",
      "time": "11:00-21:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fb278652261395f5ab4317a-%E6%BD%AE%E5%91%B3%E6%B1%BA%E2%80%A7%E6%B9%AF%E6%BB%B7%E5%B0%88%E9%96%80%E5%BA%97-%E5%8F%B0%E5%8C%97%E5%85%AC%E9%A4%A8%E5%88%86%E7%A4%BE"
    },
    {
      "id": "49",
      "name": "GURU HOUSE 台大公館店",
      "address": "臺北市大安區溫州街74巷5弄3號",
      "lng.": "121.5319",
      "lat.": "25.01942",
      "time": "09:00-22:00",
      "cuisine_type": "咖啡",
      "rating": "4.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fbf563a02935e27c21d42ce-GURU-HOUSE-%E5%8F%B0%E5%A4%A7%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "50",
      "name": "稻咖哩",
      "address": "臺北市大安區溫州街79號",
      "lng.": "121.5331",
      "lat.": "25.01994",
      "time": "17:00-21:00",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b94809c23679c2909e9a1df-%E7%A8%BB%E5%92%96%E5%93%A9"
    },
    {
      "id": "51",
      "name": "韓庭州",
      "address": "臺北市大安區溫州街87號",
      "lng.": "121.533",
      "lat.": "25.01915",
      "time": "11:00-14:30, 17:00-21:00",
      "cuisine_type": "韓式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d2b40c03a103ee86c4950-%E9%9F%93%E5%BA%AD%E5%B7%9E"
    },
    {
      "id": "52",
      "name": "李記正客家魷魚羹",
      "address": "臺北市中正區汀州路三段289號",
      "lng.": "121.5357",
      "lat.": "25.01212",
      "time": "06:50-19:30",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d3435c03a103ee86c4fc8-%E6%9D%8E%E8%A8%98%E6%AD%A3%E5%AE%A2%E5%AE%B6%E9%AD%B7%E9%AD%9A%E7%BE%B9"
    },
    {
      "id": "53",
      "name": "雪鍋168",
      "address": "臺北市中正區汀州路三段168號2樓",
      "lng.": "121.5345",
      "lat.": "25.01331",
      "time": "11:30-14:30, 17:00-22:00",
      "cuisine_type": "日式|中式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5faaa1ed2756dd10ff4c4c05-%E9%9B%AA%E9%8D%8B168"
    },
    {
      "id": "54",
      "name": "coco Brownies",
      "address": "臺北市大安區羅斯福路三段283巷14弄16-1號",
      "lng.": "121.5327",
      "lat.": "25.01786",
      "time": "12:00-21:00",
      "cuisine_type": "美式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a4f33fc03a10241de63ac7-coco-Brownies"
    },
    {
      "id": "55",
      "name": "哥德德式創意美食",
      "address": "臺北市大安區羅斯福路三段283巷11號",
      "lng.": "121.5315",
      "lat.": "25.01899",
      "time": "09:00-21:00",
      "cuisine_type": "德式",
      "rating": "4.3",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559da4a9c03a103ee86c93fd-%E5%93%A5%E5%BE%B7%E5%BE%B7%E5%BC%8F%E5%89%B5%E6%84%8F%E7%BE%8E%E9%A3%9F"
    },
    {
      "id": "56",
      "name": "TrueWin初韻 臺北公館店",
      "address": "臺北市中正區汀州路三段275號",
      "lng.": "121.5355",
      "lat.": "25.01245",
      "time": "11:00-23:00",
      "cuisine_type": "飲料",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fa40a8c2756dd493625c920-TrueWin%E5%88%9D%E9%9F%BB-%E5%8F%B0%E5%8C%97%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "57",
      "name": "三時午咖哩屋",
      "address": "臺北市中正區羅斯福路四段92號1樓",
      "lng.": "121.5348",
      "lat.": "25.01344",
      "time": "11:00-14:00, 16:00-18:00",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559dd247c03a103ee86caf92-%E4%B8%89%E6%99%82%E5%8D%88%E5%92%96%E5%93%A9%E5%B1%8B"
    },
    {
      "id": "58",
      "name": "窩巷弄",
      "address": "臺北市中正區羅斯福路四段78巷1弄11號",
      "lng.": "121.5342",
      "lat.": "25.01422",
      "time": "11:00-21:00",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5976aa63f524685cb1a4c50d-%E7%AA%A9%E5%B7%B7%E5%BC%84"
    },
    {
      "id": "59",
      "name": "倆倆號",
      "address": "臺北市中正區汀州路三段158-1號",
      "lng.": "121.5343",
      "lat.": "25.01354",
      "time": "08:00-21:00",
      "cuisine_type": "美式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57c9bedd2756dd6aa999bda5-%E5%80%86%E5%80%86%E8%99%9F"
    },
    {
      "id": "60",
      "name": "白糖粿",
      "address": "臺北市中正區羅斯福路四段108巷4之2號",
      "lng.": "121.5353",
      "lat.": "25.01318",
      "time": "15:30-23:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fa8af6302935e5dca0b0e5c-%E7%99%BD%E7%B3%96%E7%B2%BF"
    },
    {
      "id": "61",
      "name": "貝菈小屋",
      "address": "臺北市大安區辛亥路二段159號",
      "lng.": "121.5407",
      "lat.": "25.0217",
      "time": "11:30-14:30, 17:00-21:00",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b803d8222613912e1167680-%E8%B2%9D%E8%8F%88%E5%B0%8F%E5%B1%8B"
    },
    {
      "id": "62",
      "name": "靜壽司",
      "address": "臺北市中正區羅斯福路三段316巷7之1號",
      "lng.": "121.5322",
      "lat.": "25.01567",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/570c9e882756dd3d8397508f-%E9%9D%9C%E5%A3%BD%E5%8F%B8"
    },
    {
      "id": "63",
      "name": "幸好沒錯過你 Master K.",
      "address": "臺北市中正區羅斯福路四段78巷1弄5號",
      "lng.": "121.5331",
      "lat.": "25.01528",
      "time": "11:30-14:30, 17:00-21:30",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55db5f662756dd45c3a23a7e-%E5%B9%B8%E5%A5%BD%E6%B2%92%E9%8C%AF%E9%81%8E%E4%BD%A0-Master-K."
    },
    {
      "id": "64",
      "name": "Open開房間桌遊餐酒館",
      "address": "臺北市大安區辛亥路二段145號一樓",
      "lng.": "121.54",
      "lat.": "25.02172",
      "time": "12:00-23:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f3f459002935e4d2651cc85-Open%E9%96%8B%E6%88%BF%E9%96%93%E6%A1%8C%E9%81%8A%E9%A4%90%E9%85%92%E9%A4%A8"
    },
    {
      "id": "65",
      "name": "法點法食 FA DEN FA SAï",
      "address": "臺北市中正區汀州路三段210號",
      "lng.": "121.5355",
      "lat.": "25.01205",
      "time": "12:00-19:00",
      "cuisine_type": "法式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56a11e712756dd55b02985f4-%E6%B3%95%E9%BB%9E%E6%B3%95%E9%A3%9F-FA-DEN-FA-SA%C3%AF"
    },
    {
      "id": "66",
      "name": "鼎豐鴛鴦麻辣火鍋",
      "address": "臺北市文山區羅斯福路四段200號",
      "lng.": "121.5366",
      "lat.": "25.0107",
      "time": "11:30-23:45",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5caeaf8bf5246874dd81196b-%E9%BC%8E%E8%B1%90%E9%B4%9B%E9%B4%A6%E9%BA%BB%E8%BE%A3%E7%81%AB%E9%8D%8B"
    },
    {
      "id": "67",
      "name": "戰醬燒肉",
      "address": "臺北市中正區羅斯福路三段316巷7之3號",
      "lng.": "121.5322",
      "lat.": "25.01567",
      "time": "12:00-22:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5b5a0ed12756dd1ee91b66fd-%E6%88%B0%E9%86%AC%E7%87%92%E8%82%89"
    },
    {
      "id": "68",
      "name": "騰堂麵包茶飲",
      "address": "臺北市中正區汀州路三段135號",
      "lng.": "121.531",
      "lat.": "25.01614",
      "time": "10:30-20:00",
      "cuisine_type": "日式|歐式",
      "rating": "4.6",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c0f7a722261395af93bb47b-%E9%A8%B0%E5%A0%82%E9%BA%B5%E5%8C%85%E8%8C%B6%E9%A3%B2"
    },
    {
      "id": "69",
      "name": "素食地瓜球",
      "address": "臺北市中正區羅斯福路四段108巷8之1號",
      "lng.": "121.5351",
      "lat.": "25.01307",
      "time": "15:30-22:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5cb81675f524683336995f38-%E7%B4%A0%E9%A3%9F%E5%9C%B0%E7%93%9C%E7%90%83"
    },
    {
      "id": "70",
      "name": "鍋in百元風味火鍋",
      "address": "臺北市中正區汀州路三段196號",
      "lng.": "121.5353",
      "lat.": "25.01237",
      "time": "11:00-23:45",
      "cuisine_type": "台式|韓式|東南亞",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b344e9a23679c7b5a24ef54-%E9%8D%8Bin%E7%99%BE%E5%85%83%E9%A2%A8%E5%91%B3%E7%81%AB%E9%8D%8B"
    },
    {
      "id": "71",
      "name": "威宇牛排-公館店",
      "address": "臺北市中正區汀州路三段257號",
      "lng.": "121.5352",
      "lat.": "25.01298",
      "time": "11:00-23:00",
      "cuisine_type": "美式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e9c6072d6895d6fed8e5c41-%E5%A8%81%E5%AE%87%E7%89%9B%E6%8E%92-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "72",
      "name": "人性甜點",
      "address": "臺北市中正區羅斯福路三段286巷4弄1號",
      "lng.": "121.5321",
      "lat.": "25.01587",
      "time": "13:00-19:00",
      "cuisine_type": "法式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e7b691f2756dd7a65543cb1-%E4%BA%BA%E6%80%A7%E7%94%9C%E9%BB%9E"
    },
    {
      "id": "73",
      "name": "瓦崎燒烤火鍋 公館店",
      "address": "臺北市中正區羅斯福路四段24巷5號",
      "lng.": "121.5328",
      "lat.": "25.01533",
      "time": "11:30-00:00",
      "cuisine_type": "日式",
      "rating": "3.7",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d04e1c03a103ee86c3419-%E7%93%A6%E5%B4%8E%E7%87%92%E7%83%A4%E7%81%AB%E9%8D%8B-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "74",
      "name": "溏老鴨平價小火鍋",
      "address": "臺北市大安區新生南路三段70巷3號",
      "lng.": "121.5332",
      "lat.": "25.01963",
      "time": "11:40-15:00, 17:00-22:00",
      "cuisine_type": "日式|義式|中式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b9138862756dd16494f2a84-%E6%BA%8F%E8%80%81%E9%B4%A8%E5%B9%B3%E5%83%B9%E5%B0%8F%E7%81%AB%E9%8D%8B"
    },
    {
      "id": "75",
      "name": "JODO 飯糰咖啡手作專門店",
      "address": "臺北市中正區汀州路三段131號",
      "lng.": "121.5307",
      "lat.": "25.01627",
      "time": "07:30-20:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f6cabe52756dd64f219f627-JODO-%E9%A3%AF%E7%B3%B0%E5%92%96%E5%95%A1%E6%89%8B%E4%BD%9C%E5%B0%88%E9%96%80%E5%BA%97"
    },
    {
      "id": "76",
      "name": "JJ's POKE & CAFE 鮮魚沙拉飯",
      "address": "臺北市中正區汀州路三段160巷4號",
      "lng.": "121.5341",
      "lat.": "25.01327",
      "time": "11:00-20:30",
      "cuisine_type": "夏威夷式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ed11a7b2756dd5d11535728-JJ's-POKE-%26-CAFE-%E9%AE%AE%E9%AD%9A%E6%B2%99"
    },
    {
      "id": "77",
      "name": "黑洞珈琲店",
      "address": "臺北市中正區羅斯福路三段210巷8弄7號",
      "lng.": "121.5296",
      "lat.": "25.0182",
      "time": "11:00-20:00",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d9d88c7d6895d43b02d20b8-%E9%BB%91%E6%B4%9E%E7%8F%88%E7%90%B2%E5%BA%97"
    },
    {
      "id": "78",
      "name": "Bravo Burger 發福廚房 (台大店)",
      "address": "臺北市中正區羅斯福路四段44之1號2樓",
      "lng.": "121.5336",
      "lat.": "25.01517",
      "time": "11:30-22:00",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5737f85f2756dd73bbc2027d-Bravo-Burger-%E7%99%BC%E7%A6%8F%E5%BB%9A%E6%88%BF-(%E5%8F%B0"
    },
    {
      "id": "79",
      "name": "城市草倉 C-tea loft",
      "address": "臺北市大安區羅斯福路三段283巷19弄4號",
      "lng.": "121.5315",
      "lat.": "25.01943",
      "time": "12:00-22:00",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58a73be32756dd4667687e45-%E5%9F%8E%E5%B8%82%E8%8D%89%E5%80%89-C-tea-loft"
    },
    {
      "id": "80",
      "name": "得記港式麻辣鴨血",
      "address": "臺北市中正區羅斯福路四段52巷16弄4號",
      "lng.": "121.5336",
      "lat.": "25.01442",
      "time": "12:00-23:30",
      "cuisine_type": "港式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d5b49c03a103ee86c68bd-%E5%BE%97%E8%A8%98%E6%B8%AF%E5%BC%8F%E9%BA%BB%E8%BE%A3%E9%B4%A8%E8%A1%80"
    },
    {
      "id": "81",
      "name": "Cafe Bastille",
      "address": "臺北市大安區溫州街91號",
      "lng.": "121.533",
      "lat.": "25.0189",
      "time": "12:00-00:00",
      "cuisine_type": "咖啡",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f3628662261397681d520b2-Cafe-Bastille"
    },
    {
      "id": "82",
      "name": "丼壽司",
      "address": "臺北市中正區汀州路三段165號一樓",
      "lng.": "121.5323",
      "lat.": "25.01529",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f525d69d6895d7ce885c541-%E4%B8%BC%E5%A3%BD%E5%8F%B8"
    },
    {
      "id": "83",
      "name": "龍潭豆花",
      "address": "臺北市中正區汀州路三段239號",
      "lng.": "121.5341",
      "lat.": "25.01392",
      "time": "12:30-22:00",
      "cuisine_type": "飲料",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d4851c03a103ee86c5cd5-%E9%BE%8D%E6%BD%AD%E8%B1%86%E8%8A%B1"
    },
    {
      "id": "84",
      "name": "墨潮青蛙撞奶",
      "address": "臺北市中正區羅斯福路三段316巷１０號",
      "lng.": "121.5324",
      "lat.": "25.01564",
      "time": "12:00-22:00",
      "cuisine_type": "飲料",
      "rating": "3.5",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f4a64842756dd2482d867c6-%E5%A2%A8%E6%BD%AE%E9%9D%92%E8%9B%99%E6%92%9E%E5%A5%B6"
    },
    {
      "id": "85",
      "name": "索菲烤布蕾",
      "address": "臺北市中正區羅斯福路四段92號2樓",
      "lng.": "121.535",
      "lat.": "25.01365",
      "time": "12:00-20:00",
      "cuisine_type": "法式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b6dd3762756dd51603ccd74-%E7%B4%A2%E8%8F%B2%E7%83%A4%E5%B8%83%E8%95%BE"
    },
    {
      "id": "86",
      "name": "Pica Pica Café 喜鵲咖啡",
      "address": "臺北市大安區羅斯福路三段269巷74號",
      "lng.": "121.5317",
      "lat.": "25.02092",
      "time": "13:00-22:45",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d37f6c03a103ee86c522d-Pica-Pica-Caf%C3%A9-%E5%96%9C%E9%B5%B2%E5%92%96%E5%95%A1"
    },
    {
      "id": "87",
      "name": "藍家割包",
      "address": "臺北市中正區羅斯福路三段316巷8弄3號",
      "lng.": "121.5326",
      "lat.": "25.01564",
      "time": "11:00-23:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d7bc3c03a103ee86c7e94-%E8%97%8D%E5%AE%B6%E5%89%B2%E5%8C%85"
    },
    {
      "id": "88",
      "name": "凰上您好-臺北-公館店 Dear Queen Tea",
      "address": "臺北市中正區汀州路三段174之1號",
      "lng.": "121.5347",
      "lat.": "25.01321",
      "time": "10:00-23:00",
      "cuisine_type": "飲料",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d5e38e9d6895d4484f355c0-%E5%87%B0%E4%B8%8A%E6%82%A8%E5%A5%BD-%E5%8F%B0%E5%8C%97-%E5%85%AC%E9%A4%A8%E5%BA%97-Dear-Que"
    },
    {
      "id": "89",
      "name": "翠薪越南餐廳",
      "address": "臺北市中正區羅斯福路四段24巷11號",
      "lng.": "121.5326",
      "lat.": "25.01518",
      "time": "11:20-14:30, 17:20-21:00",
      "cuisine_type": "越式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559de241c03a103ee86cba7f-%E7%BF%A0%E8%96%AA%E8%B6%8A%E5%8D%97%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "90",
      "name": "umai我賣車輪餅",
      "address": "臺北市中正區羅斯福路四段136巷3號",
      "lng.": "121.5355",
      "lat.": "25.01272",
      "time": "15:30-23:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f30b26702935e3bfc5ed2eb-umai%E6%88%91%E8%B3%A3%E8%BB%8A%E8%BC%AA%E9%A4%85"
    },
    {
      "id": "91",
      "name": "喫尤平價鐵板燒 - 公館店",
      "address": "臺北市中正區汀州路三段247號",
      "lng.": "121.5343",
      "lat.": "25.0138",
      "time": "00:00-00:30, 11:00-00:00",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f2c171602935e4a3d64bd04-%E5%96%AB%E5%B0%A4%E5%B9%B3%E5%83%B9%E9%90%B5%E6%9D%BF%E7%87%92-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "92",
      "name": "picnic野餐咖啡",
      "address": "臺北市大安區溫州街75號",
      "lng.": "121.5331",
      "lat.": "25.02036",
      "time": "13:00-23:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d48bac03a103ee86c5d0a-picnic%E9%87%8E%E9%A4%90%E5%92%96%E5%95%A1"
    },
    {
      "id": "93",
      "name": "小飯館兒",
      "address": "臺北市中正區汀洲路三段202號",
      "lng.": "121.5354",
      "lat.": "25.01221",
      "time": "11:00-22:30",
      "cuisine_type": "韓式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d22b5c03a103ee86c43ce-%E5%B0%8F%E9%A3%AF%E9%A4%A8%E5%85%92"
    },
    {
      "id": "94",
      "name": "スシロー壽司郎 臺北公館店",
      "address": "臺北市中正區羅斯福路四段68號2樓",
      "lng.": "121.5343",
      "lat.": "25.01457",
      "time": "11:00-22:30",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ec53d2d2756dd0432ab2104-%E3%82%B9%E3%82%B7%E3%83%AD%E3%83%BC%E5%A3%BD%E5%8F%B8%E9%83%8E-%E5%8F%B0%E5%8C%97%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "95",
      "name": "胡饕米粉湯•黑白切 台大公館店",
      "address": "臺北市中正區羅斯福路三段284巷8號1樓",
      "lng.": "121.5318",
      "lat.": "25.01599",
      "time": "11:30-00:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5db68bb88c906d03788b38cd-%E8%83%A1%E9%A5%95%E7%B1%B3%E7%B2%89%E6%B9%AF%E2%80%A2%E9%BB%91%E7%99%BD%E5%88%87-%E5%8F%B0%E5%A4%A7%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "96",
      "name": "初牛 公館店",
      "address": "臺北市中正區汀州路3段169號",
      "lng.": "121.5323",
      "lat.": "25.01521",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58fba01bf524687c7554cfa2-%E5%88%9D%E7%89%9B-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "97",
      "name": "以利泡泡冰",
      "address": "臺北市大安區羅斯福路三段316巷8弄內",
      "lng.": "121.5326",
      "lat.": "25.01578",
      "time": "11:00-22:20",
      "cuisine_type": "飲料",
      "rating": "3.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a67b8bc03a104df53ca5ba-%E4%BB%A5%E5%88%A9%E6%B3%A1%E6%B3%A1%E5%86%B0"
    },
    {
      "id": "98",
      "name": "極麵屋-豚骨/公館拉麵/丼飯",
      "address": "臺北市中正區羅斯福路四段136巷6弄2號",
      "lng.": "121.5357",
      "lat.": "25.01266",
      "time": "11:30-14:30, 17:00-21:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ef812198c906d2841a2f501-%E6%A5%B5%E9%BA%B5%E5%B1%8B-%E8%B1%9A%E9%AA%A8%2F%E5%85%AC%E9%A4%A8%E6%8B%89%E9%BA%B5%2F%E4%B8%BC%E9%A3%AF"
    },
    {
      "id": "99",
      "name": "12MINI經典即享鍋-捷運公館店",
      "address": "臺北市中正區羅斯福路三段316巷14號",
      "lng.": "121.5323",
      "lat.": "25.01551",
      "time": "11:00-23:00",
      "cuisine_type": "泰式|日式|義式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5dfcd8e62756dd0f69066b06-12MINI%E7%B6%93%E5%85%B8%E5%8D%B3%E4%BA%AB%E9%8D%8B-%E6%8D%B7%E9%81%8B%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "100",
      "name": "鱷吐司 A Toast",
      "address": "臺北市中正區羅斯福路三段316巷8弄7號",
      "lng.": "121.5327",
      "lat.": "25.0154",
      "time": "08:00-15:30",
      "cuisine_type": "韓式|台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e6079c78c906d5a1d9d05be-%E9%B1%B7%E5%90%90%E5%8F%B8-A-Toast"
    },
    {
      "id": "101",
      "name": "兩津芙蓉蛋塔-公館店",
      "address": "臺北市中正區羅斯福路三段316巷2號",
      "lng.": "121.5327",
      "lat.": "25.01588",
      "time": "11:00-20:00",
      "cuisine_type": "港式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5eff3ef12756dd1c07e92546-%E5%85%A9%E6%B4%A5%E8%8A%99%E8%93%89%E8%9B%8B%E5%A1%94-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "102",
      "name": "呷飯團",
      "address": "臺北市中正區羅斯福路四段78巷2弄2號",
      "lng.": "121.5345",
      "lat.": "25.01393",
      "time": "06:00-10:30",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ebab11e2756dd5ff25cbca0-%E5%91%B7%E9%A3%AF%E5%9C%98"
    },
    {
      "id": "103",
      "name": "醉紅小飯廳",
      "address": "臺北市大安區羅斯福路三段333巷6號",
      "lng.": "121.5325",
      "lat.": "25.01723",
      "time": "11:30-15:00, 17:00-21:00",
      "cuisine_type": "港式|中式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58185ad9699b6e4f4dca9876-%E9%86%89%E7%B4%85%E5%B0%8F%E9%A3%AF%E5%BB%B3"
    },
    {
      "id": "104",
      "name": "指有雞飯 CHICKEN RICE ONLY",
      "address": "臺北市大安區溫州街74巷五弄3號",
      "lng.": "121.5319",
      "lat.": "25.01942",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "東南亞",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d94306ad6895d6989bb81a4-%E6%8C%87%E6%9C%89%E9%9B%9E%E9%A3%AF-CHICKEN-RICE-ON"
    },
    {
      "id": "105",
      "name": "厚宅咖哩",
      "address": "臺北市大安區辛亥路二段169號",
      "lng.": "121.541",
      "lat.": "25.02169",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d7b1449d6895d452e17a860-%E5%8E%9A%E5%AE%85%E5%92%96%E5%93%A9"
    },
    {
      "id": "106",
      "name": "Mr.雪腐 公館店",
      "address": "臺北市中正區羅斯福路三段244巷21號",
      "lng.": "121.5305",
      "lat.": "25.01665",
      "time": "12:00-22:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5989ffc42756dd421cbbb883-Mr.%E9%9B%AA%E8%85%90-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "107",
      "name": "魯肉飯香（金乓魯肉飯）",
      "address": "臺北市中正區羅斯福路三段316巷12號",
      "lng.": "121.5324",
      "lat.": "25.01558",
      "time": "15:00-00:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b2c6bb4f524682027c9db0e-%E9%AD%AF%E8%82%89%E9%A3%AF%E9%A6%99%EF%BC%88%E9%87%91%E4%B9%93%E9%AD%AF%E8%82%89%E9%A3%AF%EF%BC%89"
    },
    {
      "id": "108",
      "name": "紅盤子港式茶餐廳",
      "address": "臺北市中正區羅斯福路三段244巷9弄1-7號",
      "lng.": "121.5305",
      "lat.": "25.01716",
      "time": "11:30-14:30, 17:30-20:30",
      "cuisine_type": "港式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5eb0e4bd8c906d7dfcd3d36d-%E7%B4%85%E7%9B%A4%E5%AD%90%E6%B8%AF%E5%BC%8F%E8%8C%B6%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "109",
      "name": "雪可屋",
      "address": "臺北市大安區溫州街86號",
      "lng.": "121.5327",
      "lat.": "25.0189",
      "time": "12:00-00:00",
      "cuisine_type": "咖啡",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/564aca23699b6e69a41d5cb1-%E9%9B%AA%E5%8F%AF%E5%B1%8B"
    },
    {
      "id": "110",
      "name": "好雞匯鹹水雞-公館旗艦店",
      "address": "臺北市中正區羅斯福路四段70-1號\n",
      "lng.": "121.5344",
      "lat.": "25.01435",
      "time": "15:30-23:30",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ecd17bf2261394799ad163d-%E5%A5%BD%E9%9B%9E%E5%8C%AF%E9%B9%B9%E6%B0%B4%E9%9B%9E-%E5%85%AC%E9%A4%A8%E6%97%97%E8%89%A6%E5%BA%97"
    },
    {
      "id": "111",
      "name": "楽坡BonBox - 臺北公館店",
      "address": "臺北市大安區羅斯福路三段283巷10號",
      "lng.": "121.5316",
      "lat.": "25.01826",
      "time": "11:00-13:30, 17:00-20:00",
      "cuisine_type": "日式|台式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5ec55e8bd6895d67b4a96ca9-%E6%A5%BD%E5%9D%A1BonBox-%E5%8F%B0%E5%8C%97%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "112",
      "name": "NoName咖哩カレーライス台大店",
      "address": "臺北市大安區新生南路三段68之2號巷子進來第三間",
      "lng.": "121.5334",
      "lat.": "25.01969",
      "time": "11:00-14:00, 16:00-20:00",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ebff6ee2756dd19c9dac4f2-NoName%E5%92%96%E5%93%A9%E3%82%AB%E3%83%AC%E3%83%BC%E3%83%A9%E3%82%A4%E3%82%B9%E5%8F%B0%E5%A4%A7%E5%BA%97"
    },
    {
      "id": "113",
      "name": "Lazy Thai",
      "address": "臺北市大安區辛亥路二段165號1樓",
      "lng.": "121.5408",
      "lat.": "25.02173",
      "cuisine_type": "泰式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5ee2f6df8c906d316c3f89d6-Lazy-Thai"
    },
    {
      "id": "114",
      "name": "吃吐吧",
      "address": "臺北市中正區羅斯福路四段78巷1弄1號",
      "lng.": "121.5344",
      "lat.": "25.01399",
      "time": "07:00-15:00",
      "cuisine_type": "日式|義式|中式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5803c0b52756dd2d66153989-%E5%90%83%E5%90%90%E5%90%A7"
    },
    {
      "id": "115",
      "name": "台一牛奶大王",
      "address": "臺北市大安區新生南路三段82號",
      "lng.": "121.5335",
      "lat.": "25.01896",
      "time": "10:00-23:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d30e1c03a103ee86c4de2-%E5%8F%B0%E4%B8%80%E7%89%9B%E5%A5%B6%E5%A4%A7%E7%8E%8B"
    },
    {
      "id": "116",
      "name": "水源食坊",
      "address": "臺北市中正區羅斯福路四段92號",
      "lng.": "121.535",
      "lat.": "25.01371",
      "time": "12:00-14:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dd232c03a103ee86caf7b-%E6%B0%B4%E6%BA%90%E9%A3%9F%E5%9D%8A"
    },
    {
      "id": "117",
      "name": "兄弟蚵仔麵線",
      "address": "臺北市中正區汀州路三段235號",
      "lng.": "121.534",
      "lat.": "25.01397",
      "time": "11:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5e1f1c03a102ec1415491-%E5%85%84%E5%BC%9F%E8%9A%B5%E4%BB%94%E9%BA%B5%E7%B7%9A"
    },
    {
      "id": "118",
      "name": "大山東餅舖",
      "address": "臺北市中正區羅斯福路四段92號",
      "lng.": "121.535",
      "lat.": "25.01371",
      "time": "06:00-15:00",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e993113d6895d12a468ff39-%E5%A4%A7%E5%B1%B1%E6%9D%B1%E9%A4%85%E8%88%96"
    },
    {
      "id": "119",
      "name": "鴉片粉圓",
      "address": "臺北市中正區羅斯福路四段52巷16弄4號",
      "lng.": "121.5336",
      "lat.": "25.01442",
      "time": "12:00-23:30",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59ef803d2756dd291ac66147-%E9%B4%89%E7%89%87%E7%B2%89%E5%9C%93"
    },
    {
      "id": "120",
      "name": "Mr. 拉麵野崎家",
      "address": "臺北市中正區羅斯福路三段316巷9弄2號",
      "lng.": "121.532",
      "lat.": "25.01563",
      "time": "11:30-21:00",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e8f2f8b2756dd191855cc4a-Mr.-%E6%8B%89%E9%BA%B5%E9%87%8E%E5%B4%8E%E5%AE%B6"
    },
    {
      "id": "121",
      "name": "Flügel Studio",
      "address": "臺北市大安區辛亥路一段34巷3號",
      "lng.": "121.5303",
      "lat.": "25.01985",
      "time": "14:00-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d34a7c03a103ee86c500f-Fl%C3%BCgel-Studio"
    },
    {
      "id": "122",
      "name": "ImPerfect Café",
      "address": "臺北市大安區新生南路三段96之5號二樓",
      "lng.": "121.5331",
      "lat.": "25.01717",
      "time": "12:00-22:30",
      "cuisine_type": "咖啡",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55b941bb40b5e303a1d567f5-ImPerfect-Caf%C3%A9"
    },
    {
      "id": "123",
      "name": "師大分部臭豆腐",
      "address": "臺北市文山區Unnamed Road",
      "lng.": "121.581",
      "lat.": "24.99835",
      "time": "22:30-23:59",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e80aeef2756dd6032d6855e-%E5%B8%AB%E5%A4%A7%E5%88%86%E9%83%A8%E8%87%AD%E8%B1%86%E8%85%90"
    },
    {
      "id": "124",
      "name": "Mr.BRUNO",
      "address": "臺北市大安區溫州街46巷6之1號",
      "lng.": "121.5327",
      "lat.": "25.02175",
      "time": "12:00-20:00",
      "cuisine_type": "法式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5e7cba772756dd7a625dc8d1-Mr.BRUNO"
    },
    {
      "id": "125",
      "name": "B.R Junior",
      "address": "臺北市中正區羅斯福路四段52巷6號1樓",
      "lng.": "121.5338",
      "lat.": "25.0148",
      "time": "11:30-20:00",
      "cuisine_type": "美式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e954dad8c906d41a66429d1-B.R-Junior"
    },
    {
      "id": "126",
      "name": "鳳城燒臘粵菜",
      "address": "臺北市大安區新生南路三段58之3號",
      "lng.": "121.5338",
      "lat.": "25.02037",
      "time": "11:00-20:30",
      "cuisine_type": "港式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d38ebc03a103ee86c52df-%E9%B3%B3%E5%9F%8E%E7%87%92%E8%87%98%E7%B2%B5%E8%8F%9C"
    },
    {
      "id": "127",
      "name": "炸手指",
      "address": "臺北市中正區羅斯福路三段316巷8弄4號",
      "lng.": "121.5325",
      "lat.": "25.0156",
      "time": "15:00-00:00",
      "cuisine_type": "台式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e730a9d226139178802c66a-%E7%82%B8%E6%89%8B%E6%8C%87"
    },
    {
      "id": "128",
      "name": "大福利排骨大王",
      "address": "臺北市中正區羅斯福路三段286巷12號",
      "lng.": "121.5323",
      "lat.": "25.01599",
      "time": "11:00-20:30",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a57db6c03a10241de66ae4-%E5%A4%A7%E7%A6%8F%E5%88%A9%E6%8E%92%E9%AA%A8%E5%A4%A7%E7%8E%8B"
    },
    {
      "id": "129",
      "name": "幸福豆雲",
      "address": "臺北市大安區羅斯福路三段283巷36號",
      "lng.": "121.5318",
      "lat.": "25.01945",
      "time": "12:00-21:30",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e722e972756dd355c271015-%E5%B9%B8%E7%A6%8F%E8%B1%86%E9%9B%B2"
    },
    {
      "id": "130",
      "name": "米米珈琲 MiMi's Cafe",
      "address": "臺北市中正區羅斯福路三段284巷15號",
      "lng.": "121.5315",
      "lat.": "25.01588",
      "time": "12:00-23:00",
      "cuisine_type": "咖啡",
      "rating": "4.6",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a677aed2756dd60a4223160-%E7%B1%B3%E7%B1%B3%E7%8F%88%E7%90%B2-MiMi's-Cafe"
    },
    {
      "id": "131",
      "name": "土貓商號 Turkish Kedi",
      "address": "臺北市中正區汀州路三段104巷6號",
      "lng.": "121.5331",
      "lat.": "25.0141",
      "time": "14:30-23:30",
      "cuisine_type": "中東式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e947aacd6895d5269fa940b-%E5%9C%9F%E8%B2%93%E5%95%86%E8%99%9F-Turkish-Kedi"
    },
    {
      "id": "132",
      "name": "Mirage Bistro & Cafe @荒漠甘泉",
      "address": "臺北市中正區羅斯福路三段316巷18號",
      "lng.": "121.5323",
      "lat.": "25.0154",
      "time": "11:30-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d83d7c03a103ee86c8285-Mirage-Bistro-%26-Cafe"
    },
    {
      "id": "133",
      "name": "品軒樓",
      "address": "臺北市大安區羅斯福路四段1號臺大校園內卓越聯合中心",
      "lng.": "121.5398",
      "lat.": "25.01734",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e62fae38c906d64369dbbfa-%E5%93%81%E8%BB%92%E6%A8%93"
    },
    {
      "id": "134",
      "name": "龍記炒燴",
      "address": "臺北市中正區羅斯福路四段92號",
      "lng.": "121.535",
      "lat.": "25.01371",
      "time": "12:00-15:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559dd236c03a103ee86caf7f-%E9%BE%8D%E8%A8%98%E7%82%92%E7%87%B4"
    },
    {
      "id": "135",
      "name": "香港泉記小吃館",
      "address": "臺北市中正區羅斯福路四段24巷12弄3號",
      "lng.": "121.5328",
      "lat.": "25.01495",
      "time": "11:00-14:00, 16:00-20:00",
      "cuisine_type": "港式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e5d078ed6895d33cae6dcec-%E9%A6%99%E6%B8%AF%E6%B3%89%E8%A8%98%E5%B0%8F%E5%90%83%E9%A4%A8"
    },
    {
      "id": "136",
      "name": "新馬辣經典鴛鴦鍋-公館店",
      "address": "臺北市中正區汀州路三段295號",
      "lng.": "121.5358",
      "lat.": "25.01198",
      "time": "00:00-02:00, 11:30-00:00",
      "cuisine_type": "中式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5cb09f202756dd4c17072f53-%E6%96%B0%E9%A6%AC%E8%BE%A3%E7%B6%93%E5%85%B8%E9%B4%9B%E9%B4%A6%E9%8D%8B-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "137",
      "name": "小木屋鬆餅",
      "address": "臺北市大安區羅斯福路四段1號",
      "lng.": "121.5379",
      "lat.": "25.01452",
      "time": "07:30-19:30",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d1ec4c03a103ee86c4167-%E5%B0%8F%E6%9C%A8%E5%B1%8B%E9%AC%86%E9%A4%85"
    },
    {
      "id": "138",
      "name": "ToasToast 土司吐司",
      "address": "臺北市中正區汀州路三段160巷4之3號",
      "lng.": "121.5341",
      "lat.": "25.0133",
      "time": "07:00-14:00",
      "cuisine_type": "美式",
      "rating": "3.9",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/571fae0d2756dd50491042aa-ToasToast-%E5%9C%9F%E5%8F%B8%E5%90%90%E5%8F%B8"
    },
    {
      "id": "139",
      "name": "十二巷拉麵",
      "address": "臺北市中正區羅斯福路四段12巷1號",
      "lng.": "121.533",
      "lat.": "25.01569",
      "time": "11:00-15:00, 16:30-22:00",
      "cuisine_type": "日式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d8228c03a103ee86c81dd-%E5%8D%81%E4%BA%8C%E5%B7%B7%E6%8B%89%E9%BA%B5"
    },
    {
      "id": "140",
      "name": "El Sabroso Mexican Food",
      "address": "臺北市中正區汀州路三段107號之一",
      "lng.": "121.5298",
      "lat.": "25.01696",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "墨式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e4895b3d6895d324f8b5f14-El-Sabroso-Mexican-F"
    },
    {
      "id": "141",
      "name": "麻辣巴蕾正宗重慶酸辣粉",
      "address": "臺北市中正區汀州路三段183號",
      "lng.": "121.5327",
      "lat.": "25.01481",
      "time": "11:30-22:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e47fe612756dd2cb35e1710-%E9%BA%BB%E8%BE%A3%E5%B7%B4%E8%95%BE%E6%AD%A3%E5%AE%97%E9%87%8D%E6%85%B6%E9%85%B8%E8%BE%A3%E7%B2%89"
    },
    {
      "id": "142",
      "name": "Shishlik Pita x Kebab 西西里克中東串燒（餐館店）",
      "address": "臺北市中正區羅斯福路四段138號2樓",
      "lng.": "121.5358",
      "lat.": "25.01279",
      "time": "11:00-22:00",
      "cuisine_type": "中東式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d78e9ea22613955de9af524-Shishlik-Pita-x-Keba"
    },
    {
      "id": "143",
      "name": "祥記號美食小吃",
      "address": "臺北市中正區羅斯福路四段92號",
      "lng.": "121.535",
      "lat.": "25.01371",
      "time": "11:00-15:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559dd23dc03a103ee86caf88-%E7%A5%A5%E8%A8%98%E8%99%9F%E7%BE%8E%E9%A3%9F%E5%B0%8F%E5%90%83"
    },
    {
      "id": "144",
      "name": "曼谷燒",
      "address": "臺北市中正區羅斯福路三段286巷18號",
      "lng.": "121.5324",
      "lat.": "25.01586",
      "time": "11:30-14:30, 17:00-21:00",
      "cuisine_type": "泰式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c7015f8f52468056cf2d96c-%E6%9B%BC%E8%B0%B7%E7%87%92"
    },
    {
      "id": "145",
      "name": "麵工坊義大利麵公館JR店",
      "address": "臺北市中正區羅斯福路三段282號1樓",
      "lng.": "121.5321",
      "lat.": "25.0165",
      "time": "11:30-15:00, 17:00-20:30",
      "cuisine_type": "義式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e4410dc8c906d180d65c173-%E9%BA%B5%E5%B7%A5%E5%9D%8A%E7%BE%A9%E5%A4%A7%E5%88%A9%E9%BA%B5%E5%85%AC%E9%A4%A8JR%E5%BA%97"
    },
    {
      "id": "146",
      "name": "狂愛咖哩 Just Love Curry",
      "address": "臺北市中正區汀州路三段164號",
      "lng.": "121.5345",
      "lat.": "25.01338",
      "time": "11:00-22:00",
      "cuisine_type": "日式",
      "rating": "3.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e27ba85d6895d7f796d9b19-%E7%8B%82%E6%84%9B%E5%92%96%E5%93%A9-Just-Love-Curry"
    },
    {
      "id": "147",
      "name": "THAIHAND 右手餐廳",
      "address": "臺北市中正區羅斯福路三段306號",
      "lng.": "121.5325",
      "lat.": "25.01622",
      "time": "11:00-15:00, 17:00-22:00",
      "cuisine_type": "泰式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58600ac02756dd757bb8f23c-THAIHAND-%E5%8F%B3%E6%89%8B%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "148",
      "name": "好處 Have A Nice Day",
      "address": "臺北市大安區羅斯福路三段283巷14弄30號",
      "lng.": "121.5329",
      "lat.": "25.01839",
      "time": "11:00-22:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/576983742756dd134b34d03f-%E5%A5%BD%E8%99%95-Have-A-Nice-Day"
    },
    {
      "id": "149",
      "name": "人性空間 總店",
      "address": "臺北市中正區羅斯福路三段286巷4弄1之1號",
      "lng.": "121.5321",
      "lat.": "25.01587",
      "time": "11:00-23:00",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5cdbc4c422613973b56ca9b0-%E4%BA%BA%E6%80%A7%E7%A9%BA%E9%96%93-%E7%B8%BD%E5%BA%97"
    },
    {
      "id": "150",
      "name": "好想吃冰 かき氷",
      "address": "臺北市大安區溫州街80號",
      "lng.": "121.5328",
      "lat.": "25.01913",
      "time": "12:00-21:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5945707d2756dd524dd08e30-%E5%A5%BD%E6%83%B3%E5%90%83%E5%86%B0-%E3%81%8B%E3%81%8D%E6%B0%B7"
    },
    {
      "id": "151",
      "name": "風尚咖啡廳",
      "address": "臺北市大安區新生南路3段30號",
      "lng.": "121.5343",
      "lat.": "25.02346",
      "time": "07:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e25b76e2756dd6166099985-%E9%A2%A8%E5%B0%9A%E5%92%96%E5%95%A1%E5%BB%B3"
    },
    {
      "id": "152",
      "name": "Lacuz 新泰食餐廳",
      "address": "臺北市中正區羅斯福路四段85號2樓",
      "lng.": "121.5368",
      "lat.": "25.01305",
      "time": "11:30-15:00, 17:30-22:00",
      "cuisine_type": "泰式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57e17b962756dd1844d29e89-Lacuz-%E6%96%B0%E6%B3%B0%E9%A3%9F%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "153",
      "name": "泰豐味",
      "address": "臺北市大安區羅斯福路四段78巷1弄7之1號",
      "lng.": "121.5343",
      "lat.": "25.01413",
      "time": "11:00-14:00, 17:00-22:00",
      "cuisine_type": "泰式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e1f241a8c906d7e709e59d0-%E6%B3%B0%E8%B1%90%E5%91%B3"
    },
    {
      "id": "154",
      "name": "銀座越南餐館",
      "address": "臺北市中正區羅斯福路三段286巷4弄6號",
      "lng.": "121.532",
      "lat.": "25.01595",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "越式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5b977c03a10241de67dd6-%E9%8A%80%E5%BA%A7%E8%B6%8A%E5%8D%97%E9%A4%90%E9%A4%A8"
    },
    {
      "id": "155",
      "name": "魯山人和風壽喜燒鍋物",
      "address": "臺北市大安區羅斯福路四段85號",
      "lng.": "121.5368",
      "lat.": "25.01305",
      "time": "11:00-22:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5defaa492756dd1efe2363ad-%E9%AD%AF%E5%B1%B1%E4%BA%BA%E5%92%8C%E9%A2%A8%E5%A3%BD%E5%96%9C%E7%87%92%E9%8D%8B%E7%89%A9"
    },
    {
      "id": "156",
      "name": "埃及口味沙威瑪",
      "address": "臺北市大安區羅斯福路三段325號",
      "lng.": "121.5323",
      "lat.": "25.01711",
      "time": "12:00-21:30",
      "cuisine_type": "中東式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5b5a5c03a10241de67ca1-%E5%9F%83%E5%8F%8A%E5%8F%A3%E5%91%B3%E6%B2%99%E5%A8%81%E7%91%AA"
    },
    {
      "id": "157",
      "name": "孫東寶牛排大安羅斯福店",
      "address": "臺北市大安區羅斯福路三段277號",
      "lng.": "121.5311",
      "lat.": "25.01816",
      "time": "11:30-21:00",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5e86b63ad6895d3b0825fff9-%E5%AD%AB%E6%9D%B1%E5%AF%B6%E7%89%9B%E6%8E%92%E5%A4%A7%E5%AE%89%E7%BE%85%E6%96%AF%E7%A6%8F%E5%BA%97"
    },
    {
      "id": "158",
      "name": "金雞園",
      "address": "臺北市中正區羅斯福路三段316巷8弄3之1號",
      "lng.": "121.5326",
      "lat.": "25.01564",
      "time": "10:00-22:00",
      "cuisine_type": "中式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d7cebc03a103ee86c7f14-%E9%87%91%E9%9B%9E%E5%9C%92"
    },
    {
      "id": "159",
      "name": "三米三小館",
      "address": "臺北市中正區羅斯福路三段286巷4弄12號",
      "lng.": "121.5319",
      "lat.": "25.01589",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d157a4c8c906d181dff5657-%E4%B8%89%E7%B1%B3%E4%B8%89%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "160",
      "name": "狗一下居食酒屋公館店",
      "address": "臺北市中正區汀州路三段271號",
      "lng.": "121.5355",
      "lat.": "25.01253",
      "time": "00:00-02:00, 11:30-14:30, 17:00-00:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dc51ac03a103ee86ca857-%E7%8B%97%E4%B8%80%E4%B8%8B%E5%B1%85%E9%A3%9F%E9%85%92%E5%B1%8B%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "161",
      "name": "依依平價小火鍋",
      "address": "臺北市大安區辛亥路二段161號",
      "lng.": "121.5407",
      "lat.": "25.0217",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "台式|韓式|泰式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e0ab636d6895d5166bb1936-%E4%BE%9D%E4%BE%9D%E5%B9%B3%E5%83%B9%E5%B0%8F%E7%81%AB%E9%8D%8B"
    },
    {
      "id": "162",
      "name": "山嵐拉麵公館店",
      "address": "臺北市中正區羅斯福路四段136巷1弄13號",
      "lng.": "121.5354",
      "lat.": "25.01302",
      "time": "11:30-14:30, 17:15-20:45",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5af3389d2756dd6a5d7c3425-%E5%B1%B1%E5%B5%90%E6%8B%89%E9%BA%B5%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "163",
      "name": "轉轉發現義大利麵",
      "address": "臺北市大安區新生南路三段86巷6號",
      "lng.": "121.5331",
      "lat.": "25.01892",
      "time": "11:00-14:30, 17:00-21:00",
      "cuisine_type": "義式",
      "rating": "3",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559dc1d3c03a103ee86ca5c7-%E8%BD%89%E8%BD%89%E7%99%BC%E7%8F%BE%E7%BE%A9%E5%A4%A7%E5%88%A9%E9%BA%B5"
    },
    {
      "id": "164",
      "name": "QUICHEZ派出所",
      "address": "臺北市大安區溫州街74巷14號",
      "lng.": "121.5318",
      "lat.": "25.0198",
      "time": "09:00-21:30",
      "cuisine_type": "法式",
      "rating": "4.6",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56dafa772756dd103725895f-QUICHEZ%E6%B4%BE%E5%87%BA%E6%89%80"
    },
    {
      "id": "165",
      "name": "秋紅肚房",
      "address": "臺北市中正區汀州路三段230巷43號",
      "lng.": "121.5323",
      "lat.": "25.01069",
      "time": "11:00-18:00",
      "cuisine_type": "台式|咖啡",
      "rating": "4.7",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5caf5d902261395a335229b8-%E7%A7%8B%E7%B4%85%E8%82%9A%E6%88%BF"
    },
    {
      "id": "166",
      "name": "秀食屋Shows House 關東煮專賣店",
      "address": "臺北市中正區汀州路三段227號",
      "lng.": "121.5339",
      "lat.": "25.01404",
      "time": "11:30-14:00, 16:30-22:00",
      "cuisine_type": "日式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b39899523679c5a984bccad-%E7%A7%80%E9%A3%9F%E5%B1%8BShows-House-%E9%97%9C%E6%9D%B1%E7%85%AE%E5%B0%88%E8%B3%A3"
    },
    {
      "id": "167",
      "name": "璞豆咖啡.日常",
      "address": "臺北市大安區溫州街66號",
      "lng.": "121.5329",
      "lat.": "25.0203",
      "time": "12:00-20:00",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d21ffdf2756dd4ea580e4b3-%E7%92%9E%E8%B1%86%E5%92%96%E5%95%A1.%E6%97%A5%E5%B8%B8"
    },
    {
      "id": "168",
      "name": "The Misanthrope Society 厭世會社",
      "address": "臺北市中正區羅斯福路四段40巷1之2號",
      "lng.": "121.5334",
      "lat.": "25.01504",
      "time": "00:00-01:00, 14:00-00:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c93b73622613914ef15eae9-The-Misanthrope-Soci"
    },
    {
      "id": "169",
      "name": "阿剛泰式主題餐廳",
      "address": "臺北市中正區汀州路三段150號",
      "lng.": "121.5341",
      "lat.": "25.01365",
      "time": "10:30-22:00",
      "cuisine_type": "泰式",
      "rating": "2.6",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58b660d123679c69cd2014ae-%E9%98%BF%E5%89%9B%E6%B3%B0%E5%BC%8F%E4%B8%BB%E9%A1%8C%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "170",
      "name": "泰正點",
      "address": "臺北市中正區汀州路三段166號",
      "lng.": "121.5345",
      "lat.": "25.01333",
      "time": "11:00-14:30, 17:00-22:00",
      "cuisine_type": "泰式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559de2f3c03a103ee86cbaf2-%E6%B3%B0%E6%AD%A3%E9%BB%9E"
    },
    {
      "id": "171",
      "name": "春風堂川渝麻辣",
      "address": "臺北市大安區羅斯福路三段283巷8號",
      "lng.": "121.5316",
      "lat.": "25.01821",
      "time": "11:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5dc51071d6895d2fd9e09b47-%E6%98%A5%E9%A2%A8%E5%A0%82%E5%B7%9D%E6%B8%9D%E9%BA%BB%E8%BE%A3"
    },
    {
      "id": "172",
      "name": "蕭家傳統小吃",
      "address": "臺北市中正區羅斯福路四段90巷6號",
      "lng.": "121.5345",
      "lat.": "25.0136",
      "time": "00:00-00:30, 11:30-00:00",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5dc4287f2756dd3a501efa86-%E8%95%AD%E5%AE%B6%E5%82%B3%E7%B5%B1%E5%B0%8F%E5%90%83"
    },
    {
      "id": "173",
      "name": "阿英滷肉飯",
      "address": "臺北市大安區溫州街74巷5弄1號",
      "lng.": "121.532",
      "lat.": "25.0197",
      "time": "11:30-13:30, 17:30-20:00",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5e0eec03a102ec1415440-%E9%98%BF%E8%8B%B1%E6%BB%B7%E8%82%89%E9%A3%AF"
    },
    {
      "id": "174",
      "name": "Chic Thai 泰式新定食",
      "address": "臺北市中正區汀州路三段166號2樓",
      "lng.": "121.5345",
      "lat.": "25.01333",
      "time": "11:00-14:30, 17:00-22:00",
      "cuisine_type": "泰式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a7ab16e2756dd7bff171dfc-Chic-Thai-%E6%B3%B0%E5%BC%8F%E6%96%B0%E5%AE%9A%E9%A3%9F"
    },
    {
      "id": "175",
      "name": "珍記豬血糕",
      "address": "臺北市中正區汀州路三段187號",
      "lng.": "121.533",
      "lat.": "25.01469",
      "time": "12:00-22:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d55a5c03a103ee86c653a-%E7%8F%8D%E8%A8%98%E8%B1%AC%E8%A1%80%E7%B3%95"
    },
    {
      "id": "176",
      "name": "劉記古早味蔥蛋餅",
      "address": "臺北市中正區羅斯福路四段108巷2之3號",
      "lng.": "121.5353",
      "lat.": "25.01317",
      "time": "15:00-00:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a661d3c03a104df53c9e6a-%E5%8A%89%E8%A8%98%E5%8F%A4%E6%97%A9%E5%91%B3%E8%94%A5%E8%9B%8B%E9%A4%85"
    },
    {
      "id": "177",
      "name": "小李豬血糕",
      "address": "臺北市中正區羅斯福路四段136巷1之3號",
      "lng.": "121.5356",
      "lat.": "25.01284",
      "time": "12:30-23:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d11fec03a103ee86c3a1f-%E5%B0%8F%E6%9D%8E%E8%B1%AC%E8%A1%80%E7%B3%95"
    },
    {
      "id": "178",
      "name": "公寓咖啡館 AGCT apartment",
      "address": "臺北市大安區溫州街49巷2之2號",
      "lng.": "121.5331",
      "lat.": "25.02138",
      "time": "12:00-18:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559db387c03a103ee86c9d30-%E5%85%AC%E5%AF%93%E5%92%96%E5%95%A1%E9%A4%A8-AGCT-apartment"
    },
    {
      "id": "179",
      "name": "麗江雲南美食小館",
      "address": "臺北市中正區汀州路三段83號",
      "lng.": "121.5288",
      "lat.": "25.01765",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d9c9b4f2756dd3fc126a1d8-%E9%BA%97%E6%B1%9F%E9%9B%B2%E5%8D%97%E7%BE%8E%E9%A3%9F%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "180",
      "name": "叫小賀地瓜",
      "address": "臺北市中正區羅斯福路四段4號",
      "lng.": "121.5328",
      "lat.": "25.01591",
      "time": "14:00-22:30",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d99eef52261395c66ef5e6c-%E5%8F%AB%E5%B0%8F%E8%B3%80%E5%9C%B0%E7%93%9C"
    },
    {
      "id": "181",
      "name": "希臘左巴",
      "address": "臺北市大安區羅斯福路三段283巷7弄16號",
      "lng.": "121.531",
      "lat.": "25.01881",
      "time": "11:00-22:00",
      "cuisine_type": "歐式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559dad4ac03a103ee86c999d-%E5%B8%8C%E8%87%98%E5%B7%A6%E5%B7%B4"
    },
    {
      "id": "182",
      "name": "聾啞雞蛋糕",
      "address": "臺北市大安區汀州路三段253號",
      "lng.": "121.5351",
      "lat.": "25.01305",
      "time": "15:00-22:00",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d2223c03a103ee86c4371-%E8%81%BE%E5%95%9E%E9%9B%9E%E8%9B%8B%E7%B3%95"
    },
    {
      "id": "183",
      "name": "日本清華軒",
      "address": "臺北市中正區羅斯福路四段92號",
      "lng.": "121.535",
      "lat.": "25.01371",
      "time": "11:30-14:00, 17:00-19:00",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559dd242c03a103ee86caf8e-%E6%97%A5%E6%9C%AC%E6%B8%85%E8%8F%AF%E8%BB%92"
    },
    {
      "id": "184",
      "name": "IceHolic 冰癮",
      "address": "臺北市中正區羅斯福路三段244巷13號",
      "lng.": "121.5306",
      "lat.": "25.01676",
      "time": "21:00-21:30",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c408fcd2756dd342350f833-IceHolic-%E5%86%B0%E7%99%AE"
    },
    {
      "id": "185",
      "name": "心KOKORO食堂",
      "address": "臺北市中正區汀州路三段104巷11弄15號一樓",
      "lng.": "121.5338",
      "lat.": "25.01347",
      "time": "12:00-16:00, 17:00-22:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d661c982261394c6c30114a-%E5%BF%83KOKORO%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "186",
      "name": "醉紅小酌",
      "address": "臺北市中正區羅斯福路三段240巷1號",
      "lng.": "121.5303",
      "lat.": "25.01816",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d63eaf72756dd2f131ef0ae-%E9%86%89%E7%B4%85%E5%B0%8F%E9%85%8C"
    },
    {
      "id": "187",
      "name": "站食可以",
      "address": "臺北市中正區羅斯福路四段24巷12弄7號",
      "lng.": "121.5328",
      "lat.": "25.01494",
      "time": "11:30-21:30",
      "cuisine_type": "中式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d5f4a2a8c906d0a79a450f7-%E7%AB%99%E9%A3%9F%E5%8F%AF%E4%BB%A5"
    },
    {
      "id": "188",
      "name": "泰國小館",
      "address": "臺北市中正區汀州路三段219號",
      "lng.": "121.5338",
      "lat.": "25.01411",
      "time": "11:30-21:30",
      "cuisine_type": "泰式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d7b7cc03a103ee86c7e6d-%E6%B3%B0%E5%9C%8B%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "189",
      "name": "首都烘焙餐廳-公館店",
      "address": "臺北市中正區羅斯福路三段284巷12號1樓",
      "lng.": "121.5317",
      "lat.": "25.01591",
      "time": "11:00-22:00",
      "cuisine_type": "韓式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5be838ae23679c6583927942-%E9%A6%96%E9%83%BD%E7%83%98%E7%84%99%E9%A4%90%E5%BB%B3-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "190",
      "name": "Happy fatty幸福肥",
      "address": "臺北市中正區汀州路三段91號1樓",
      "lng.": "121.5289",
      "lat.": "25.01752",
      "time": "11:00-15:00, 17:00-23:00",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ccc4e762756dd18d0b13213-Happy-fatty%E5%B9%B8%E7%A6%8F%E8%82%A5"
    },
    {
      "id": "191",
      "name": "MORLAN COFFEE",
      "address": "臺北市大安區溫州街48號",
      "lng.": "121.533",
      "lat.": "25.02151",
      "time": "暫時無資訊",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d21ffe02756dd4ea580e4b7-MORLAN-COFFEE"
    },
    {
      "id": "192",
      "name": "璐巴咖啡店 Maroubra Cafe",
      "address": "臺北市大安區羅斯福路三段283巷21弄2號",
      "lng.": "121.5316",
      "lat.": "25.01964",
      "time": "11:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59b9748a2756dd5b8c4cdee4-%E7%92%90%E5%B7%B4%E5%92%96%E5%95%A1%E5%BA%97-Maroubra-Cafe"
    },
    {
      "id": "193",
      "name": "牛洞食堂",
      "address": "臺北市大安區羅斯福路三段277號羅斯福大廈",
      "lng.": "121.5311",
      "lat.": "25.01816",
      "time": "11:30-16:00, 17:00-21:00",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dc055c03a103ee86ca500-%E7%89%9B%E6%B4%9E%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "194",
      "name": "山田珈琲店",
      "address": "臺北市大安區羅斯福路三段283巷21弄3號1樓",
      "lng.": "121.5315",
      "lat.": "25.01989",
      "time": "11:30-20:00",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/572645682756dd6742e65cd0-%E5%B1%B1%E7%94%B0%E7%8F%88%E7%90%B2%E5%BA%97"
    },
    {
      "id": "195",
      "name": "Aura微光咖啡",
      "address": "臺北市大安區羅斯福路三段269巷9號",
      "lng.": "121.5306",
      "lat.": "25.01947",
      "time": "12:30-22:00",
      "cuisine_type": "咖啡",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d1a05c03a103ee86c3e91-Aura%E5%BE%AE%E5%85%89%E5%92%96%E5%95%A1"
    },
    {
      "id": "196",
      "name": "89 LOOP Sports Bar",
      "address": "臺北市中正區羅斯福路四段134號2樓號",
      "lng.": "121.5358",
      "lat.": "25.01295",
      "time": "00:00-04:00, 19:00-00:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ba5011223679c43c1c1bb74-89-LOOP-Sports-Bar"
    },
    {
      "id": "197",
      "name": "45酒吧",
      "address": "臺北市大安區羅斯福路四段110號2F",
      "lng.": "121.5355",
      "lat.": "25.01336",
      "time": "00:00-02:00, 11:00-00:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dc6a5c03a103ee86ca91c-45%E9%85%92%E5%90%A7"
    },
    {
      "id": "198",
      "name": "安好食",
      "address": "臺北市大安區新生南路三段86巷9號",
      "lng.": "121.5326",
      "lat.": "25.01877",
      "time": "07:00-14:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a29830e2756dd43b842c82d-%E5%AE%89%E5%A5%BD%E9%A3%9F"
    },
    {
      "id": "199",
      "name": "鳳城燒臘百合店",
      "address": "臺北市大安區羅斯福路三段283巷6號",
      "lng.": "121.5317",
      "lat.": "25.01819",
      "time": "11:00-14:30, 16:30-20:30",
      "cuisine_type": "港式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55c8f5e12756dd6313d5dd88-%E9%B3%B3%E5%9F%8E%E7%87%92%E8%87%98%E7%99%BE%E5%90%88%E5%BA%97"
    },
    {
      "id": "200",
      "name": "魚雷起司三明治&薯條",
      "address": "臺北市中正區羅斯福路三段286巷",
      "lng.": "121.5323",
      "lat.": "25.01611",
      "time": "10:00-22:00",
      "cuisine_type": "美式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ce4fecff524683479ee16d5-%E9%AD%9A%E9%9B%B7%E8%B5%B7%E5%8F%B8%E4%B8%89%E6%98%8E%E6%B2%BB%26%E8%96%AF%E6%A2%9D"
    },
    {
      "id": "201",
      "name": "佳興魚丸",
      "address": "臺北市中正區汀州路三段243號",
      "lng.": "121.5342",
      "lat.": "25.01387",
      "time": "11:00-23:00",
      "cuisine_type": "台式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559daf54c03a103ee86c9b36-%E4%BD%B3%E8%88%88%E9%AD%9A%E4%B8%B8"
    },
    {
      "id": "202",
      "name": "水源福利會館",
      "address": "臺北市中正區思源街16號2樓",
      "lng.": "121.5301",
      "lat.": "25.01397",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57054f4c2756dd73cc1473a3-%E6%B0%B4%E6%BA%90%E7%A6%8F%E5%88%A9%E6%9C%83%E9%A4%A8"
    },
    {
      "id": "203",
      "name": "怪舒芙Monster Souffle",
      "address": "臺北市中正區羅斯福路四段136巷3號",
      "lng.": "121.5355",
      "lat.": "25.01272",
      "time": "16:00-00:00",
      "cuisine_type": "法式",
      "rating": "4.5",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5cac00d222613916c2981fac-%E6%80%AA%E8%88%92%E8%8A%99Monster-Souffle"
    },
    {
      "id": "204",
      "name": "Mr.拉麵公館店",
      "address": "臺北市中正區羅斯福路三段284巷11號",
      "lng.": "121.5317",
      "lat.": "25.0161",
      "time": "11:30-21:00",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d10f5c03a103ee86c399a-Mr.%E6%8B%89%E9%BA%B5%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "205",
      "name": "小日子商號",
      "address": "臺北市中正區羅斯福路四段52巷16弄13號",
      "lng.": "121.5338",
      "lat.": "25.01432",
      "time": "12:00-21:00",
      "cuisine_type": "飲料",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57d26dd1699b6e34872fec6d-%E5%B0%8F%E6%97%A5%E5%AD%90%E5%95%86%E8%99%9F"
    },
    {
      "id": "206",
      "name": "欒樹下書房/咖啡",
      "address": "臺北市大安區溫州街24號",
      "lng.": "121.5332",
      "lat.": "25.02321",
      "time": "10:30-22:00",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59ef813f2756dd291ac661a8-%E6%AC%92%E6%A8%B9%E4%B8%8B%E6%9B%B8%E6%88%BF%2F%E5%92%96%E5%95%A1"
    },
    {
      "id": "207",
      "name": "首爾之家",
      "address": "臺北市中正區羅斯福路三段244巷10弄14號",
      "lng.": "121.5314",
      "lat.": "25.01601",
      "time": "11:00-14:30, 17:00-21:30",
      "cuisine_type": "韓式",
      "rating": "3.9",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/562926fd2756dd74707fbed7-%E9%A6%96%E7%88%BE%E4%B9%8B%E5%AE%B6"
    },
    {
      "id": "208",
      "name": "鷹流拉麵極匠",
      "address": "臺北市中正區汀州路三段104巷4號",
      "lng.": "121.5331",
      "lat.": "25.01412",
      "time": "11:30-14:00, 17:00-22:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55b927ab40b5e303a1d5634f-%E9%B7%B9%E6%B5%81%E6%8B%89%E9%BA%B5%E6%A5%B5%E5%8C%A0"
    },
    {
      "id": "209",
      "name": "小林阿盛壽司",
      "address": "臺北市大安區羅斯福路三段333巷2之1號",
      "lng.": "121.5325",
      "lat.": "25.01716",
      "time": "11:00-20:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c71394f2261392b747e4ffc-%E5%B0%8F%E6%9E%97%E9%98%BF%E7%9B%9B%E5%A3%BD%E5%8F%B8"
    },
    {
      "id": "210",
      "name": "大盛豬排專門店",
      "address": "臺北市中正區羅斯福路四段52巷16弄15之1號",
      "lng.": "121.5338",
      "lat.": "25.01431",
      "time": "11:30-14:00, 17:00-20:15",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559db026c03a103ee86c9ba2-%E5%A4%A7%E7%9B%9B%E8%B1%AC%E6%8E%92%E5%B0%88%E9%96%80%E5%BA%97"
    },
    {
      "id": "211",
      "name": "韓天閣",
      "address": "臺北市中正區羅斯福路四段78巷1弄15號1樓",
      "lng.": "121.534",
      "lat.": "25.01427",
      "time": "11:30-14:30, 17:00-21:30",
      "cuisine_type": "韓式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5e717c03a102ec141562f-%E9%9F%93%E5%A4%A9%E9%96%A3"
    },
    {
      "id": "212",
      "name": "波囍",
      "address": "臺北市中正區羅斯福路三段316巷2號",
      "lng.": "121.5327",
      "lat.": "25.01588",
      "time": "11:00-22:30",
      "cuisine_type": "飲料",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b2126a122613903549525ea-%E6%B3%A2%E5%9B%8D"
    },
    {
      "id": "213",
      "name": "彩椒廚房",
      "address": "臺北市大安區溫州街74巷5弄1號",
      "lng.": "121.532",
      "lat.": "25.0197",
      "time": "11:00-13:45, 17:00-20:20",
      "cuisine_type": "韓式|義式|東南亞|泰式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5e0ecc03a102ec141543c-%E5%BD%A9%E6%A4%92%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "214",
      "name": "半路咖啡",
      "address": "臺北市大安區羅斯福路三段269巷51弄9號",
      "lng.": "121.5316",
      "lat.": "25.02014",
      "time": "14:00-00:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/568179012756dd3feba2028f-%E5%8D%8A%E8%B7%AF%E5%92%96%E5%95%A1"
    },
    {
      "id": "215",
      "name": "維綸麵食館",
      "address": "臺北市中正區汀州路三段279號",
      "lng.": "121.5355",
      "lat.": "25.01242",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d3e32c03a103ee86c563e-%E7%B6%AD%E7%B6%B8%E9%BA%B5%E9%A3%9F%E9%A4%A8"
    },
    {
      "id": "216",
      "name": "鮮肉水餃",
      "address": "臺北市中正區羅斯福路三段286巷18號",
      "lng.": "121.5324",
      "lat.": "25.01586",
      "time": "17:30-00:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c36b7f82261392aa0c8e381-%E9%AE%AE%E8%82%89%E6%B0%B4%E9%A4%83"
    },
    {
      "id": "217",
      "name": "淬煉廚房 Cui Lian Kitchen",
      "address": "臺北市中正區羅斯福路四段12巷3號",
      "lng.": "121.5328",
      "lat.": "25.01565",
      "time": "11:30-14:00, 16:30-21:00",
      "cuisine_type": "義式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58c43c642756dd0d9a3671f4-%E6%B7%AC%E7%85%89%E5%BB%9A%E6%88%BF-Cui-Lian-Kitche"
    },
    {
      "id": "218",
      "name": "四口木鮮果飲 師大總店",
      "address": "臺北市大安區羅斯福路三段183號",
      "lng.": "121.528",
      "lat.": "25.0213",
      "time": "10:50-22:00",
      "cuisine_type": "飲料",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5bce64e423679c5c112574f2-%E5%9B%9B%E5%8F%A3%E6%9C%A8%E9%AE%AE%E6%9E%9C%E9%A3%B2-%E5%B8%AB%E5%A4%A7%E7%B8%BD%E5%BA%97"
    },
    {
      "id": "219",
      "name": "自由51",
      "address": "臺北市文山區羅斯福路五段150巷59號",
      "lng.": "121.5378",
      "lat.": "25.00739",
      "time": "11:30-23:00",
      "cuisine_type": "咖啡",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bf7ac56f524687ff1d98239-%E8%87%AA%E7%94%B151"
    },
    {
      "id": "220",
      "name": "雞排本色 臺北公館店",
      "address": "臺北市中正區羅斯福路四段24巷12弄7號",
      "lng.": "121.5328",
      "lat.": "25.01494",
      "time": "15:30-22:30",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c78a286f5246805d9c2379d-%E9%9B%9E%E6%8E%92%E6%9C%AC%E8%89%B2-%E5%8F%B0%E5%8C%97%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "221",
      "name": "彼克蕾友善咖啡館",
      "address": "臺北市大安區新生南路三段76巷5號",
      "lng.": "121.5333",
      "lat.": "25.01911",
      "time": "11:30-21:30",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55db614f2756dd45c3a23ad8-%E5%BD%BC%E5%85%8B%E8%95%BE%E5%8F%8B%E5%96%84%E5%92%96%E5%95%A1%E9%A4%A8"
    },
    {
      "id": "222",
      "name": "公館清蒸肉圓",
      "address": "臺北市中正區汀州路三段150號",
      "lng.": "121.5341",
      "lat.": "25.01365",
      "time": "11:30-21:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d32d4c03a103ee86c4f22-%E5%85%AC%E9%A4%A8%E6%B8%85%E8%92%B8%E8%82%89%E5%9C%93"
    },
    {
      "id": "223",
      "name": "Barber's Select 紳室商號",
      "address": "臺北市中正區汀州路三段203號2樓",
      "lng.": "121.5334",
      "lat.": "25.01442",
      "time": "13:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5946c25c2756dd524dd08f73-Barber's-Select-%E7%B4%B3%E5%AE%A4%E5%95%86%E8%99%9F"
    },
    {
      "id": "224",
      "name": "劉家水煎包",
      "address": "臺北市中正區汀州路三段189號",
      "lng.": "121.5332",
      "lat.": "25.01456",
      "time": "05:30-22:30",
      "cuisine_type": "台式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559daf69c03a103ee86c9b3b-%E5%8A%89%E5%AE%B6%E6%B0%B4%E7%85%8E%E5%8C%85"
    },
    {
      "id": "225",
      "name": "雪球咖啡 (公館店)",
      "address": "臺北市中正區汀州路三段227號",
      "lng.": "121.5339",
      "lat.": "25.01404",
      "time": "06:30-15:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5bb6226b2756dd189f405797-%E9%9B%AA%E7%90%83%E5%92%96%E5%95%A1-(%E5%85%AC%E9%A4%A8%E5%BA%97)"
    },
    {
      "id": "226",
      "name": "可蕾仙朵女僕咖啡館",
      "address": "臺北市中正區辛亥路一段43巷6號",
      "lng.": "121.5284",
      "lat.": "25.01978",
      "time": "12:00-21:30",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b5f53802756dd2ba2cf1ec0-%E5%8F%AF%E8%95%BE%E4%BB%99%E6%9C%B5%E5%A5%B3%E5%83%95%E5%92%96%E5%95%A1%E9%A4%A8"
    },
    {
      "id": "227",
      "name": "找到咖啡",
      "address": "臺北市大安區羅斯福路四段1號",
      "lng.": "121.5379",
      "lat.": "25.01452",
      "time": "10:00-20:00",
      "cuisine_type": "咖啡",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dbd28c03a103ee86ca313-%E6%89%BE%E5%88%B0%E5%92%96%E5%95%A1"
    },
    {
      "id": "228",
      "name": "小當家健康鹹水雞",
      "address": "臺北市中正區羅斯福路三段316巷4號",
      "lng.": "121.5326",
      "lat.": "25.01582",
      "time": "17:30-23:00",
      "cuisine_type": "中式",
      "rating": "3.8",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/588250e02756dd3ab2f6b734-%E5%B0%8F%E7%95%B6%E5%AE%B6%E5%81%A5%E5%BA%B7%E9%B9%B9%E6%B0%B4%E9%9B%9E"
    },
    {
      "id": "229",
      "name": "HenryCary",
      "address": "臺北市大安區羅斯福路三段283巷36號",
      "lng.": "121.5318",
      "lat.": "25.01945",
      "time": "12:00-20:30",
      "cuisine_type": "美式",
      "rating": "4.5",
      "inout": ['外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/559dd1a0c03a103ee86caf42-HenryCary"
    },
    {
      "id": "230",
      "name": "雲南小鎮餐坊",
      "address": "臺北市中正區羅斯福路四段90巷2之2號",
      "lng.": "121.5347",
      "lat.": "25.01384",
      "time": "11:00-22:00",
      "cuisine_type": "中式|泰式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a683f4c03a104df53ca7fd-%E9%9B%B2%E5%8D%97%E5%B0%8F%E9%8E%AE%E9%A4%90%E5%9D%8A"
    },
    {
      "id": "231",
      "name": "Pasta 2 Go",
      "address": "臺北市大安區新生南路三段72號",
      "lng.": "121.5336",
      "lat.": "25.01947",
      "time": "17:00-20:00",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b1508d323679c1aaadc2977-Pasta-2-Go"
    },
    {
      "id": "232",
      "name": "Staff Only Club",
      "address": "臺北市中正區水源路1之10號",
      "lng.": "121.5273",
      "lat.": "25.01358",
      "time": "00:00-01:00, 19:00-00:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b57583823679c2c31354538-Staff-Only-Club"
    },
    {
      "id": "233",
      "name": "ville cafe",
      "address": "臺北市中正區羅斯福路三段284巷5號",
      "lng.": "121.5318",
      "lat.": "25.01621",
      "time": "11:30-21:30",
      "cuisine_type": "咖啡|義式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d7b89c03a103ee86c7e7e-ville-cafe"
    },
    {
      "id": "234",
      "name": "靈感咖啡",
      "address": "臺北市大安區新生南路三段84之6號2F",
      "lng.": "121.5335",
      "lat.": "25.0189",
      "time": "10:30-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58aa788023679c12f544e6fb-%E9%9D%88%E6%84%9F%E5%92%96%E5%95%A1"
    },
    {
      "id": "235",
      "name": "巫雲",
      "address": "臺北市中正區羅斯福路三段244巷9弄7號",
      "lng.": "121.5301",
      "lat.": "25.01751",
      "time": "17:00-22:00",
      "cuisine_type": "中式",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b36754c2756dd72db96c35e-%E5%B7%AB%E9%9B%B2"
    },
    {
      "id": "236",
      "name": "尚家香雲南美味麵食館",
      "address": "臺北市中正區汀州路三段137號",
      "lng.": "121.5309",
      "lat.": "25.01612",
      "time": "11:30-14:30, 16:30-20:30",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dd0ecc03a103ee86caed2-%E5%B0%9A%E5%AE%B6%E9%A6%99%E9%9B%B2%E5%8D%97%E7%BE%8E%E5%91%B3%E9%BA%B5%E9%A3%9F%E9%A4%A8"
    },
    {
      "id": "237",
      "name": "蘇活義大利麵坊",
      "address": "臺北市大安區新生南路三段60巷3號",
      "lng.": "121.5335",
      "lat.": "25.02012",
      "time": "11:30-14:30, 17:00-21:30",
      "cuisine_type": "義式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5afd1a1c2261391cb279bc27-%E8%98%87%E6%B4%BB%E7%BE%A9%E5%A4%A7%E5%88%A9%E9%BA%B5%E5%9D%8A"
    },
    {
      "id": "238",
      "name": "越南清化河粉",
      "address": "臺北市大安區溫州街74巷8號",
      "lng.": "121.5321",
      "lat.": "25.01984",
      "time": "11:30-15:00, 17:00-20:30",
      "cuisine_type": "東南亞",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ae366992756dd3a035aa635-%E8%B6%8A%E5%8D%97%E6%B8%85%E5%8C%96%E6%B2%B3%E7%B2%89"
    },
    {
      "id": "239",
      "name": "有意思居酒食堂",
      "address": "臺北市大安區新生南路三段86巷17號",
      "lng.": "121.5323",
      "lat.": "25.01875",
      "time": "12:00-14:30, 17:30-23:30",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5ae89358f524684adddf0ed6-%E6%9C%89%E6%84%8F%E6%80%9D%E5%B1%85%E9%85%92%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "240",
      "name": "女巫店",
      "address": "臺北市大安區新生南路三段56巷7號",
      "lng.": "121.5337",
      "lat.": "25.0205",
      "time": "10:00-00:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5becdefff524682451ecc7d7-%E5%A5%B3%E5%B7%AB%E5%BA%97"
    },
    {
      "id": "241",
      "name": "開心農場素食店",
      "address": "臺北市大安區羅斯福路三段283巷16號",
      "lng.": "121.5317",
      "lat.": "25.01851",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55b9539840b5e303a1d56bbd-%E9%96%8B%E5%BF%83%E8%BE%B2%E5%A0%B4%E7%B4%A0%E9%A3%9F%E5%BA%97"
    },
    {
      "id": "242",
      "name": "小川西堂台大店",
      "address": "臺北市大安區羅斯福路三段283巷38號",
      "lng.": "121.5318",
      "lat.": "25.01964",
      "time": "11:00-15:00, 17:00-21:00",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5912044d2756dd5b951ae104-%E5%B0%8F%E5%B7%9D%E8%A5%BF%E5%A0%82%E5%8F%B0%E5%A4%A7%E5%BA%97"
    },
    {
      "id": "243",
      "name": "四平手工饅頭",
      "address": "臺北市大安區羅斯福路三段341號",
      "lng.": "121.5326",
      "lat.": "25.01691",
      "time": "11:00-21:30",
      "cuisine_type": "中式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b398d7423679c5a97993e5f-%E5%9B%9B%E5%B9%B3%E6%89%8B%E5%B7%A5%E9%A5%85%E9%A0%AD"
    },
    {
      "id": "244",
      "name": "SABABA PITA BAR中東食堂",
      "address": "臺北市大安區羅斯福路三段283巷17號",
      "lng.": "121.5315",
      "lat.": "25.01922",
      "time": "12:00-14:30, 17:00-21:00",
      "cuisine_type": "中東式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559de3cbc03a103ee86cbb95-SABABA-PITA-BAR%E4%B8%AD%E6%9D%B1%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "245",
      "name": "感恩小館",
      "address": "臺北市大安區新生南路三段56巷6號",
      "lng.": "121.5335",
      "lat.": "25.02039",
      "time": "12:00-21:30",
      "cuisine_type": "咖啡|義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559db2e7c03a103ee86c9cf3-%E6%84%9F%E6%81%A9%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "246",
      "name": "幸福村潤餅",
      "address": "臺北市大安區羅斯福路三段316巷內",
      "lng.": "121.5326",
      "lat.": "25.01574",
      "time": "11:15-20:00",
      "cuisine_type": "中式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/570dc45e699b6e7dd468063c-%E5%B9%B8%E7%A6%8F%E6%9D%91%E6%BD%A4%E9%A4%85"
    },
    {
      "id": "247",
      "name": "尖蚪",
      "address": "臺北市中正區汀州路三段230巷57號",
      "lng.": "121.5319",
      "lat.": "25.01047",
      "time": "13:00-20:00",
      "cuisine_type": "日式|咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d1177c03a103ee86c39d1-%E5%B0%96%E8%9A%AA"
    },
    {
      "id": "248",
      "name": "至香園小吃店",
      "address": "臺北市大安區新生南路三段86巷15號",
      "lng.": "121.5324",
      "lat.": "25.01874",
      "time": "11:30-14:00, 17:30-20:30",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a43e1112756dd2df4355504-%E8%87%B3%E9%A6%99%E5%9C%92%E5%B0%8F%E5%90%83%E5%BA%97"
    },
    {
      "id": "249",
      "name": "山西刀削麵",
      "address": "臺北市中正區羅斯福路四段24巷12弄10之1號",
      "lng.": "121.533",
      "lat.": "25.01477",
      "time": "11:00-22:00",
      "cuisine_type": "中式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d3c04c03a103ee86c549f-%E5%B1%B1%E8%A5%BF%E5%88%80%E5%89%8A%E9%BA%B5"
    },
    {
      "id": "250",
      "name": "公館酒釀湯圓",
      "address": "臺北市中正區羅斯福路四段14號",
      "lng.": "121.533",
      "lat.": "25.01574",
      "time": "14:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55e746242756dd0ea6293c42-%E5%85%AC%E9%A4%A8%E9%85%92%E9%87%80%E6%B9%AF%E5%9C%93"
    },
    {
      "id": "251",
      "name": "中央公園咖啡館",
      "address": "臺北市中正區羅斯福路三段240巷3號",
      "lng.": "121.5303",
      "lat.": "25.01808",
      "time": "11:00-21:30",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/562001122756dd74707fbc5a-%E4%B8%AD%E5%A4%AE%E5%85%AC%E5%9C%92%E5%92%96%E5%95%A1%E9%A4%A8"
    },
    {
      "id": "252",
      "name": "大水元",
      "address": "臺北市中正區羅斯福路四段92號1樓25號",
      "lng.": "121.535",
      "lat.": "25.01365",
      "time": "10:30-19:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a60e1f42756dd60a421a1ec-%E5%A4%A7%E6%B0%B4%E5%85%83"
    },
    {
      "id": "253",
      "name": "薄霧書店",
      "address": "臺北市中正區羅斯福路三段302號3樓",
      "lng.": "121.5324",
      "lat.": "25.01628",
      "time": "12:00-19:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59f224db2756dd2919c685b9-%E8%96%84%E9%9C%A7%E6%9B%B8%E5%BA%97"
    },
    {
      "id": "254",
      "name": "路上撿到一隻貓",
      "address": "臺北市大安區溫州街49巷2號",
      "lng.": "121.5331",
      "lat.": "25.02138",
      "time": "00:00-01:30, 13:00-00:00",
      "cuisine_type": "咖啡",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4a909c03a1002ad8ad4fd-%E8%B7%AF%E4%B8%8A%E6%92%BF%E5%88%B0%E4%B8%80%E9%9A%BB%E8%B2%93"
    },
    {
      "id": "255",
      "name": "胖老爹美式炸雞-師大店",
      "address": "臺北市中正區辛亥路一段21號",
      "lng.": "121.5282",
      "lat.": "25.01926",
      "time": "15:00-23:00",
      "cuisine_type": "美式",
      "rating": "3.4",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59b039a62756dd711d7e8164-%E8%83%96%E8%80%81%E7%88%B9%E7%BE%8E%E5%BC%8F%E7%82%B8%E9%9B%9E-%E5%B8%AB%E5%A4%A7%E5%BA%97"
    },
    {
      "id": "256",
      "name": "I.C. Airport 冰淇淋機場",
      "address": "臺北市大安區溫州街74巷8號",
      "lng.": "121.5321",
      "lat.": "25.01984",
      "time": "11:00-20:00",
      "cuisine_type": "飲料",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d217ec03a103ee86c42e7-I.C.-Airport-%E5%86%B0%E6%B7%87%E6%B7%8B%E6%A9%9F%E5%A0%B4"
    },
    {
      "id": "257",
      "name": "晴光紅豆餅 (公館店)",
      "address": "臺北市中正區汀洲路三段255號",
      "lng.": "121.5351",
      "lat.": "25.01299",
      "time": "12:00-22:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56c4b5d92756dd75130ce405-%E6%99%B4%E5%85%89%E7%B4%85%E8%B1%86%E9%A4%85-(%E5%85%AC%E9%A4%A8%E5%BA%97)"
    },
    {
      "id": "258",
      "name": "曠野壓霸三明治",
      "address": "臺北市中正區羅斯福路四段136巷1之3號",
      "lng.": "121.5356",
      "lat.": "25.01284",
      "time": "16:30-23:30",
      "cuisine_type": "美式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59720cd222613933ff90ce27-%E6%9B%A0%E9%87%8E%E5%A3%93%E9%9C%B8%E4%B8%89%E6%98%8E%E6%B2%BB"
    },
    {
      "id": "259",
      "name": "淘客美式漢堡",
      "address": "臺北市中正區羅斯福路四段124號",
      "lng.": "121.5357",
      "lat.": "25.01311",
      "time": "11:00-23:00",
      "cuisine_type": "美式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5655cdb42756dd1d7a1afd56-%E6%B7%98%E5%AE%A2%E7%BE%8E%E5%BC%8F%E6%BC%A2%E5%A0%A1"
    },
    {
      "id": "260",
      "name": "興隆手工涼麵",
      "address": "臺北市大安區羅斯福路三段333巷2之1號",
      "lng.": "121.5325",
      "lat.": "25.01716",
      "time": "11:00-22:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5929bfb42756dd5efc9048fd-%E8%88%88%E9%9A%86%E6%89%8B%E5%B7%A5%E6%B6%BC%E9%BA%B5"
    },
    {
      "id": "261",
      "name": "墾丁蛋蛋ㄉㄨㄞ奶",
      "address": "臺北市中正區汀州路三段165號",
      "lng.": "121.5323",
      "lat.": "25.01529",
      "time": "11:30-23:30",
      "cuisine_type": "飲料",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d4063c03a103ee86c57b3-%E5%A2%BE%E4%B8%81%E8%9B%8B%E8%9B%8B%E3%84%89%E3%84%A8%E3%84%9E%E5%A5%B6"
    },
    {
      "id": "262",
      "name": "Kitchen66",
      "address": "臺北市大安區溫州街74巷3弄11號",
      "lng.": "121.5321",
      "lat.": "25.01895",
      "time": "11:30-21:00",
      "cuisine_type": "美式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d1688c03a103ee86c3c67-Kitchen66"
    },
    {
      "id": "263",
      "name": "23 Public Craft Beer 精釀啤酒",
      "address": "臺北市大安區辛亥路一段100號",
      "lng.": "121.5318",
      "lat.": "25.02148",
      "time": "15:30-23:45",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5906a6fe23679c0f2cf7e8bf-23-Public-Craft-Beer"
    },
    {
      "id": "264",
      "name": "聞山咖啡 臺大店",
      "address": "臺北市大安區新生南路三段56巷11之1號",
      "lng.": "121.5335",
      "lat.": "25.02064",
      "time": "13:00-22:00",
      "cuisine_type": "咖啡",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a49d7ac03a1002ad8ad269-%E8%81%9E%E5%B1%B1%E5%92%96%E5%95%A1-%E8%87%BA%E5%A4%A7%E5%BA%97"
    },
    {
      "id": "265",
      "name": "泰風味小吃店",
      "address": "臺北市中正區羅斯福路四段108巷2號",
      "lng.": "121.5353",
      "lat.": "25.01329",
      "time": "11:30-21:30",
      "cuisine_type": "泰式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5b92fc03a10241de67dc0-%E6%B3%B0%E9%A2%A8%E5%91%B3%E5%B0%8F%E5%90%83%E5%BA%97"
    },
    {
      "id": "266",
      "name": "季丼屋 日本丼飯",
      "address": "臺北市中正區臺北市羅斯福路四段150號",
      "lng.": "121.536",
      "lat.": "25.01263",
      "time": "11:30-20:45",
      "cuisine_type": "日式",
      "rating": "3.4",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57d057472756dd05d485aa91-%E5%AD%A3%E4%B8%BC%E5%B1%8B-%E6%97%A5%E6%9C%AC%E4%B8%BC%E9%A3%AF"
    },
    {
      "id": "267",
      "name": "左巴好室．好事",
      "address": "臺北市大安區溫州街74巷1弄2號",
      "lng.": "121.5327",
      "lat.": "25.01958",
      "time": "11:00-22:00",
      "cuisine_type": "義式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56c759a32756dd0a2f62dd83-%E5%B7%A6%E5%B7%B4%E5%A5%BD%E5%AE%A4%EF%BC%8E%E5%A5%BD%E4%BA%8B"
    },
    {
      "id": "268",
      "name": "BrassJoy cafe 銅樂咖啡",
      "address": "臺北市大安區新生南路三段96之1號",
      "lng.": "121.5331",
      "lat.": "25.01717",
      "time": "11:00-22:00",
      "cuisine_type": "咖啡",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58ca5c5a699b6e3f1225e10c-BrassJoy-cafe-%E9%8A%85%E6%A8%82%E5%92%96%E5%95%A1"
    },
    {
      "id": "269",
      "name": "小旺號鐵板捲餅",
      "address": "臺北市中正區汀州路三段259號",
      "lng.": "121.5352",
      "lat.": "25.0129",
      "time": "07:00-21:00",
      "cuisine_type": "美式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57eea9672756dd0d0ff56316-%E5%B0%8F%E6%97%BA%E8%99%9F%E9%90%B5%E6%9D%BF%E6%8D%B2%E9%A4%85"
    },
    {
      "id": "270",
      "name": "L.A.F BURGER 拉芙漢堡",
      "address": "臺北市中正區汀州路三段293號",
      "lng.": "121.5357",
      "lat.": "25.01203",
      "time": "11:30-14:30, 17:30-21:30",
      "cuisine_type": "美式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d6134c03a103ee86c6bfa-L.A.F-BURGER-%E6%8B%89%E8%8A%99%E6%BC%A2%E5%A0%A1"
    },
    {
      "id": "271",
      "name": "片場咖啡",
      "address": "臺北市大安區新生南路三段70巷6號",
      "lng.": "121.5332",
      "lat.": "25.01983",
      "time": "12:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a49ffcc03a1002ad8ad2ea-%E7%89%87%E5%A0%B4%E5%92%96%E5%95%A1"
    },
    {
      "id": "272",
      "name": "葛樂蒂咖啡館",
      "address": "臺北市大安區辛亥路一段136號",
      "lng.": "121.5338",
      "lat.": "25.02201",
      "time": "11:30-21:30",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5ec0cc03a102ec14157c9-%E8%91%9B%E6%A8%82%E8%92%82%E5%92%96%E5%95%A1%E9%A4%A8"
    },
    {
      "id": "273",
      "name": "費斯達香草洋食館",
      "address": "臺北市中正區羅斯福路三段316巷8弄14號",
      "lng.": "121.5326",
      "lat.": "25.01532",
      "time": "12:00-14:30, 17:00-21:30",
      "cuisine_type": "義式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d6990c03a103ee86c7263-%E8%B2%BB%E6%96%AF%E9%81%94%E9%A6%99%E8%8D%89%E6%B4%8B%E9%A3%9F%E9%A4%A8"
    },
    {
      "id": "274",
      "name": "麥子磨麵",
      "address": "臺北市大安區羅斯福路三段283巷22號",
      "lng.": "121.5317",
      "lat.": "25.01869",
      "time": "11:30-14:30, 17:00-20:30",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/581970a823679c30a8bd3aed-%E9%BA%A5%E5%AD%90%E7%A3%A8%E9%BA%B5"
    },
    {
      "id": "275",
      "name": "咖哩先生",
      "address": "臺北市大安區新生南路三段70巷6號",
      "lng.": "121.5332",
      "lat.": "25.01983",
      "time": "12:00-21:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d4394c03a103ee86c59bb-%E5%92%96%E5%93%A9%E5%85%88%E7%94%9F"
    },
    {
      "id": "276",
      "name": "挑豆院",
      "address": "臺北市大安區羅斯福路三段269巷2-1號",
      "lng.": "121.5307",
      "lat.": "25.01903",
      "time": "10:00-20:00",
      "cuisine_type": "飲料",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57dd86d92756dd7fa168514d-%E6%8C%91%E8%B1%86%E9%99%A2"
    },
    {
      "id": "277",
      "name": "金牛座牛排館",
      "address": "臺北市中正區羅斯福路三段316巷8弄8號",
      "lng.": "121.5325",
      "lat.": "25.0155",
      "time": "11:30-14:00, 16:30-21:45",
      "cuisine_type": "美式",
      "rating": "3.8",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d52b1c03a103ee86c6346-%E9%87%91%E7%89%9B%E5%BA%A7%E7%89%9B%E6%8E%92%E9%A4%A8"
    },
    {
      "id": "278",
      "name": "巴伯Q奶",
      "address": "臺北市中正區羅斯福路三段316巷4號",
      "lng.": "121.5326",
      "lat.": "25.01582",
      "time": "12:00-23:00",
      "cuisine_type": "飲料",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/595f064ff524681fdeed7bd2-%E5%B7%B4%E4%BC%AFQ%E5%A5%B6"
    },
    {
      "id": "279",
      "name": "OD Cafe Okey Dokey",
      "address": "臺北市大安區溫州街58巷2號",
      "lng.": "121.5329",
      "lat.": "25.02063",
      "time": "12:00-22:00",
      "cuisine_type": "咖啡",
      "rating": "3.8",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a50206c03a10241de64036-OD-Cafe-Okey-Dokey"
    },
    {
      "id": "280",
      "name": "饅頭專賣店",
      "address": "臺北市中正區羅斯福路四段24巷10號",
      "lng.": "121.5329",
      "lat.": "25.01505",
      "time": "12:30-22:30",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57828e1e2756dd6261d81923-%E9%A5%85%E9%A0%AD%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "281",
      "name": "得記蛋糕",
      "address": "臺北市中正區羅斯福路四段26號",
      "lng.": "121.5333",
      "lat.": "25.01545",
      "time": "08:00-21:30",
      "cuisine_type": "中式|美式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/577d49692756dd522c5771ad-%E5%BE%97%E8%A8%98%E8%9B%8B%E7%B3%95"
    },
    {
      "id": "282",
      "name": "漁人食舖",
      "address": "臺北市大安區羅斯福路三段283巷36號",
      "lng.": "121.5318",
      "lat.": "25.01945",
      "time": "17:00-22:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a539e5c03a10241de65385-%E6%BC%81%E4%BA%BA%E9%A3%9F%E8%88%96"
    },
    {
      "id": "283",
      "name": "曼德樂泰式料理",
      "address": "臺北市中正區汀州路三段239號",
      "lng.": "121.5341",
      "lat.": "25.01392",
      "time": "11:30-21:30",
      "cuisine_type": "泰式|韓式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/571e5c012756dd504810441f-%E6%9B%BC%E5%BE%B7%E6%A8%82%E6%B3%B0%E5%BC%8F%E6%96%99%E7%90%86"
    },
    {
      "id": "284",
      "name": "大聲公牛肉麵店",
      "address": "臺北市大安區新生南路三段54之6號",
      "lng.": "121.5339",
      "lat.": "25.02072",
      "time": "11:30-15:00, 17:00-21:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a55e75c03a10241de6603c-%E5%A4%A7%E8%81%B2%E5%85%AC%E7%89%9B%E8%82%89%E9%BA%B5%E5%BA%97"
    },
    {
      "id": "285",
      "name": "圖貝塔極品咖啡",
      "address": "臺北市大安區泰順街60巷10號1f",
      "lng.": "121.5304",
      "lat.": "25.02227",
      "time": "11:00-18:00",
      "cuisine_type": "咖啡",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a67098c03a104df53ca2a2-%E5%9C%96%E8%B2%9D%E5%A1%94%E6%A5%B5%E5%93%81%E5%92%96%E5%95%A1"
    },
    {
      "id": "286",
      "name": "自來水園區",
      "address": "臺北市中正區思源街1號",
      "lng.": "121.53",
      "lat.": "25.01254",
      "time": "09:00-18:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56e45b202756dd0f36c4bf2d-%E8%87%AA%E4%BE%86%E6%B0%B4%E5%9C%92%E5%8D%80"
    },
    {
      "id": "287",
      "name": "麻油雞",
      "address": "臺北市大安區公館夜市商圈",
      "lng.": "121.5347",
      "lat.": "25.01368",
      "time": "16:30-23:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5894b72d23679c5e6c9ab1a2-%E9%BA%BB%E6%B2%B9%E9%9B%9E"
    },
    {
      "id": "288",
      "name": "水源市場甘蔗汁",
      "address": "臺北市文山區羅斯福路四段九十二號",
      "lng.": "121.5349",
      "lat.": "25.0136",
      "time": "08:00-18:00",
      "cuisine_type": "飲料",
      "rating": "4.8",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559dd23bc03a103ee86caf83-%E6%B0%B4%E6%BA%90%E5%B8%82%E5%A0%B4%E7%94%98%E8%94%97%E6%B1%81"
    },
    {
      "id": "289",
      "name": "韓江館銅盤烤肉",
      "address": "臺北市中正區羅斯福路三段316巷9弄6號",
      "lng.": "121.5319",
      "lat.": "25.01573",
      "time": "11:30-15:00, 17:00-22:00",
      "cuisine_type": "韓式",
      "rating": "3.2",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5be77c03a10241de67f63-%E9%9F%93%E6%B1%9F%E9%A4%A8%E9%8A%85%E7%9B%A4%E7%83%A4%E8%82%89"
    },
    {
      "id": "290",
      "name": "海邊的卡夫卡 藝文空間",
      "address": "臺北市中正區羅斯福路三段244巷2號2樓",
      "lng.": "121.5313",
      "lat.": "25.01715",
      "time": "13:00-22:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a52da7c03a10241de64ef2-%E6%B5%B7%E9%82%8A%E7%9A%84%E5%8D%A1%E5%A4%AB%E5%8D%A1-%E8%97%9D%E6%96%87%E7%A9%BA%E9%96%93"
    },
    {
      "id": "291",
      "name": "龍哥無骨雞腿排",
      "address": "臺北市中正區羅斯褔路四段108巷10號",
      "lng.": "121.5351",
      "lat.": "25.01313",
      "time": "15:30-22:30",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d3f97c03a103ee86c5722-%E9%BE%8D%E5%93%A5%E7%84%A1%E9%AA%A8%E9%9B%9E%E8%85%BF%E6%8E%92"
    },
    {
      "id": "292",
      "name": "雲香亭",
      "address": "臺北市大安區新生南路三段100號2樓",
      "lng.": "121.5329",
      "lat.": "25.01687",
      "time": "11:30-15:00, 17:00-20:30",
      "cuisine_type": "泰式|東南亞",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/564389242756dd40eaa060e8-%E9%9B%B2%E9%A6%99%E4%BA%AD"
    },
    {
      "id": "293",
      "name": "甘丹鐵板燒",
      "address": "臺北市中正區汀州路3段208號",
      "lng.": "121.5355",
      "lat.": "25.0121",
      "time": "11:30-14:30, 17:00-22:30",
      "cuisine_type": "日式",
      "rating": "3.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5b953c03a10241de67dc9-%E7%94%98%E4%B8%B9%E9%90%B5%E6%9D%BF%E7%87%92"
    },
    {
      "id": "294",
      "name": "歐嬤徳式烘焙 公館旗艦店",
      "address": "臺北市大安區辛亥路一段46號",
      "lng.": "121.5303",
      "lat.": "25.02013",
      "time": "07:00-20:30",
      "cuisine_type": "美式",
      "rating": "4.5",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55d76a0c2756dd0b3b8dbb0f-%E6%AD%90%E5%AC%A4%E5%BE%B3%E5%BC%8F%E7%83%98%E7%84%99-%E5%85%AC%E9%A4%A8%E6%97%97%E8%89%A6%E5%BA%97"
    },
    {
      "id": "295",
      "name": "CoCo壹番屋",
      "address": "臺北市大安區羅斯福路四段1號",
      "lng.": "121.5379",
      "lat.": "25.01452",
      "time": "11:00-22:00",
      "cuisine_type": "日式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dbd2ac03a103ee86ca318-CoCo%E5%A3%B9%E7%95%AA%E5%B1%8B"
    },
    {
      "id": "296",
      "name": "南城泰式料理",
      "address": "臺北市中正區汀州路三段171號",
      "lng.": "121.5324",
      "lat.": "25.01512",
      "time": "11:30-14:30, 17:00-22:00",
      "cuisine_type": "泰式",
      "rating": "3.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d0528c03a103ee86c3439-%E5%8D%97%E5%9F%8E%E6%B3%B0%E5%BC%8F%E6%96%99%E7%90%86"
    },
    {
      "id": "297",
      "name": "竹の丼飯屋",
      "address": "臺北市中正區羅斯福路四段92號",
      "lng.": "121.535",
      "lat.": "25.01371",
      "time": "11:00-14:00, 17:00-19:30",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a492d7c03a1002ad8ad01f-%E7%AB%B9%E3%81%AE%E4%B8%BC%E9%A3%AF%E5%B1%8B"
    },
    {
      "id": "298",
      "name": "洛德城堡戲水樂園",
      "address": "臺北市中正區汀州路三段160巷",
      "lng.": "121.5342",
      "lat.": "25.01321",
      "time": "06:00-22:00",
      "cuisine_type": "咖啡|義式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d2eb9c03a103ee86c4c2e-%E6%B4%9B%E5%BE%B7%E5%9F%8E%E5%A0%A1%E6%88%B2%E6%B0%B4%E6%A8%82%E5%9C%92"
    },
    {
      "id": "299",
      "name": "chef's cafe waffle 瓦福",
      "address": "臺北市大安區羅斯福路四段12巷1號",
      "lng.": "121.5329",
      "lat.": "25.01573",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d822dc03a103ee86c81e1-chef's-cafe-waffle-%E7%93%A6"
    },
    {
      "id": "300",
      "name": "穀果義國蔬食",
      "address": "臺北市大安區羅斯福路四段85號",
      "lng.": "121.5368",
      "lat.": "25.01305",
      "time": "11:00-14:30, 17:00-21:00",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559ddfaec03a103ee86cb84c-%E7%A9%80%E6%9E%9C%E7%BE%A9%E5%9C%8B%E8%94%AC%E9%A3%9F"
    },
    {
      "id": "301",
      "name": "MÖVENPICK café 莫凡彼咖啡館",
      "address": "臺北市中正區羅斯福路四段85號1樓",
      "lng.": "121.5368",
      "lat.": "25.01305",
      "time": "11:00-21:30",
      "cuisine_type": "咖啡|義式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/565434f62756dd1f85c550ac-M%C3%96VENPICK-caf%C3%A9-%E8%8E%AB%E5%87%A1%E5%BD%BC%E5%92%96%E5%95%A1"
    },
    {
      "id": "302",
      "name": "印餐廳",
      "address": "臺北市中正區汀州路三段164號",
      "lng.": "121.5345",
      "lat.": "25.01338",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d029dc03a103ee86c3315-%E5%8D%B0%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "303",
      "name": "京阪豚骨拉麵",
      "address": "臺北市大安區羅斯福路四段136巷6弄6號",
      "lng.": "121.5357",
      "lat.": "25.01258",
      "time": "11:30-13:50, 17:00-20:25",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d7b6fc03a103ee86c7e69-%E4%BA%AC%E9%98%AA%E8%B1%9A%E9%AA%A8%E6%8B%89%E9%BA%B5"
    },
    {
      "id": "304",
      "name": "新卡莎素食西餐廳",
      "address": "臺北市大安區羅斯福路四段52巷1號",
      "lng.": "121.5334",
      "lat.": "25.01474",
      "time": "11:30-21:30",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d8087c03a103ee86c8112-%E6%96%B0%E5%8D%A1%E8%8E%8E%E7%B4%A0%E9%A3%9F%E8%A5%BF%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "305",
      "name": "瑪德蓮書店咖啡",
      "address": "臺北市中正區汀州路三段192號B1",
      "lng.": "121.5348",
      "lat.": "25.01274",
      "time": "12:00-22:00",
      "cuisine_type": "咖啡",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d6eccc03a103ee86c75e7-%E7%91%AA%E5%BE%B7%E8%93%AE%E6%9B%B8%E5%BA%97%E5%92%96%E5%95%A1"
    },
    {
      "id": "306",
      "name": "咪莉奶奶手工餅乾",
      "address": "臺北市中正區羅斯福路三段244巷10弄12號",
      "lng.": "121.5313",
      "lat.": "25.01607",
      "time": "14:00-22:30",
      "cuisine_type": "美式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559dbdefc03a103ee86ca39e-%E5%92%AA%E8%8E%89%E5%A5%B6%E5%A5%B6%E6%89%8B%E5%B7%A5%E9%A4%85%E4%B9%BE"
    },
    {
      "id": "307",
      "name": "臺北公館胡椒餅",
      "address": "臺北市中正區汀州路三段181號",
      "lng.": "121.5327",
      "lat.": "25.01487",
      "time": "12:00-20:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/595f066cf524681fdf877fdf-%E5%8F%B0%E5%8C%97%E5%85%AC%E9%A4%A8%E8%83%A1%E6%A4%92%E9%A4%85"
    },
    {
      "id": "308",
      "name": "阿里港",
      "address": "臺北市大安區羅斯福路三段285號",
      "lng.": "121.5315",
      "lat.": "25.01786",
      "time": "10:30-20:30",
      "cuisine_type": "台式",
      "rating": "3.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a51ddac03a10241de649b7-%E9%98%BF%E9%87%8C%E6%B8%AF"
    },
    {
      "id": "309",
      "name": "梅江韓國烤肉",
      "address": "臺北市中正區汀州路三段52號",
      "lng.": "121.5309",
      "lat.": "25.01581",
      "time": "11:00-14:00, 17:00-22:00",
      "cuisine_type": "韓式",
      "rating": "3.4",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d91e5c03a103ee86c8b06-%E6%A2%85%E6%B1%9F%E9%9F%93%E5%9C%8B%E7%83%A4%E8%82%89"
    },
    {
      "id": "310",
      "name": "小公館咖啡",
      "address": "臺北市中正區羅斯福路三段316巷8弄3號2樓",
      "lng.": "121.5327",
      "lat.": "25.01562",
      "time": "16:00-23:30",
      "cuisine_type": "咖啡|餐酒館/酒吧",
      "rating": "3.8",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d7bc1c03a103ee86c7e90-%E5%B0%8F%E5%85%AC%E9%A4%A8%E5%92%96%E5%95%A1"
    },
    {
      "id": "311",
      "name": "早安布拉格",
      "address": "臺北市中正區羅斯福路四段162號1樓",
      "lng.": "121.5362",
      "lat.": "25.01239",
      "cuisine_type": "義式|日式",
      "rating": "5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559db3a4c03a103ee86c9d41-%E6%97%A9%E5%AE%89%E5%B8%83%E6%8B%89%E6%A0%BC"
    },
    {
      "id": "312",
      "name": "蕭家乾麵",
      "address": "臺北市大安區羅斯福路四段90巷6號",
      "lng.": "121.5345",
      "lat.": "25.0136",
      "time": "00:00-00:30, 11:30-00:00",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a6844bc03a104df53ca813-%E8%95%AD%E5%AE%B6%E4%B9%BE%E9%BA%B5"
    },
    {
      "id": "313",
      "name": "易牙居餐廳",
      "address": "臺北市中正區羅斯福路三段286巷16號",
      "lng.": "121.5324",
      "lat.": "25.01595",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "港式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a67da2c03a104df53ca65b-%E6%98%93%E7%89%99%E5%B1%85%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "314",
      "name": "水管音樂",
      "address": "臺北市中正區思源街1號",
      "lng.": "121.53",
      "lat.": "25.01254",
      "time": "24小時營業",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5655ad572756dd1d7a1afad5-%E6%B0%B4%E7%AE%A1%E9%9F%B3%E6%A8%82"
    },
    {
      "id": "315",
      "name": "夢駝鈴CAFESHOP",
      "address": "臺北市中正區汀州路三段108號",
      "lng.": "121.5333",
      "lat.": "25.0143",
      "time": "00:00-02:00, 11:30-00:00",
      "cuisine_type": "咖啡",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/565610e22756dd1d7a1b02d6-%E5%A4%A2%E9%A7%9D%E9%88%B4CAFESHOP"
    },
    {
      "id": "316",
      "name": "重順川菜餐廳",
      "address": "臺北市中正區羅斯福路三段316巷8弄3之2號",
      "lng.": "121.5326",
      "lat.": "25.01564",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d0badc03a103ee86c3745-%E9%87%8D%E9%A0%86%E5%B7%9D%E8%8F%9C%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "317",
      "name": "馬辣頂級麻辣鴛鴦火鍋",
      "address": "臺北市中正區汀州路三段86號",
      "lng.": "121.5327",
      "lat.": "25.01463",
      "time": "00:00-04:00, 11:30-00:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a4f75ec03a10241de63c43-%E9%A6%AC%E8%BE%A3%E9%A0%82%E7%B4%9A%E9%BA%BB%E8%BE%A3%E9%B4%9B%E9%B4%A6%E7%81%AB%E9%8D%8B"
    },
    {
      "id": "318",
      "name": "梅江韓國烤肉",
      "address": "臺北市中正區思源街10號",
      "lng.": "121.5318",
      "lat.": "25.01492",
      "time": "11:00-15:00, 17:00-22:00",
      "cuisine_type": "韓式",
      "rating": "3.4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a50fe1c03a10241de644ef-%E6%A2%85%E6%B1%9F%E9%9F%93%E5%9C%8B%E7%83%A4%E8%82%89"
    },
    {
      "id": "319",
      "name": "可不可熟成紅茶-臺北公館店",
      "address": "臺北市中正區汀州路三段174號",
      "lng.": "121.5347",
      "lat.": "25.01321",
      "time": "10:30-23:00",
      "cuisine_type": "飲料",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d2c09182261392137999da4-%E5%8F%AF%E4%B8%8D%E5%8F%AF%E7%86%9F%E6%88%90%E7%B4%85%E8%8C%B6-%E5%8F%B0%E5%8C%97%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "320",
      "name": "Istanbul Turkish Food",
      "address": "臺北市中正區汀州路三段185號",
      "lng.": "121.5329",
      "lat.": "25.01476",
      "time": "12:00-21:00",
      "cuisine_type": "中東式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fda422a02935e29c9b42500-Istanbul-Turkish-Foo"
    },
    {
      "id": "321",
      "name": "龜記茗品-公館店",
      "address": "臺北市中正區羅斯福路四段24巷13號",
      "lng.": "121.5325",
      "lat.": "25.01507",
      "time": "11:00-22:00",
      "cuisine_type": "飲料",
      "rating": "4.5",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e5dc6c88c906d17e8c60454-%E9%BE%9C%E8%A8%98%E8%8C%97%E5%93%81-%E5%85%AC%E9%A4%A8%E5%BA%97"
    },
    {
      "id": "322",
      "name": "森火Pyro BBQ Bistro",
      "address": "臺北市中正區羅斯福路四段146號",
      "lng.": "121.536",
      "lat.": "25.01267",
      "time": "12:00-15:00, 17:30-21:00",
      "cuisine_type": "美式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f54db272261396f85829889-%E6%A3%AE%E7%81%ABPyro-BBQ-Bistro"
    },
    {
      "id": "323",
      "name": "凱林鐵板燒 信義威秀店",
      "address": "臺北市信義區松壽路16號",
      "lng.": "121.5670977",
      "lat.": "25.03562092",
      "time":
          "星期日10:00–22:00\n星期一10:00–22:00\n星期二10:00–22:00\n星期三10:00–22:00\n星期四10:00–22:00\n星期五10:00–22:00\n星期六10:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bcdebd123679c17b983d445-凱林鐵板燒-信義威秀店"
    },
    {
      "id": "324",
      "name": "廚桌餐廳",
      "address": "臺北市信義區忠孝東路五段10號10樓",
      "lng.": "121.5656117",
      "lat.": "25.0406477",
      "time":
          "星期日07:00–22:30\n星期一07:00–22:30\n星期二07:00–22:30\n星期三07:00–22:30\n星期四07:00–22:30\n星期五07:00–22:30\n星期六07:00–22:30",
      "cuisine_type": "美式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/559d6a5cc03a103ee86c72f3-The-Kitchen-Table-西餐"
    },
    {
      "id": "325",
      "name": "WOOBAR",
      "address": "臺北市信義區忠孝東路五段10號10樓",
      "lng.": "121.5656888",
      "lat.": "25.04060922",
      "time":
          "星期日10:30–00:00\n星期一10:30–00:00\n星期二10:30–00:00\n星期三10:30–00:00\n星期四10:30–00:00\n星期五10:30–01:00\n星期六10:30–01:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559d645bc03a103ee86c6e9e-WOOBAR"
    },
    {
      "id": "326",
      "name": "點點心台灣 微風信義店",
      "address": "臺北市信義區忠孝東路五段68號B1",
      "lng.": "121.5669108",
      "lat.": "25.04050485",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "港式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/563eb6082756dd4333a3154a-點點心"
    },
    {
      "id": "327",
      "name": "莫爾頓牛排館 Morton's The Steakhouse",
      "address": "臺北市信義區忠孝東路五段68號45樓",
      "lng.": "121.5669179",
      "lat.": "25.0405141",
      "time":
          "星期日11:30–22:00\n星期一11:30–22:00\n星期二11:30–22:00\n星期三11:30–22:00\n星期四11:30–22:00\n星期五11:30–23:00\n星期六11:30–23:00",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/56a8e7d12756dd3766b26931-莫爾頓牛排館-Morton-信義微風"
    },
    {
      "id": "328",
      "name": "theDiner 樂子(信義旗艦店)",
      "address": "臺北市信義區松壽路12號",
      "lng.": "121.5660742",
      "lat.": "25.03534868",
      "time":
          "星期日09:00–22:00\n星期一09:00–22:00\n星期二09:00–22:00\n星期三09:00–22:00\n星期四09:00–22:00\n星期五09:00–23:00\n星期六09:00–23:00",
      "cuisine_type": "美式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dbb65c03a103ee86ca0ac-樂子-the-Diner"
    },
    {
      "id": "329",
      "name": "燒肉中山",
      "address": "臺北市信義區松壽路12號10樓",
      "lng.": "121.5660665",
      "lat.": "25.0353197",
      "time":
          "星期日11:30–16:00 17:30–00:00\n星期一17:30–00:00\n星期二休息\n星期三17:30–00:00\n星期四17:30–00:00\n星期五17:30–00:00\n星期六11:30–16:00 17:30–00:00",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5eb56b272756dd0ba87690ad-燒肉中山-ZONZEN"
    },
    {
      "id": "330",
      "name": "Woolloomooloo",
      "address": "臺北市信義區信義路4段379號",
      "lng.": "121.5581471",
      "lat.": "25.03326782",
      "time":
          "星期日07:30–00:00\n星期一07:30–00:00\n星期二07:30–00:00\n星期三07:30–00:00\n星期四07:30–00:00\n星期五07:30–01:00\n星期六07:30–01:00",
      "cuisine_type": "義式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d1878c03a103ee86c3d9e-Woolloomooloo"
    },
    {
      "id": "331",
      "name": "一幻拉麵 臺北信義店",
      "address": "臺北市信義區松壽路30號1樓",
      "lng.": "121.5681028",
      "lat.": "25.0354889",
      "time":
          "星期日11:00–15:30 17:00–23:00\n星期一11:00–15:00 17:00–23:00\n星期二11:00–15:00 17:00–23:00\n星期三11:00–15:00 17:00–23:00\n星期四11:00–15:00 17:00–23:00\n星期五11:00–15:00 17:00–23:00\n星期六11:00–15:30 17:00–23:00",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/56386ecf2756dd16c2b5ebd9-一幻拉麵"
    },
    {
      "id": "332",
      "name": "海底撈火鍋 信義店",
      "address": "臺北市信義區松壽路12號6樓",
      "lng.": "121.5660643",
      "lat.": "25.03532362",
      "time":
          "星期日11:00–04:00\n星期一11:00–04:00\n星期二11:00–04:00\n星期三11:00–04:00\n星期四11:00–04:00\n星期五11:00–04:00\n星期六11:00–04:00",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/562b8efa699b6e404541b528-海底撈"
    },
    {
      "id": "333",
      "name": "頂鮮台南擔仔麵 臺北101店 (DingXian Taipei)",
      "address": "臺北市信義區信義路五段7號86樓",
      "lng.": "121.5648114",
      "lat.": "25.03355533",
      "time":
          "星期日11:30–14:30 17:30–21:30\n星期一11:30–14:30 17:30–21:30\n星期二11:30–14:30 17:30–21:30\n星期三11:30–14:30 17:30–21:30\n星期四11:30–14:30 17:30–21:30\n星期五11:30–14:30 17:30–21:30\n星期六11:30–14:30 17:30–21:30",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pppp",
      "info": "https://ifoodie.tw/restaurant/559dd8fac03a103ee86cb3cc-頂鮮101"
    },
    {
      "id": "334",
      "name": "勞瑞斯牛肋排餐廳",
      "address": "臺北市信義區松仁路28號6樓",
      "lng.": "121.5678809",
      "lat.": "25.0396427",
      "time":
          "星期日11:30–15:00 17:30–22:00\n星期一11:30–15:00 17:30–22:00\n星期二11:30–15:00 17:30–22:00\n星期三11:30–15:00 17:30–22:00\n星期四11:30–15:00 17:30–22:00\n星期五11:30–15:00 17:30–22:30\n星期六11:30–15:00 17:30–22:30",
      "cuisine_type": "美式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/559d43e0c03a103ee86c59df-Lawry's勞瑞斯-牛肋排餐廳"
    },
    {
      "id": "335",
      "name": "Musée Kitchen & Bar",
      "address": "臺北市信義區莊敬路178巷15號",
      "lng.": "121.5605977",
      "lat.": "25.03108861",
      "time":
          "星期日11:30–22:00\n星期一11:30–22:00\n星期二11:30–22:00\n星期三11:30–22:00\n星期四11:30–22:00\n星期五11:30–22:00\n星期六11:30–22:00",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56eeb536699b6e29ad675306-Musée-Kitchen-%26-Bar"
    },
    {
      "id": "336",
      "name": "Maple Tree House 楓樹 韓國烤肉",
      "address": "臺北市信義區光復南路585號",
      "lng.": "121.5576003",
      "lat.": "25.03032862",
      "time":
          "星期日12:00–00:00\n星期一12:00–00:00\n星期二12:00–00:00\n星期三12:00–00:00\n星期四12:00–00:00\n星期五12:00–00:00\n星期六12:00–00:00",
      "cuisine_type": "韓式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5936efad2756dd5f7e556ac7-Maple-Tree-House-楓樹-"
    },
    {
      "id": "337",
      "name": "德州鮮切牛排 松高店",
      "address": "臺北市信義區松高路16號3樓",
      "lng.": "121.5672871",
      "lat.": "25.03872527",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d6b5ec03a103ee86c7403-TEXAS-ROADHOUSE-德州鮮切"
    },
    {
      "id": "338",
      "name": "KiKi餐廳(信義誠品店)",
      "address": "臺北市信義區松高路11號4樓",
      "lng.": "121.5657507",
      "lat.": "25.0396539",
      "time":
          "星期日11:00–15:00 17:15–22:00\n星期一11:00–15:00 17:15–22:00\n星期二11:00–15:00 17:15–22:00\n星期三11:00–15:00 17:15–22:00\n星期四11:00–15:00 17:15–22:00\n星期五11:00–15:00 17:15–23:00\n星期六11:00–15:00 17:15–23:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d21d2c03a103ee86c4313-KIKI餐廳-信義誠品"
    },
    {
      "id": "339",
      "name": "GB鮮釀餐廳 - 臺北信義店",
      "address": "臺北市信義區松壽路11號",
      "lng.": "121.5671322",
      "lat.": "25.03718408",
      "time":
          "星期日11:00–22:30\n星期一11:00–22:30\n星期二11:00–22:30\n星期三11:00–22:30\n星期四11:00–22:30\n星期五11:00–22:30\n星期六11:00–22:30",
      "cuisine_type": "美式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d9322c03a103ee86c8bf4-GB鮮釀餐廳-GORDON-BIERSC"
    },
    {
      "id": "340",
      "name": "泰市場 Spice Market",
      "address": "臺北市信義區松高路11號6樓",
      "lng.": "121.5658817",
      "lat.": "25.03971133",
      "time":
          "星期日11:00–12:45 13:15–15:30 17:00–18:45 19:15–21:30\n星期一12:00–14:30 18:00–21:30\n星期二12:00–14:30 18:00–21:30\n星期三12:00–14:30 18:00–21:30\n星期四12:00–14:30 18:00–21:30\n星期五12:00–14:30 18:00–21:30\n星期六11:00–12:45 13:15–15:30 17:00–18:45 19:15–21:30",
      "cuisine_type": "泰式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559d21dec03a103ee86c4325-泰市場"
    },
    {
      "id": "341",
      "name": "30 thirty老酒館",
      "address": "臺北市信義區逸仙路26巷17號",
      "lng.": "121.5624478",
      "lat.": "25.03967565",
      "time":
          "星期日11:00–23:00\n星期一11:00–15:00 17:00–23:00\n星期二11:00–15:00 17:00–23:00\n星期三11:00–15:00 17:00–23:00\n星期四11:00–15:00 17:00–23:00\n星期五11:00–15:00 17:00–23:00\n星期六11:00–23:00",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559db1cec03a103ee86c9c6b-30-thirty老酒館"
    },
    {
      "id": "342",
      "name": "金色三麥 誠品酒窖店",
      "address": "臺北市信義區松高路11號B1樓",
      "lng.": "121.5658593",
      "lat.": "25.03971747",
      "time":
          "星期日11:00–23:00\n星期一11:00–23:00\n星期二11:00–23:00\n星期三11:00–23:00\n星期四11:00–23:00\n星期五11:00–00:00\n星期六11:00–00:00",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d21e4c03a103ee86c4333-金色三麥"
    },
    {
      "id": "343",
      "name": "史密斯華倫斯基牛排館 Smith & Wollensky Taipei",
      "address": "臺北市信義區松智路17號47樓",
      "lng.": "121.5669719",
      "lat.": "25.03421866",
      "time":
          "星期日11:30–22:00\n星期一11:30–22:00\n星期二11:30–22:00\n星期三11:30–22:00\n星期四11:30–22:00\n星期五11:30–23:00\n星期六11:30–23:00",
      "cuisine_type": "美式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/5c375fba22613959aafeaa69-Smith-%26-Wollensky-牛排"
    },
    {
      "id": "344",
      "name": "TankQ Cafe & Bar 松菸店",
      "address": "臺北市信義區忠孝東路四段553巷46弄14號",
      "lng.": "121.5633989",
      "lat.": "25.04414107",
      "time":
          "星期日10:30–22:00\n星期一10:30–22:00\n星期二10:30–22:00\n星期三10:30–22:00\n星期四10:30–22:00\n星期五10:30–22:00\n星期六10:30–22:00",
      "cuisine_type": "美式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58003f3b2756dd3e1d35e4c9-TankQ-Cafe-%26-Bar"
    },
    {
      "id": "345",
      "name": "旭集 和食集錦",
      "address": "臺北市信義區松仁路58號9樓",
      "lng.": "121.5676633",
      "lat.": "25.03684705",
      "time":
          "星期日11:30–14:00 14:30–16:30 17:30–21:30\n星期一11:30–14:00 14:30–16:30 17:30–21:30\n星期二11:30–14:00 14:30–16:30 17:30–21:30\n星期三11:30–14:00 14:30–16:30 17:30–21:30\n星期四11:30–14:00 14:30–16:30 17:30–21:30\n星期五11:30–14:00 14:30–16:30 17:30–21:30\n星期六11:30–14:00 14:30–16:30 17:30–21:30",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/5e54a7a98c906d2ef25b308e-旭集-和食集錦"
    },
    {
      "id": "346",
      "name": "LeTAO小樽洋菓子舖 松菸店",
      "address": "臺北市信義區忠孝東路四段553巷30號",
      "lng.": "121.562915",
      "lat.": "25.04367092",
      "time":
          "星期日11:00–21:00\n星期一11:30–21:00\n星期二11:30–21:00\n星期三11:30–21:00\n星期四11:30–21:00\n星期五11:30–21:00\n星期六11:00–21:00",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dc177c03a103ee86ca594-LeTAO小樽洋菓子舖-松菸店"
    },
    {
      "id": "347",
      "name": "好滴咖啡",
      "address": "臺北市信義區忠孝東路四段553巷26號",
      "lng.": "121.5628398",
      "lat.": "25.04352953",
      "time":
          "星期日11:30–22:00\n星期一11:30–22:00\n星期二11:30–22:00\n星期三11:30–22:00\n星期四11:30–22:00\n星期五11:30–22:00\n星期六11:30–22:00",
      "cuisine_type": "義式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d4645c03a103ee86c5b97-好滴咖啡Drip-Café"
    },
    {
      "id": "348",
      "name": "臺北君悅酒店 Café 凱菲屋",
      "address": "臺北市信義區松壽路2號1樓",
      "lng.": "121.5622784",
      "lat.": "25.03528769",
      "time":
          "星期日06:30–10:30 11:30–14:00 15:00–17:00 18:00–21:00\n星期一06:30–10:30 11:30–14:00 15:00–17:00 18:00–21:00\n星期二06:30–10:30 11:30–14:00 15:00–17:00 18:00–21:00\n星期三06:30–10:30 11:30–14:00 15:00–17:00 18:00–21:00\n星期四06:30–10:30 11:30–14:00 15:00–17:00 18:00–21:00\n星期五06:30–10:30 11:30–14:00 15:00–17:00 18:00–21:00\n星期六06:30–10:30 11:30–14:00 15:00–17:00 18:00–21:00",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d1d38c03a103ee86c4048-凱菲屋-(君悅大飯店)"
    },
    {
      "id": "349",
      "name": "陳根找茶",
      "address": "臺北市信義區莊敬路391巷7號",
      "lng.": "121.5657274",
      "lat.": "25.02843619",
      "time":
          "星期日06:30–13:00\n星期一休息\n星期二06:00–12:30\n星期三06:00–12:30\n星期四06:00–12:30\n星期五06:00–12:30\n星期六06:30–13:00",
      "cuisine_type": "台式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d624cc03a103ee86c6cbf-陳根找茶"
    },
    {
      "id": "350",
      "name": "五之神製作所 台灣",
      "address": "臺北市信義區忠孝東路四段553巷6弄6號",
      "lng.": "121.5630715",
      "lat.": "25.04220913",
      "time":
          "星期日11:30–21:00\n星期一11:30–15:00 17:00–21:00\n星期二11:30–15:00 17:00–21:00\n星期三11:30–15:00 17:00–21:00\n星期四11:30–15:00 17:00–21:00\n星期五11:30–15:00 17:00–21:00\n星期六11:30–21:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/595d2ad62756dd27e0ff1205-五之神製作所-台灣"
    },
    {
      "id": "351",
      "name": "辛殿麻辣鍋信義店",
      "address": "臺北市信義區松壽路12號",
      "lng.": "121.5661064",
      "lat.": "25.03550704",
      "time":
          "星期日11:30–01:30\n星期一11:30–01:30\n星期二11:30–01:30\n星期三11:30–01:30\n星期四11:30–01:30\n星期五11:30–01:30\n星期六11:30–01:30",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559dbb79c03a103ee86ca0d1-辛殿麻辣鍋"
    },
    {
      "id": "352",
      "name": "INPARADISE 饗饗",
      "address": "臺北市信義區忠孝東路五段68號46樓",
      "lng.": "121.5671931",
      "lat.": "25.04049679",
      "time":
          "星期日11:30–14:00 14:30–16:30 17:30–21:30\n星期一11:30–14:00 14:30–16:30 17:30–21:30\n星期二11:30–14:00 14:30–16:30 17:30–21:30\n星期三11:30–14:00 14:30–16:30 17:30–21:30\n星期四11:30–14:00 14:30–16:30 17:30–21:30\n星期五11:30–14:00 14:30–16:30 17:30–21:30\n星期六11:30–14:00 14:30–16:30 17:30–21:30",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/595a87f22756dd27dfff11d1-INPARADISE-饗饗"
    },
    {
      "id": "353",
      "name": "GYUU NIKU ステーキ專門店",
      "address": "臺北市信義區忠孝東路五段412之6號1號",
      "lng.": "121.5752646",
      "lat.": "25.04044101",
      "time":
          "星期日11:30–15:00 17:00–22:00\n星期一11:30–15:00 17:00–22:00\n星期二11:30–15:00 17:00–22:00\n星期三11:30–15:00 17:00–22:00\n星期四11:30–15:00 17:00–22:00\n星期五11:30–15:00 17:00–22:00\n星期六11:30–15:00 17:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59c6a2242756dd1b2fa15629-GYUU-NIKU-ステーキ專門店"
    },
    {
      "id": "354",
      "name": "GUMGUM Beer & Wings 雞翅酒吧",
      "address": "臺北市信義區光復南路473巷11弄38號",
      "lng.": "121.5591356",
      "lat.": "25.03395572",
      "time":
          "星期日12:00–17:00 18:00–22:30\n星期一12:00–15:30 18:00–22:30\n星期二12:00–17:00 18:00–22:30\n星期三12:00–17:00 18:00–22:30\n星期四12:00–17:00 18:00–22:30\n星期五12:00–17:00 18:00–22:30\n星期六12:00–17:00 18:00–22:30",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59b57f102756dd0ea1b2f94e-GUMGUM-Beer-%26-Wings-"
    },
    {
      "id": "355",
      "name": "Moomin café 嚕嚕米主題餐廳",
      "address": "臺北市信義區松壽路12號4樓",
      "lng.": "121.566069",
      "lat.": "25.03530287",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–23:00\n星期六11:00–23:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/595bd9402756dd27dfff1348-嚕嚕米主題餐廳-Moomin-café"
    },
    {
      "id": "356",
      "name": "檀島香港茶餐廳",
      "address": "臺北市信義區松壽路11號B1",
      "lng.": "121.5671143",
      "lat.": "25.03706265",
      "time":
          "星期日11:00–15:00 17:00–21:30\n星期一11:00–15:00 17:00–21:30\n星期二11:00–15:00 17:00–21:30\n星期三11:00–15:00 17:00–21:30\n星期四11:00–15:00 17:00–21:30\n星期五11:00–15:00 17:00–22:00\n星期六11:00–15:00 17:00–22:00",
      "cuisine_type": "港式",
      "rating": "3.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/590b6d8b2756dd17cd7fa615-檀島香港茶餐廳"
    },
    {
      "id": "357",
      "name": "She_Design tapas soju bar",
      "address": "臺北市信義區基隆路一段127號一樓",
      "lng.": "121.5668429",
      "lat.": "25.0444997",
      "time":
          "星期日14:30–22:00\n星期一17:30–01:00\n星期二17:30–01:00\n星期三17:30–01:00\n星期四17:30–01:00\n星期五17:30–02:00\n星期六17:30–02:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/57d59cf22756dd05d585abd8-She_Design-tapas-soj"
    },
    {
      "id": "358",
      "name": "醐同燒肉夜食五號店",
      "address": "臺北市信義區松壽路22號2樓",
      "lng.": "121.567895",
      "lat.": "25.03548772",
      "time":
          "星期日12:00–14:30 18:00–23:30\n星期一12:00–14:30 18:00–23:30\n星期二12:00–14:30 18:00–23:30\n星期三12:00–14:30 18:00–23:30\n星期四12:00–14:30 18:00–23:30\n星期五12:00–14:30 18:00–23:30\n星期六12:00–14:30 18:00–23:30",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559ddd9ac03a103ee86cb6f8-醐同燒肉夜食"
    },
    {
      "id": "359",
      "name": "臺北寒舍艾美酒店探索廚房",
      "address": "臺北市信義區松仁路38號",
      "lng.": "121.5681207",
      "lat.": "25.03812729",
      "time":
          "星期日06:30–10:00 11:30–14:00 15:00–17:00 18:00–21:30\n星期一06:30–10:00 11:30–14:00 15:00–17:00 18:00–21:30\n星期二06:30–10:00 11:30–14:00 15:00–17:00 18:00–21:30\n星期三06:30–10:00 11:30–14:00 15:00–17:00 18:00–21:30\n星期四06:30–10:00 11:30–14:00 15:00–17:00 18:00–21:30\n星期五06:30–10:00 11:30–14:00 15:00–17:00 18:00–21:30\n星期六06:30–10:00 11:30–14:00 15:00–17:00 18:00–21:30",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d6a37c03a103ee86c72d3-探索廚房-(寒舍艾美酒店)"
    },
    {
      "id": "360",
      "name": "艾朋牛排餐酒館 À POINT STEAK & BAR",
      "address": "臺北市信義區忠孝東路五段139號2樓",
      "lng.": "121.5679197",
      "lat.": "25.0412498",
      "time":
          "星期日11:30–15:00 17:30–03:00\n星期一11:30–15:00 17:30–03:00\n星期二11:30–15:00 17:30–03:00\n星期三11:30–15:00 17:30–03:00\n星期四11:30–15:00 17:30–03:00\n星期五11:30–15:00 17:30–04:00\n星期六11:30–15:00 17:30–04:00",
      "cuisine_type": "義式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/59456f762756dd524dd08e03-À-Point-艾朋牛排餐酒館"
    },
    {
      "id": "361",
      "name": "INHOUSE",
      "address": "臺北市信義區松仁路90號",
      "lng.": "121.5679898",
      "lat.": "25.03501339",
      "time":
          "星期日12:00–03:00\n星期一12:00–03:00\n星期二12:00–03:00\n星期三12:00–03:00\n星期四12:00–03:00\n星期五12:00–03:00\n星期六12:00–03:00",
      "cuisine_type": "美式",
      "rating": "3.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d3487c03a103ee86c4fee-INHOUSE"
    },
    {
      "id": "362",
      "name": "JK STUDIO 新義法料理",
      "address": "臺北市信義區基隆路一段147巷5弄13號",
      "lng.": "121.5661891",
      "lat.": "25.0429057",
      "time":
          "星期日11:30–15:00 17:30–22:00\n星期一休息\n星期二11:30–15:00 17:30–22:00\n星期三11:30–15:00 17:30–22:00\n星期四11:30–15:00 17:30–22:00\n星期五11:30–15:00 17:30–22:00\n星期六11:30–15:00 17:30–22:00",
      "cuisine_type": "義式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/576199b42756dd1d469e4a3d-JK-studio-新義法料理"
    },
    {
      "id": "363",
      "name": "靜岡勝政日式豬排 統一時代店",
      "address": "臺北市信義區忠孝東路五段8號B2",
      "lng.": "121.5650876",
      "lat.": "25.04077905",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d44bbc03a103ee86c5a97-靜岡勝政日式豬排"
    },
    {
      "id": "364",
      "name": "新村站著吃烤肉",
      "address": "臺北市信義區忠孝東路五段159號",
      "lng.": "121.5685261",
      "lat.": "25.04123465",
      "time":
          "星期日11:30–00:00\n星期一11:30–14:30 17:00–00:00\n星期二11:30–14:30 17:00–00:00\n星期三11:30–14:30 17:00–00:00\n星期四11:30–14:30 17:00–00:00\n星期五11:30–14:30 17:00–02:00\n星期六11:30–02:00",
      "cuisine_type": "韓式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5cf760962261397317deda8d-新村站著吃烤肉"
    },
    {
      "id": "365",
      "name": "教父牛排 Top Cap Steakhouse",
      "address": "臺北市信義區松高路19號",
      "lng.": "121.5666919",
      "lat.": "25.03940366",
      "time":
          "星期日11:30–15:00 17:30–22:00\n星期一12:00–15:00 18:00–22:00\n星期二12:00–15:00 18:00–22:00\n星期三12:00–15:00 18:00–22:00\n星期四12:00–15:00 18:00–22:00\n星期五12:00–15:00 18:00–22:00\n星期六11:30–15:00 17:30–22:00",
      "cuisine_type": "美式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/559dae87c03a103ee86c9a8b-Top-Cap-Steakhouse"
    },
    {
      "id": "366",
      "name": "Woosaパンケーキ 屋莎鬆餅屋 臺北松菸店",
      "address": "臺北市信義區忠孝東路四段553巷28號",
      "lng.": "121.5628541",
      "lat.": "25.04359643",
      "time":
          "星期日11:00–21:30\n星期一11:30–21:30\n星期二11:30–21:30\n星期三11:30–21:30\n星期四11:30–21:30\n星期五11:30–21:30\n星期六11:00–21:30",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b4e30e82756dd51fc84b989-woosaパンケーキ-屋莎鬆餅屋-臺北松"
    },
    {
      "id": "367",
      "name": "家咖哩 松菸店",
      "address": "臺北市信義區忠孝東路四段553巷46弄4號",
      "lng.": "121.5630639",
      "lat.": "25.04414591",
      "time":
          "星期日11:30–21:00\n星期一11:45–14:30 17:00–21:00\n星期二11:45–14:30 17:00–21:00\n星期三11:45–14:30 17:00–21:00\n星期四11:45–14:30 17:00–21:00\n星期五11:45–14:30 17:00–21:00\n星期六11:30–21:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56f4b3382756dd347cdc641f-家咖哩-Jiacurry"
    },
    {
      "id": "368",
      "name": "Out of office 不在辦公室",
      "address": "臺北市信義區忠孝東路五段之17號之3B1",
      "lng.": "121.5655707",
      "lat.": "25.04135229",
      "time":
          "星期日10:00–21:00\n星期一10:00–21:00\n星期二10:00–21:00\n星期三10:00–21:00\n星期四10:00–21:00\n星期五10:00–21:00\n星期六10:00–21:00",
      "cuisine_type": "美式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5acaeebb23679c203c9f188a-Out-of-office-不在辦公室"
    },
    {
      "id": "369",
      "name": "北村豆腐家 統一時代臺北店",
      "address": "臺北市信義區忠孝東路五段8號B2",
      "lng.": "121.5652804",
      "lat.": "25.04069933",
      "time":
          "星期日07:30–10:30 11:00–21:30\n星期一07:30–10:30 11:00–21:30\n星期二07:30–10:30 11:00–21:30\n星期三07:30–10:30 11:00–21:30\n星期四07:30–10:30 11:00–21:30\n星期五07:30–10:30 11:00–22:00\n星期六07:30–10:30 11:00–22:00",
      "cuisine_type": "韓式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59174a882756dd5484ad8f6e-北村豆腐家-統一時代臺北店"
    },
    {
      "id": "370",
      "name": "合.shabu",
      "address": "臺北市信義區松仁路28號4樓",
      "lng.": "121.5676361",
      "lat.": "25.03961196",
      "time":
          "星期日12:00–16:00 17:30–22:00\n星期一12:00–14:30 17:30–22:00\n星期二12:00–14:30 17:30–22:00\n星期三12:00–14:30 17:30–22:00\n星期四12:00–14:30 17:30–22:00\n星期五12:00–14:30 17:30–22:30\n星期六12:00–16:00 17:30–22:30",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559dba8ac03a103ee86ca04d-合shabu"
    },
    {
      "id": "371",
      "name": "美滋鍋台灣",
      "address": "臺北市信義區松壽路12號7樓",
      "lng.": "121.5660683",
      "lat.": "25.03530117",
      "time":
          "星期日11:00–02:00\n星期一11:00–02:00\n星期二11:00–02:00\n星期三11:00–02:00\n星期四11:00–02:00\n星期五11:00–02:00\n星期六11:00–02:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5d693afdd6895d2a10e9d2fc-美滋鍋台灣"
    },
    {
      "id": "372",
      "name": "欣葉 日本料理 信義新天地A11",
      "address": "臺北市信義區松壽路11號5樓",
      "lng.": "121.5671978",
      "lat.": "25.03603136",
      "time":
          "星期日11:30–14:00 14:30–16:30 17:10–19:10 19:30–21:30\n星期一11:30–14:00 14:30–16:30 17:30–21:30\n星期二11:30–14:00 14:30–16:30 17:30–21:30\n星期三11:30–14:00 14:30–16:30 17:30–21:30\n星期四11:30–14:00 14:30–16:30 17:30–21:30\n星期五11:30–14:00 14:30–16:30 17:30–21:30\n星期六11:30–14:00 14:30–16:30 17:10–19:10 19:30–21:30",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559d9327c03a103ee86c8c06-欣葉日式料理"
    },
    {
      "id": "373",
      "name": "Hërs biströ她/的餐酒",
      "address": "臺北市信義區忠孝東路四段553巷22弄4號",
      "lng.": "121.5631057",
      "lat.": "25.04316185",
      "time":
          "星期日12:00–21:30\n星期一12:00–21:00\n星期二12:00–21:00\n星期三12:00–21:00\n星期四12:00–21:00\n星期五12:00–21:00\n星期六12:00–21:30",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59c400312756dd1b34a0f9c2-Hërs-biströ她%2F的餐酒"
    },
    {
      "id": "374",
      "name": "日本橋海鮮丼辻半 微風信義店",
      "address": "臺北市信義區忠孝東路五段68號B1",
      "lng.": "121.5669658",
      "lat.": "25.04052952",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5b42aac523679c72687410a3-日本橋海鮮丼つじ半-Tsujihan-微"
    },
    {
      "id": "375",
      "name": "博多天麩羅 山海",
      "address": "臺北市信義區忠孝東路五段8號B2",
      "lng.": "121.564576",
      "lat.": "25.0406188",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–21:30\n星期六11:00–21:30",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d6472c03a103ee86c6ee0-博多天ぶらやまみ(博多天麩羅山海)"
    },
    {
      "id": "376",
      "name": "CÉ LA VI Taipei",
      "address": "臺北市信義區松智路17號48樓",
      "lng.": "121.5659624",
      "lat.": "25.03430466",
      "time":
          "星期日12:00–14:30 15:00–17:30 18:00–02:30\n星期一休息\n星期二12:00–14:30 15:00–02:30\n星期三12:00–14:30 15:00–02:30\n星期四12:00–14:30 15:00–02:30\n星期五12:00–14:30 15:00–03:00\n星期六12:00–14:30 15:00–17:30 18:00–03:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/5cc708a72756dd5865e49fa9-CÉ-LA-VI-Taipei"
    },
    {
      "id": "377",
      "name": "寅藏鐵板燒 忠孝店",
      "address": "臺北市信義區忠孝東路四段559巷16弄2號",
      "lng.": "121.5638614",
      "lat.": "25.04227204",
      "time":
          "星期日11:30–14:00 17:30–20:45\n星期一11:30–14:00 17:30–20:45\n星期二11:30–14:00 17:30–20:45\n星期三11:30–14:00 17:30–20:45\n星期四11:30–14:00 17:30–20:45\n星期五11:30–14:00 17:30–20:45\n星期六11:30–14:00 17:30–20:45",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5e15e5a42756dd6649f66936-寅藏鐵板燒"
    },
    {
      "id": "378",
      "name": "La Farfalla 義式餐廳",
      "address": "臺北市信義區松高路18號6樓",
      "lng.": "121.5674675",
      "lat.": "25.03871476",
      "time":
          "星期日11:30–14:30 18:00–22:00\n星期一休息\n星期二11:30–14:30 18:00–22:00\n星期三11:30–14:30 18:00–22:00\n星期四11:30–14:30 18:00–22:00\n星期五11:30–14:30 18:00–22:00\n星期六11:30–14:30 18:00–22:00",
      "cuisine_type": "義式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/5af6ebbaf52468745d556275-La-Farfalla-義式餐廳"
    },
    {
      "id": "379",
      "name": "屋頂上的貓 私廚",
      "address": "臺北市信義區逸仙路32巷9號1樓",
      "lng.": "121.562325",
      "lat.": "25.03994735",
      "time":
          "星期日12:00–15:00 19:00–22:00\n星期一12:00–15:00 19:00–22:00\n星期二12:00–15:00 19:00–22:00\n星期三12:00–15:00 19:00–22:00\n星期四12:00–15:00 19:00–22:00\n星期五12:00–15:00 19:00–22:00\n星期六12:00–15:00 19:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559d49e1c03a103ee86c5daa-屋頂上的貓-私廚"
    },
    {
      "id": "380",
      "name": "燒肉神保町信義館",
      "address": "臺北市信義區松壽路12號4樓",
      "lng.": "121.5660683",
      "lat.": "25.03530816",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–23:00\n星期六11:00–23:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5f64b7b402935e096417a64a-燒肉神保町信義館"
    },
    {
      "id": "381",
      "name": "宋廚菜館",
      "address": "臺北市信義區忠孝東路五段15巷14號",
      "lng.": "121.5654703",
      "lat.": "25.0417841",
      "time":
          "星期日休息\n星期一11:30–14:00 17:30–21:00\n星期二11:30–14:00 17:30–21:00\n星期三11:30–14:00 17:30–21:00\n星期四11:30–14:00 17:30–21:00\n星期五11:30–14:00 17:30–21:00\n星期六11:30–14:00 17:30–21:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d688ec03a103ee86c71ed-宋廚菜館"
    },
    {
      "id": "382",
      "name": "大初 Tenppanyaki",
      "address": "臺北市信義區忠孝東路四段553巷6弄16號",
      "lng.": "121.5634913",
      "lat.": "25.04219442",
      "time":
          "星期日11:30–13:30 17:30–21:30\n星期一休息\n星期二12:00–14:00 17:30–21:30\n星期三12:00–14:00 17:30–21:30\n星期四12:00–14:00 17:30–21:30\n星期五12:00–14:00 17:30–21:30\n星期六11:30–13:30 17:30–21:30",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/59d12e922756dd6fa98b35d0-大初-Tenppanyaki"
    },
    {
      "id": "383",
      "name": "Just Grill",
      "address": "臺北市信義區松高路11號6樓",
      "lng.": "121.5658705",
      "lat.": "25.03971861",
      "time":
          "星期日11:00–15:30 17:00–21:30\n星期一12:00–14:30 18:00–21:30\n星期二12:00–14:30 18:00–21:30\n星期三12:00–14:30 18:00–21:30\n星期四12:00–14:30 18:00–21:30\n星期五12:00–14:30 18:00–21:30\n星期六11:00–15:30 17:00–21:30",
      "cuisine_type": "美式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/564162712756dd0e998f8248-Just-Grill牛排"
    },
    {
      "id": "384",
      "name": "韓川館",
      "address": "臺北市信義區忠孝東路四段559巷26號",
      "lng.": "121.5638146",
      "lat.": "25.04273831",
      "time":
          "星期日11:30–15:00 16:30–21:00\n星期一11:30–14:00 17:00–21:00\n星期二11:30–14:00 17:00–21:00\n星期三11:30–14:00 17:00–21:00\n星期四11:30–14:00 17:00–21:00\n星期五11:30–14:00 17:00–21:00\n星期六11:30–15:00 16:30–21:00",
      "cuisine_type": "韓式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d35fbc03a103ee86c50f1-韓川館"
    },
    {
      "id": "385",
      "name": "韓姜熙의小廚房 微風松高店",
      "address": "臺北市信義區松高路16號B2",
      "lng.": "121.5672796",
      "lat.": "25.03872458",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "韓式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5a2ec86a2756dd43b74330cc-韓姜熙-小廚房"
    },
    {
      "id": "386",
      "name": "Danny's i pasta",
      "address": "臺北市信義區松高路19號",
      "lng.": "121.5666597",
      "lat.": "25.03962576",
      "time":
          "星期日11:00–21:00\n星期一11:00–21:00\n星期二11:00–21:00\n星期三11:00–21:00\n星期四11:00–15:30 17:00–21:00\n星期五11:00–21:00\n星期六11:00–21:00",
      "cuisine_type": "義式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56cc04212756dd42df04d3d4-Danny's-i-pasta"
    },
    {
      "id": "387",
      "name": "11 Cafe《早午餐&創意義大利麵專賣店》",
      "address": "臺北市信義區忠孝東路四段553巷12號",
      "lng.": "121.562824",
      "lat.": "25.04252621",
      "time":
          "星期日10:30–21:00\n星期一11:30–21:00\n星期二11:30–21:00\n星期三11:30–21:00\n星期四11:30–21:00\n星期五11:30–21:00\n星期六10:30–21:00",
      "cuisine_type": "義式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d59f0c03a103ee86c6812-11-Cafe'"
    },
    {
      "id": "388",
      "name": "高麗屋",
      "address": "臺北市信義區虎林街132巷37號",
      "lng.": "121.5755153",
      "lat.": "25.04013562",
      "time":
          "星期日11:30–14:00 17:00–21:00\n星期一11:30–14:00 17:00–21:00\n星期二休息\n星期三11:30–14:00 17:00–21:00\n星期四11:30–14:00 17:00–21:00\n星期五11:30–14:00 17:00–21:00\n星期六11:30–14:00 17:00–21:00",
      "cuisine_type": "韓式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/5ad638ba2756dd41bee0d825-高麗屋"
    },
    {
      "id": "389",
      "name": "Nola Kitchen 紐澳良小廚",
      "address": "臺北市信義區信義路五段150巷14弄16號",
      "lng.": "121.5698493",
      "lat.": "25.02841463",
      "time":
          "星期日10:00–22:00\n星期一11:30–22:00\n星期二11:30–22:00\n星期三11:30–22:00\n星期四11:30–22:00\n星期五11:30–22:00\n星期六10:00–22:00",
      "cuisine_type": "美式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559da8e6c03a103ee86c9659-Nola-Kitchen-紐澳良小廚"
    },
    {
      "id": "390",
      "name": "渣男 Taiwan Bistro 信義一渣",
      "address": "臺北市信義區信義路五段150巷315弄12號",
      "lng.": "121.5687657",
      "lat.": "25.02695256",
      "time":
          "星期日17:30–01:30\n星期一17:30–01:30\n星期二17:30–01:30\n星期三17:30–01:30\n星期四17:30–01:30\n星期五17:30–01:30\n星期六17:30–01:30",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/573617f82756dd46bca09325-渣男-Taiwan-Bistro"
    },
    {
      "id": "391",
      "name": "撈王鍋物料理 台灣一號店",
      "address": "臺北市信義區松壽路12號9樓",
      "lng.": "121.5660579",
      "lat.": "25.03530908",
      "time":
          "星期日11:00–00:00\n星期一11:00–23:00\n星期二11:00–23:00\n星期三11:00–23:00\n星期四11:00–23:00\n星期五11:00–00:00\n星期六11:00–00:00",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/59f1ac19f524683354963a65-撈王鍋物料理-台灣1號店"
    },
    {
      "id": "392",
      "name": "饗食天堂 臺北信義店",
      "address": "臺北市信義區松壽路12號6樓",
      "lng.": "121.5660665",
      "lat.": "25.03527738",
      "time":
          "星期日11:30–14:00 14:30–16:30 17:30–21:30\n星期一11:30–14:00 14:30–16:30 17:30–21:30\n星期二11:30–14:00 14:30–16:30 17:30–21:30\n星期三11:30–14:00 14:30–16:30 17:30–21:30\n星期四11:30–14:00 14:30–16:30 17:30–21:30\n星期五11:30–14:00 14:30–16:30 17:30–21:30\n星期六11:30–14:00 14:30–16:30 17:30–21:30",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559dbba2c03a103ee86ca15e-饗食天堂"
    },
    {
      "id": "393",
      "name": "Café del SOL 福岡人氣第一鬆餅",
      "address": "臺北市信義區忠孝東路五段68號2樓",
      "lng.": "121.5669007",
      "lat.": "25.04054529",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bd08c8622613911e21e8a7b-Café-del-SOL"
    },
    {
      "id": "394",
      "name": "NARA Thai Cuisine 泰式料理 臺北統一時代店",
      "address": "臺北市信義區忠孝東路五段8號7樓",
      "lng.": "121.5656329",
      "lat.": "25.04056697",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "泰式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d5ea5342756dd2f131a3e3b-NARA-Thai-Cuisine-臺北"
    },
    {
      "id": "395",
      "name": "激安の食事酒場 市府二號店",
      "address": "臺北市信義區基隆路一段147巷5弄1號1樓",
      "lng.": "121.5659738",
      "lat.": "25.04261327",
      "time":
          "星期日17:30–01:00\n星期一17:30–01:00\n星期二17:30–01:00\n星期三17:30–01:00\n星期四17:30–01:00\n星期五17:30–01:00\n星期六17:30–01:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5888e8d42756dd64a50bc104-激安の食事酒場-市府二號店"
    },
    {
      "id": "396",
      "name": "Meat Love橡木炭火韓國烤肉 信義店",
      "address": "臺北市信義區信義路四段468號",
      "lng.": "121.5592069",
      "lat.": "25.03281939",
      "time":
          "星期日11:30–01:00\n星期一11:30–01:00\n星期二11:30–01:00\n星期三11:30–01:00\n星期四11:30–01:00\n星期五11:30–01:00\n星期六11:30–01:00",
      "cuisine_type": "韓式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5914a8482756dd5b971ae17e-Meat-Love-KOREAN-BBQ"
    },
    {
      "id": "397",
      "name": "瑞記海南雞飯 永吉店",
      "address": "臺北市信義區永吉路30巷145號",
      "lng.": "121.5688278",
      "lat.": "25.04255559",
      "time":
          "星期日11:30–21:00\n星期一11:30–21:00\n星期二11:30–21:00\n星期三11:30–21:00\n星期四11:30–21:00\n星期五11:30–21:00\n星期六11:30–21:00",
      "cuisine_type": "東南亞",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/58bda5a82756dd732889b4a5-瑞記海南雞飯"
    },
    {
      "id": "398",
      "name": "泰集泰式料理 微風信義店",
      "address": "臺北市信義區忠孝東路五段68號4樓",
      "lng.": "121.5668988",
      "lat.": "25.04050384",
      "time":
          "星期日11:30–15:30 17:30–21:30\n星期一11:30–14:00 17:30–21:30\n星期二11:30–14:00 17:30–21:30\n星期三11:30–14:00 17:30–21:30\n星期四11:30–14:00 17:30–21:30\n星期五11:30–14:00 17:30–21:30\n星期六11:30–14:00 17:30–21:30",
      "cuisine_type": "泰式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/56a8e75d699b6e7f209284e2-泰集-Thai-Bazaa-(微風信義店"
    },
    {
      "id": "399",
      "name": "Wake n Bake",
      "address": "臺北市信義區永吉路30巷158弄18號",
      "lng.": "121.5680237",
      "lat.": "25.04222926",
      "time":
          "星期日12:00–21:30\n星期一12:00–21:30\n星期二12:00–21:30\n星期三12:00–21:30\n星期四12:00–21:30\n星期五12:00–22:00\n星期六12:00–22:00",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a6656ac03a104df53c9f89-Wake-n-Bake"
    },
    {
      "id": "400",
      "name": "佳佳甜品",
      "address": "臺北市信義區基隆路一段145-2號",
      "lng.": "121.5657596",
      "lat.": "25.0426204",
      "time":
          "星期日12:00–23:00\n星期一12:00–23:00\n星期二12:00–23:00\n星期三12:00–23:00\n星期四12:00–23:00\n星期五12:00–23:00\n星期六12:00–23:00",
      "cuisine_type": "港式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5a7aaf5c2756dd7bff171d07-佳佳甜品"
    },
    {
      "id": "401",
      "name": "JOYCE EAST",
      "address": "臺北市信義區信義路五段128號",
      "lng.": "121.5693194",
      "lat.": "25.03241743",
      "time":
          "星期日11:30–23:00\n星期一11:30–23:00\n星期二11:30–23:00\n星期三11:30–23:00\n星期四11:30–23:00\n星期五11:30–23:00\n星期六11:30–23:00",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d66e4c03a103ee86c70c9-JOYCEEAST餐廳"
    },
    {
      "id": "402",
      "name": "心月",
      "address": "臺北市信義區信義路四段466號",
      "lng.": "121.5589998",
      "lat.": "25.03275782",
      "time":
          "星期日11:45–14:00 17:45–21:00\n星期一11:45–14:00 17:45–21:00\n星期二11:45–14:00 17:45–21:00\n星期三11:45–14:00 17:45–21:00\n星期四11:45–14:00 17:45–21:00\n星期五11:45–14:00 17:45–21:00\n星期六11:45–14:00 17:45–21:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559d2b31c03a103ee86c4946-心月懷石日本料理"
    },
    {
      "id": "403",
      "name": "銅盤嚴選韓式烤肉 臺北統一時代店",
      "address": "臺北市信義區忠孝東路五段8號7樓",
      "lng.": "121.5653933",
      "lat.": "25.04075324",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "韓式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5919ed852756dd5480ad90ed-銅盤嚴選韓式烤肉"
    },
    {
      "id": "404",
      "name": "SHABUSATO涮鍋里 微風南山店",
      "address": "臺北市信義區松智路17號5樓",
      "lng.": "121.5665045",
      "lat.": "25.03416999",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "3.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c7565ba2261395854b97706-SHABUSATO-微風南山店"
    },
    {
      "id": "405",
      "name": "饗泰多 Siam More 泰式風格餐廳 臺北信義 微風松高店",
      "address": "臺北市信義區松高路16號3樓",
      "lng.": "121.5672795",
      "lat.": "25.03872254",
      "time":
          "星期日11:00–16:00 17:00–21:30\n星期一11:30–15:00 17:30–21:30\n星期二11:30–15:00 17:30–21:30\n星期三11:30–15:00 17:30–21:30\n星期四11:30–15:00 17:30–21:30\n星期五11:30–15:00 17:30–21:30\n星期六11:00–16:00 17:00–21:30",
      "cuisine_type": "泰式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c57bd4f23679c5f1681f7e3-饗泰多%E3%80%82微風松高店"
    },
    {
      "id": "406",
      "name": "麻辣45 本店",
      "address": "臺北市信義區忠孝東路五段68號45樓",
      "lng.": "121.5668964",
      "lat.": "25.04050088",
      "time":
          "星期日11:30–00:00\n星期一11:30–00:00\n星期二11:30–00:00\n星期三11:30–00:00\n星期四11:30–00:00\n星期五11:30–00:00\n星期六11:30–00:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/5dad4aab8c906d2545c91bac-麻辣45"
    },
    {
      "id": "407",
      "name": "French Windows British Teahouse 琺蘭綺瑥朵英式茶餐館",
      "address": "臺北市信義區忠孝東路四段553巷22弄51之1號1樓",
      "lng.": "121.5634008",
      "lat.": "25.04340741",
      "time":
          "星期日11:15–21:30\n星期一11:15–21:30\n星期二11:15–21:30\n星期三11:15–21:30\n星期四11:15–21:30\n星期五11:15–21:30\n星期六11:15–22:30",
      "cuisine_type": "義式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d3eeac03a103ee86c56aa-French-Windows-琺蘭綺瑥朵"
    },
    {
      "id": "408",
      "name": "屯京拉麵 (新光三越A8)",
      "address": "臺北市信義區松高路12號B2",
      "lng.": "121.5666559",
      "lat.": "25.0377033",
      "time":
          "星期日11:00–22:00\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–21:30\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d5355c03a103ee86c63b2-屯京拉麵"
    },
    {
      "id": "409",
      "name": "N.Y.BAGELS CAFÉ",
      "address": "臺北市信義區信義路五段122號",
      "lng.": "121.5687528",
      "lat.": "25.03226937",
      "time":
          "星期日08:00–21:00\n星期一09:00–16:00\n星期二09:00–16:00\n星期三09:00–16:00\n星期四09:00–16:00\n星期五09:00–21:00\n星期六08:00–21:00",
      "cuisine_type": "美式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d19a5c03a103ee86c3e62-N.Y.BAGELS-CAFÉ"
    },
    {
      "id": "410",
      "name": "初衷小鹿 Deer's hotpot Bistro",
      "address": "臺北市信義區忠孝東路四段553巷6弄15號",
      "lng.": "121.563419",
      "lat.": "25.04239846",
      "time":
          "星期日11:30–15:00 17:30–22:30\n星期一11:30–15:00 17:30–22:30\n星期二11:30–15:00 17:30–22:30\n星期三11:30–15:00 17:30–22:30\n星期四11:30–15:00 17:30–22:30\n星期五11:30–15:00 17:30–22:30\n星期六11:30–15:00 17:30–22:30",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c453644f524682cd99e68d4-Deer's-Hot-Pot-初衷小鹿原"
    },
    {
      "id": "411",
      "name": "Miacucina信義店",
      "address": "臺北市信義區松壽路11號2樓",
      "lng.": "121.5672543",
      "lat.": "25.03603704",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "義式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56de4896699b6e52e155a966-Miacucina-新光三越A11"
    },
    {
      "id": "412",
      "name": "三井cuisine M",
      "address": "臺北市信義區松智路1號",
      "lng.": "121.5662878",
      "lat.": "25.03856809",
      "time":
          "星期日11:30–14:30 17:30–22:00\n星期一11:30–14:30 17:30–22:00\n星期二11:30–14:30 17:30–22:00\n星期三11:30–14:30 17:30–22:00\n星期四11:30–14:30 17:30–22:00\n星期五11:30–14:30 17:30–22:00\n星期六11:30–14:30 17:30–22:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559dcb1fc03a103ee86cab9d-三井-Cuisine-M"
    },
    {
      "id": "413",
      "name": "樂軒松阪亭",
      "address": "臺北市信義區松高路19號",
      "lng.": "121.5664302",
      "lat.": "25.03941768",
      "time":
          "星期日11:30–14:30 17:30–21:30\n星期一11:30–14:30 17:30–21:30\n星期二11:30–14:30 17:30–21:30\n星期三11:30–14:30 17:30–21:30\n星期四11:30–14:30 17:30–21:30\n星期五11:30–14:30 17:30–21:30\n星期六11:30–14:30 17:30–21:30",
      "cuisine_type": "日式",
      "rating": "4.8",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info": "https://ifoodie.tw/restaurant/5af9cff42756dd5e0a5dc74d-樂軒松阪亭"
    },
    {
      "id": "414",
      "name": "和牛47",
      "address": "臺北市信義區松仁路100號47樓",
      "lng.": "121.5678805",
      "lat.": "25.03445225",
      "time":
          "星期日11:30–15:30 17:30–23:00\n星期一11:30–15:30 17:30–23:00\n星期二11:30–15:30 17:30–23:00\n星期三11:30–15:30 17:30–23:00\n星期四11:30–15:30 17:30–23:00\n星期五11:30–15:30 17:30–23:00\n星期六11:30–15:30 17:30–23:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pppp",
      "info": "https://ifoodie.tw/restaurant/5c700d0a23679c0cb436069a-和牛47"
    },
    {
      "id": "415",
      "name": "滷肉控",
      "address": "臺北市信義區逸仙路42巷11號",
      "lng.": "121.5626507",
      "lat.": "25.04031384",
      "time":
          "星期日12:00–20:00\n星期一11:00–20:00\n星期二11:00–20:00\n星期三11:00–20:00\n星期四11:00–20:00\n星期五11:00–20:00\n星期六12:00–20:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5d4246122261395c28034983-滷肉控"
    },
    {
      "id": "416",
      "name": "去憂餐酒館 Chill Bistro & Bar",
      "address": "臺北市信義區忠孝東路五段15巷10號",
      "lng.": "121.565433",
      "lat.": "25.04168055",
      "time":
          "星期日18:00–02:00\n星期一18:00–02:00\n星期二18:00–02:00\n星期三18:00–02:00\n星期四18:00–02:00\n星期五18:00–03:00\n星期六18:00–03:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.6",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5bf6991e2261396e34fb4aed-去憂餐酒館-Chill-Bistro-%26"
    },
    {
      "id": "417",
      "name": "The Corner Pit 角窩",
      "address": "臺北市信義區基隆路二段10號",
      "lng.": "121.5589648",
      "lat.": "25.03229681",
      "time":
          "星期日17:00–03:00\n星期一17:00–03:00\n星期二17:00–03:00\n星期三17:00–03:00\n星期四17:00–03:00\n星期五17:00–03:00\n星期六17:00–03:00",
      "cuisine_type": "美式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/572e2f662756dd5768f4d389-The-Corner-Pit-角窩"
    },
    {
      "id": "418",
      "name": "飯BAR Station 信義微風店",
      "address": "臺北市信義區忠孝東路五段68號4樓",
      "lng.": "121.566894",
      "lat.": "25.04050061",
      "time":
          "星期日11:00–15:00 17:00–21:30\n星期一11:30–14:30 17:30–21:30\n星期二11:30–14:30 17:30–21:30\n星期三11:30–14:30 17:30–21:30\n星期四11:30–14:30 17:30–22:00\n星期五11:30–14:30 17:30–22:00\n星期六11:00–15:00 17:00–22:00",
      "cuisine_type": "中式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5a26df9a2756dd43b7429415-飯BAR-Station-信義微風店"
    },
    {
      "id": "419",
      "name": "Mad for garlic",
      "address": "臺北市信義區松智路17號7樓",
      "lng.": "121.5660144",
      "lat.": "25.03425703",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5c38b3fe2261397c3b9d7e07-Mad-For-Garlic"
    },
    {
      "id": "420",
      "name": "世界的山將 市政府店",
      "address": "臺北市信義區忠孝東路五段15巷10號1樓",
      "lng.": "121.5654694",
      "lat.": "25.04176612",
      "time":
          "星期日11:30–23:00\n星期一11:30–23:00\n星期二11:30–23:00\n星期三11:30–23:00\n星期四11:30–23:00\n星期五11:30–00:00\n星期六11:30–00:00",
      "cuisine_type": "日式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/565bfe462756dd510d9686a3-世界的山將"
    },
    {
      "id": "421",
      "name": "AWESOME BURGER",
      "address": "臺北市信義區基隆路一段190巷11號",
      "lng.": "121.5641647",
      "lat.": "25.04202054",
      "time":
          "星期日11:30–14:00 17:00–20:20\n星期一休息\n星期二11:30–14:00 17:00–20:20\n星期三11:30–14:00 17:00–20:20\n星期四11:30–14:00 17:00–20:20\n星期五11:30–14:00 17:00–20:20\n星期六11:30–14:00 17:00–20:20",
      "cuisine_type": "美式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d7591c03a103ee86c7ac5-AWESOME-BURGER"
    },
    {
      "id": "422",
      "name": "韓老二 韓國烤肉-信義旗艦店",
      "address": "臺北市信義區松壽路28號",
      "lng.": "121.5680411",
      "lat.": "25.03522419",
      "time":
          "星期日12:00–14:00 17:00–00:00\n星期一17:30–00:00\n星期二17:30–00:00\n星期三17:30–00:00\n星期四17:30–00:00\n星期五17:30–00:00\n星期六12:00–14:00 17:00–00:00",
      "cuisine_type": "韓式",
      "rating": "3.7",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/581f72a62756dd576ac04f30-韓老二-韓國烤肉-信義店"
    },
    {
      "id": "423",
      "name": "樂天皇朝信義店",
      "address": "臺北市信義區忠孝東路五段68號4樓",
      "lng.": "121.5669846",
      "lat.": "25.04056962",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "港式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/56406b42699b6e4842e962b0-樂天皇朝"
    },
    {
      "id": "424",
      "name": "BLAnC",
      "address": "臺北市信義區忠孝東路四段553巷6弄14-1號",
      "lng.": "121.5634203",
      "lat.": "25.04219977",
      "time":
          "星期日11:30–21:00\n星期一休息\n星期二11:30–21:00\n星期三11:30–21:00\n星期四11:30–21:00\n星期五11:30–21:00\n星期六11:30–21:00",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/565617782756dd1d7a1b0327-BLAnC"
    },
    {
      "id": "425",
      "name": "烤食煮盒便當屋",
      "address": "臺北市信義區永吉路30巷157弄9號",
      "lng.": "121.5691311",
      "lat.": "25.04241101",
      "time":
          "星期日10:30–14:00 16:00–19:30\n星期一10:30–14:00 16:00–20:00\n星期二10:30–14:00 16:00–20:00\n星期三10:30–14:00 16:00–20:00\n星期四10:30–14:00 16:00–20:00\n星期五10:30–14:00 16:00–20:00\n星期六10:30–14:00 16:00–19:30",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/559dc761c03a103ee86ca982-烤食煮盒-永吉店"
    },
    {
      "id": "426",
      "name": "紅九九個人鴛鴦鍋-市府店",
      "address": "臺北市信義區逸仙路42巷9號",
      "lng.": "121.5623893",
      "lat.": "25.04033",
      "time":
          "星期日11:30–23:00\n星期一11:30–23:00\n星期二11:30–23:00\n星期三11:30–23:00\n星期四11:30–23:00\n星期五11:30–23:00\n星期六11:30–23:00",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b5b5f012756dd2b9fce82bf-紅九九個人鴛鴦鍋-市府店"
    },
    {
      "id": "427",
      "name": "Wildwood",
      "address": "臺北市信義區松壽路9號4樓",
      "lng.": "121.5667358",
      "lat.": "25.03611784",
      "time":
          "星期日11:30–15:00 17:30–21:30\n星期一11:30–15:00 17:30–21:30\n星期二11:30–15:00 17:30–21:30\n星期三11:30–15:00 17:30–21:30\n星期四11:30–15:00 17:30–21:30\n星期五11:30–15:00 17:30–21:00 21:30–00:30\n星期六11:30–15:00 17:30–21:00 21:30–00:30",
      "cuisine_type": "美式",
      "rating": "3.3",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5bbecfacf5246860b03c2a8d-Wildwood-Live-Fire-C"
    },
    {
      "id": "428",
      "name": "1010湘 信義誠品店",
      "address": "臺北市信義區松高路11號6樓",
      "lng.": "121.5658687",
      "lat.": "25.0397147",
      "time":
          "星期日11:00–21:30\n星期一11:00–15:00 17:00–21:30\n星期二11:00–15:00 17:00–21:30\n星期三11:00–15:00 17:00–21:30\n星期四11:00–15:00 17:00–21:30\n星期五11:00–15:00 17:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "中式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d21f8c03a103ee86c434b-1010湘"
    },
    {
      "id": "429",
      "name": "巧之味手工水餃 永吉店",
      "address": "臺北市信義區松隆路42號",
      "lng.": "121.5680204",
      "lat.": "25.04374735",
      "time":
          "星期日休息\n星期一11:30–15:00 17:00–20:30\n星期二11:30–15:00 17:00–20:30\n星期三11:30–15:00 17:00–20:30\n星期四11:30–15:00 17:00–20:30\n星期五11:30–15:00 17:00–20:30\n星期六休息",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/55a648dcc03a104df53c96b7-巧之味手工水餃"
    },
    {
      "id": "430",
      "name": "傑克兄弟牛排館臺北信義店 Jack Brothers Steakhouse Taipei",
      "address": "臺北市信義區基隆路二段7號",
      "lng.": "121.559427",
      "lat.": "25.03242718",
      "time":
          "星期日11:30–15:00 17:00–22:00\n星期一11:30–15:00 17:00–22:00\n星期二11:30–15:00 17:00–22:00\n星期三11:30–15:00 17:00–22:00\n星期四11:30–15:00 17:00–22:00\n星期五11:30–15:00 17:00–22:00\n星期六11:30–15:00 17:00–22:00",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ce015042756dd72be0d8d25-傑克兄弟牛排館-Jack-Brother"
    },
    {
      "id": "431",
      "name": "鼎泰豐 101店",
      "address": "臺北市信義區市府路45號B1",
      "lng.": "121.564455",
      "lat.": "25.03332893",
      "time":
          "星期日11:00–21:00\n星期一11:00–21:00\n星期二11:00–21:00\n星期三11:00–21:00\n星期四11:00–21:00\n星期五11:00–21:00\n星期六11:00–21:00",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d5f9ac03a103ee86c6ae1-鼎泰豐"
    },
    {
      "id": "432",
      "name": "YABI KITCHEN-微風南山店",
      "address": "臺北市信義區松智路17號2樓",
      "lng.": "121.5659555",
      "lat.": "25.03430816",
      "time":
          "星期日11:00–21:00\n星期一11:00–15:00 17:30–21:00\n星期二11:00–15:00 17:30–21:00\n星期三11:00–15:00 17:30–21:00\n星期四11:00–15:00 17:30–21:00\n星期五11:00–15:00 17:30–21:00\n星期六11:00–21:00",
      "cuisine_type": "泰式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c56f9762756dd6eccab0fd7-YABI-KITCHEN"
    },
    {
      "id": "433",
      "name": "臺北君悅酒店 Irodori 彩日本料理",
      "address": "臺北市信義區松壽路2號3樓",
      "lng.": "121.5629308",
      "lat.": "25.03521597",
      "time":
          "星期日11:30–14:00 18:00–21:00\n星期一11:30–14:00 18:00–21:00\n星期二11:30–14:00 18:00–21:00\n星期三11:30–14:00 18:00–21:00\n星期四11:30–14:00 18:00–21:00\n星期五11:30–14:00 18:00–21:00\n星期六11:30–14:00 18:00–21:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d1d3bc03a103ee86c4051-Irodori-彩日本料理-(君悅酒店)"
    },
    {
      "id": "434",
      "name": "Florian 福里安花神",
      "address": "臺北市信義區松壽路9號2樓",
      "lng.": "121.5668361",
      "lat.": "25.03711361",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "義式",
      "rating": "3.7",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/58c981fa2756dd602f4199f1-Caffé-Florian福里安花神咖啡"
    },
    {
      "id": "435",
      "name": "隨意商務酒吧 隨意吧 101-36F",
      "address": "臺北市信義區信義路五段7號",
      "lng.": "121.5648602",
      "lat.": "25.03377417",
      "time":
          "星期日10:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:00\n星期六10:00–22:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559dd8e2c03a103ee86cb3a6-101-隨意吧"
    },
    {
      "id": "436",
      "name": "純日本料理",
      "address": "臺北市信義區忠孝東路五段31巷18弄5號",
      "lng.": "121.5659115",
      "lat.": "25.04172841",
      "time":
          "星期日休息\n星期一11:30–14:30 17:30–21:30\n星期二11:30–14:30 17:30–21:30\n星期三11:30–14:30 17:30–21:30\n星期四11:30–14:30 17:30–21:30\n星期五11:30–14:30 17:30–21:30\n星期六11:30–14:30 17:30–21:30",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d7699c03a103ee86c7b55-純料理"
    },
    {
      "id": "437",
      "name": "一蘭 台灣臺北本店",
      "address": "臺北市信義區松仁路97號",
      "lng.": "121.5686597",
      "lat.": "25.03619771",
      "time":
          "星期日24小時營業\n星期一24小時營業\n星期二24小時營業\n星期三24小時營業\n星期四24小時營業\n星期五24小時營業\n星期六24小時營業",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/591f34132756dd5480ad9288-一蘭拉麵專門店"
    },
    {
      "id": "438",
      "name": "Cin Cin Osteria 請請義大利餐廳(逸仙店)",
      "address": "臺北市信義區逸仙路50巷22號",
      "lng.": "121.5627736",
      "lat.": "25.04052641",
      "time":
          "星期日11:30–16:00 17:30–21:30\n星期一11:30–16:00 17:30–21:30\n星期二11:30–16:00 17:30–21:30\n星期三11:30–16:00 17:30–21:30\n星期四11:30–16:00 17:30–21:30\n星期五11:30–16:00 17:30–21:30\n星期六11:30–16:00 17:30–21:30",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b18f0c223679c7ac305aaa8-Cin-Cin-Osteria-請請義大"
    },
    {
      "id": "439",
      "name": "臺北君悅酒店 Bel Air 寶艾西餐廳",
      "address": "臺北市信義區松壽路2號2樓",
      "lng.": "121.5620787",
      "lat.": "25.03557807",
      "time":
          "星期日11:30–14:00 18:00–21:00\n星期一11:30–14:00 18:00–21:00\n星期二11:30–14:00 18:00–21:00\n星期三11:30–14:00 18:00–21:00\n星期四11:30–14:00 18:00–21:00\n星期五11:30–14:00 18:00–21:30\n星期六11:30–14:00 18:00–21:30",
      "cuisine_type": "美式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/56213e852756dd74717faf21-寶艾西餐廳-(君悅酒店)"
    },
    {
      "id": "440",
      "name": "金子半之助 新光A8店",
      "address": "臺北市信義區松高路12號B2",
      "lng.": "121.566886",
      "lat.": "25.03881404",
      "time":
          "星期日11:00–22:00\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–21:30\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/599b211c2756dd27fa68e71b-金子半之助-新光三越A8"
    },
    {
      "id": "441",
      "name": "1010湘食堂遠百信義店",
      "address": "臺北市信義區松仁路58號4樓",
      "lng.": "121.5680283",
      "lat.": "25.03689316",
      "time":
          "星期日11:00–23:00\n星期一11:00–15:00 16:00–23:00\n星期二11:00–15:00 16:00–23:00\n星期三11:00–15:00 16:00–23:00\n星期四11:00–15:00 16:00–23:00\n星期五11:00–15:00 16:00–23:00\n星期六11:00–23:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e0370672756dd5695e01c67-1010湘食堂-遠百信義店"
    },
    {
      "id": "442",
      "name": "甘牌燒味 台灣 Kam's Roast Taiwan",
      "address": "臺北市信義區市府路45號B1",
      "lng.": "121.5649974",
      "lat.": "25.03430363",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "港式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c0dd3ef23679c1aa236e656-甘牌燒味-台灣-Kam's-Roast-"
    },
    {
      "id": "443",
      "name": "Café&Meal MUJI 統一時代店",
      "address": "臺北市信義區忠孝東路五段8號B2",
      "lng.": "121.5656316",
      "lat.": "25.04056481",
      "time":
          "星期日11:00–22:00\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d6419c03a103ee86c6e10-MUJI-Café%26Meal"
    },
    {
      "id": "444",
      "name": "L.A PHO越南河粉",
      "address": "臺北市信義區松壽路30號",
      "lng.": "121.5681034",
      "lat.": "25.035572",
      "time":
          "星期日11:30–21:30\n星期一11:00–21:30\n星期二11:30–21:30\n星期三11:30–21:30\n星期四11:30–21:30\n星期五11:30–21:30\n星期六11:30–21:30",
      "cuisine_type": "東南亞",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a63851c2756dd60a521d433-L.A-PHO越南河粉"
    },
    {
      "id": "445",
      "name": "Hooters美式餐廳 信義店",
      "address": "臺北市信義區松仁路58號14樓",
      "lng.": "121.5681305",
      "lat.": "25.03671701",
      "time":
          "星期日11:00–02:00\n星期一11:00–02:00\n星期二11:00–02:00\n星期三11:00–02:00\n星期四11:00–02:00\n星期五11:00–02:00\n星期六11:00–02:00",
      "cuisine_type": "美式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e096c9522613931aa8b3228-Hooters-信義A13"
    },
    {
      "id": "446",
      "name": "一直是晴天 松菸店",
      "address": "臺北市信義區忠孝東路四段553巷2弄5號",
      "lng.": "121.5630812",
      "lat.": "25.04199827",
      "time":
          "星期日11:30–21:00\n星期一11:30–21:00\n星期二休息\n星期三11:30–21:00\n星期四11:30–21:00\n星期五11:30–21:00\n星期六11:30–21:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d3eb3c03a103ee86c568a-臺北一直是晴天"
    },
    {
      "id": "447",
      "name": "銀兔湯咖哩",
      "address": "臺北市信義區忠孝東路四段553巷10號",
      "lng.": "121.5628282",
      "lat.": "25.04244342",
      "time":
          "星期日11:30–15:00 17:30–21:00\n星期一11:30–15:00 17:30–21:00\n星期二11:30–15:00 17:30–21:00\n星期三11:30–15:00 17:30–21:00\n星期四11:30–15:00 17:30–21:00\n星期五11:30–15:00 17:30–21:00\n星期六11:30–15:00 17:30–21:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5bdbec80f52468101621620e-銀兔湯咖哩"
    },
    {
      "id": "448",
      "name": "月月THAI BBQ - 遠百信義店",
      "address": "臺北市信義區松仁路58號14樓",
      "lng.": "121.5681199",
      "lat.": "25.03684246",
      "time":
          "星期日11:00–22:00\n星期一11:00–15:00 17:00–22:00\n星期二11:00–15:00 17:00–22:00\n星期三11:00–15:00 17:00–22:00\n星期四11:00–15:00 17:00–22:00\n星期五11:00–15:00 17:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "泰式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5e0d56d9d6895d4b37069e1e-月月THAI-BBQ-遠百信義店"
    },
    {
      "id": "449",
      "name": "滿堂紅頂級麻辣鴛鴦鍋 臺北BELLAVITA店",
      "address": "臺北市信義區松仁路28號B2",
      "lng.": "121.5676426",
      "lat.": "25.03961919",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:30\n星期六11:00–22:30",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c39427a226139664e3e1ae2-滿堂紅-信義BELLAVITA店"
    },
    {
      "id": "450",
      "name": "不糾結 清粥小菜",
      "address": "臺北市信義區松壽路12號6樓",
      "lng.": "121.5660648",
      "lat.": "25.03530576",
      "time":
          "星期日11:00–01:00\n星期一11:00–01:00\n星期二11:00–01:00\n星期三11:00–01:00\n星期四11:00–01:00\n星期五11:00–03:00\n星期六11:00–03:00",
      "cuisine_type": "台式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5f6024048c906d0483236c55-不糾結-清粥小菜"
    },
    {
      "id": "451",
      "name": "小器食堂微風南山atre店",
      "address": "臺北市信義區松智路17號3樓",
      "lng.": "121.565983",
      "lat.": "25.03425134",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d072283d6895d5b9e62dc8b-小器食堂-微風南山atre店"
    },
    {
      "id": "452",
      "name": "MUCHOYAKI",
      "address": "臺北市信義區松壽路9號6樓",
      "lng.": "121.5667001",
      "lat.": "25.03667144",
      "time":
          "星期日12:00–15:00 17:30–22:00\n星期一12:00–15:00 18:00–22:00\n星期二12:00–15:00 18:00–22:00\n星期三12:00–15:00 18:00–22:00\n星期四12:00–15:00 18:00–22:00\n星期五12:00–15:00 18:00–22:00\n星期六12:00–15:00 17:30–22:00",
      "cuisine_type": "美式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/5c61853f2756dd0517f67056-MUCHOYAKI"
    },
    {
      "id": "453",
      "name": "光合箱子 信義店",
      "address": "臺北市信義區松高路11號6樓",
      "lng.": "121.5658704",
      "lat.": "25.03971773",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–21:30\n星期六11:00–21:30",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b8612e123679c2937d652fd-Daylight光合箱子-信義店"
    },
    {
      "id": "454",
      "name": "しゃぶしゃぶ温野菜日本涮涮鍋專門店 誠品信義店",
      "address": "臺北市信義區松高路11號4樓",
      "lng.": "121.5658766",
      "lat.": "25.03971727",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–23:00\n星期六11:00–23:00",
      "cuisine_type": "日式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/56558ad72756dd1d7a1af771-溫野菜-誠品信義店"
    },
    {
      "id": "455",
      "name": "偷飯賊 遠百信義A13店",
      "address": "臺北市信義區松仁路58號4樓",
      "lng.": "121.5681399",
      "lat.": "25.03672097",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–21:30\n星期六11:00–21:30",
      "cuisine_type": "韓式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f809f308c906d783bd6c92c-偷飯賊-遠百信義A13店"
    },
    {
      "id": "456",
      "name": "WIRED TOKYO 信義店",
      "address": "臺北市信義區忠孝東路五段8號5樓",
      "lng.": "121.5656423",
      "lat.": "25.04056026",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/588983332756dd6d8d2277f3-WIRED-TOKYO-Taiwan-信"
    },
    {
      "id": "457",
      "name": "酒樂CAFÉ",
      "address": "臺北市信義區松壽路18號",
      "lng.": "121.5668099",
      "lat.": "25.03568326",
      "time":
          "星期日12:00–02:30\n星期一12:00–02:30\n星期二12:00–02:30\n星期三12:00–02:30\n星期四12:00–02:30\n星期五12:00–02:30\n星期六12:00–02:30",
      "cuisine_type": "日式",
      "rating": "3.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559dc0d2c03a103ee86ca545-酒樂CAFE'"
    },
    {
      "id": "458",
      "name": "大河屋 燒肉丼 串燒-微風南山店",
      "address": "臺北市信義區松智路17號5樓",
      "lng.": "121.5659667",
      "lat.": "25.03431225",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5c53b23023679c6f95663000-大河屋燒肉丼串燒"
    },
    {
      "id": "459",
      "name": "汰汰熱情酒場-巿府店",
      "address": "臺北市信義區基隆路一段147巷5弄7號",
      "lng.": "121.5660792",
      "lat.": "25.04277593",
      "time":
          "星期日17:30–01:00\n星期一17:30–01:00\n星期二17:30–01:00\n星期三17:30–01:00\n星期四17:30–01:00\n星期五17:30–01:00\n星期六17:30–01:00",
      "cuisine_type": "泰式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5ed7728f2261397257131132-汰汰熱情酒場-巿府店"
    },
    {
      "id": "460",
      "name": "涓豆腐 ATT信義店",
      "address": "臺北市信義區松壽路12號5樓",
      "lng.": "121.5660772",
      "lat.": "25.03529054",
      "time":
          "星期日11:00–22:00\n星期一11:00–14:30 17:00–22:00\n星期二11:00–14:30 17:00–22:00\n星期三11:00–14:30 17:00–22:00\n星期四11:00–14:30 17:00–22:00\n星期五11:00–14:30 17:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "韓式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a0498572756dd72f428ddb6-涓豆腐-ATT信義店"
    },
    {
      "id": "461",
      "name": "Marsalis Home Taipei",
      "address": "臺北市信義區松仁路90號3樓",
      "lng.": "121.5679891",
      "lat.": "25.03510191",
      "time":
          "星期日19:00–02:00\n星期一19:00–02:00\n星期二19:00–02:00\n星期三19:00–02:00\n星期四19:00–02:00\n星期五19:00–03:00\n星期六19:00–03:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5906a1b4699b6e0df7256ab8-Marsalis-Home-Taipei"
    },
    {
      "id": "462",
      "name": "心潮飯店 Sinchao Rice Shoppe",
      "address": "臺北市信義區忠孝東路五段68號2樓",
      "lng.": "121.5669011",
      "lat.": "25.04049985",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e3d729e2756dd6fdd794ecc-心潮飯店-Sinchao-Rice-Sh"
    },
    {
      "id": "463",
      "name": "恆之茶居 HANG'S CAFÉ",
      "address": "臺北市信義區菸廠路88號B2 R001",
      "lng.": "121.5614565",
      "lat.": "25.04456531",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "港式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5d661dbb8c906d23d8a5f722-恆之茶居"
    },
    {
      "id": "464",
      "name": "大心新泰式麵食 - 臺北統一時代店",
      "address": "臺北市信義區忠孝東路五段8號B2​",
      "lng.": "121.5656066",
      "lat.": "25.04054507",
      "time":
          "星期日11:00–21:00\n星期一11:00–21:00\n星期二11:00–21:00\n星期三11:00–21:00\n星期四11:00–21:00\n星期五11:00–21:30\n星期六11:00–21:30",
      "cuisine_type": "泰式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d647cc03a103ee86c6efd-大心新泰式麵食"
    },
    {
      "id": "465",
      "name": "HIVE 巢 • 餐廳",
      "address": "臺北市信義區逸仙路42巷19號",
      "lng.": "121.5629569",
      "lat.": "25.04027545",
      "time":
          "星期日10:30–15:00 17:00–21:00\n星期一11:30–15:00 17:00–21:00\n星期二休息\n星期三10:45–15:00 17:00–21:00\n星期四10:45–15:00 17:00–21:00\n星期五10:45–15:00 17:00–21:00\n星期六10:30–15:00 17:00–21:00",
      "cuisine_type": "美式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b82b8482756dd1922cf1685-HIVE-巢-•-餐廳"
    },
    {
      "id": "466",
      "name": "雲鼎阿二麻辣食堂永吉店",
      "address": "臺北市信義區永吉路30巷87號",
      "lng.": "121.5688595",
      "lat.": "25.0438697",
      "time":
          "星期日12:00–22:30\n星期一12:00–22:30\n星期二12:00–22:30\n星期三12:00–22:30\n星期四12:00–22:30\n星期五12:00–22:30\n星期六12:00–22:30",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5a146bba2756dd04083061fe-阿二麻辣食堂永吉店"
    },
    {
      "id": "467",
      "name": "紫艷中餐廳",
      "address": "臺北市信義區忠孝東路五段10號31樓",
      "lng.": "121.5657355",
      "lat.": "25.0405952",
      "time":
          "星期日11:30–14:30 18:00–22:00\n星期一11:30–14:30 18:00–22:00\n星期二11:30–14:30 18:00–22:00\n星期三11:30–14:30 18:00–22:00\n星期四11:30–14:30 18:00–22:00\n星期五11:30–14:30 18:00–22:00\n星期六11:30–14:30 18:00–22:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d6a5fc03a103ee86c7308-紫豔-中餐廳%2F酒吧-(W-Hotel)"
    },
    {
      "id": "468",
      "name": "夜上海 Ye Shanghai Taipei",
      "address": "臺北市信義區松高路19號5樓",
      "lng.": "121.5664846",
      "lat.": "25.03969042",
      "time":
          "星期日11:30–14:30 18:00–22:00\n星期一11:30–14:30 18:00–22:00\n星期二11:30–14:30 18:00–22:00\n星期三11:30–14:30 18:00–22:00\n星期四11:30–14:30 18:00–22:00\n星期五11:30–14:30 18:00–22:00\n星期六11:30–14:30 18:00–22:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559dae6ec03a103ee86c9a58-夜上海"
    },
    {
      "id": "469",
      "name": "大心新泰式面食 - 臺北信義威秀店",
      "address": "臺北市信義區松壽路20號",
      "lng.": "121.5674182",
      "lat.": "25.03515199",
      "time":
          "星期日11:00–22:30\n星期一11:00–22:30\n星期二11:00–22:30\n星期三11:00–22:30\n星期四11:00–22:30\n星期五11:00–23:00\n星期六11:00–23:00",
      "cuisine_type": "泰式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dd9ccc03a103ee86cb471-大心新泰式麵食-(信義威秀)"
    },
    {
      "id": "470",
      "name": "非常泰",
      "address": "臺北市信義區松壽路22號",
      "lng.": "121.5678654",
      "lat.": "25.03549581",
      "time":
          "星期日11:00–22:00\n星期一11:00–15:00 17:00–22:00\n星期二11:00–15:00 17:00–22:00\n星期三11:00–15:00 17:00–22:00\n星期四11:00–15:00 17:00–22:00\n星期五11:00–15:00 17:00–22:30\n星期六11:00–22:30",
      "cuisine_type": "泰式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559ddd9dc03a103ee86cb6ff-非常泰"
    },
    {
      "id": "471",
      "name": "九州鬆餅Cafe - 臺北微風南山艾妥列店",
      "address": "臺北市信義區松智路17號3樓",
      "lng.": "121.5667586",
      "lat.": "25.03445598",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5efc9c7b2756dd06c21e601c-九州鬆餅Cafe-臺北微風南山艾妥列店"
    },
    {
      "id": "472",
      "name": "象廚泰式料理",
      "address": "臺北市信義區基隆路一段147巷9號",
      "lng.": "121.5662262",
      "lat.": "25.04251991",
      "time":
          "星期日11:30–13:30 17:30–20:30\n星期一11:30–13:30 17:30–20:30\n星期二11:30–13:30 17:30–20:30\n星期三11:30–13:30 17:30–20:30\n星期四11:30–13:30 17:30–20:30\n星期五11:30–13:30 17:30–20:30\n星期六11:30–13:30 17:30–20:30",
      "cuisine_type": "泰式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/58c048152756dd732689b5e5-象廚泰式料理"
    },
    {
      "id": "473",
      "name": "瓦城泰國料理 - 臺北三越信義店",
      "address": "臺北市信義區松壽路9號7樓",
      "lng.": "121.5667361",
      "lat.": "25.03623508",
      "time":
          "星期日11:00–21:30\n星期一11:00–15:00 17:00–21:30\n星期二11:00–15:00 17:00–21:30\n星期三11:00–15:00 17:00–21:30\n星期四11:00–15:00 17:00–21:30\n星期五11:00–15:00 17:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "泰式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559dabb2c03a103ee86c9892-瓦城泰國料理"
    },
    {
      "id": "474",
      "name": "UMAMI 金色三麥",
      "address": "臺北市信義區松智路17號7樓",
      "lng.": "121.5659603",
      "lat.": "25.0343052",
      "time":
          "星期日11:00–23:00\n星期一11:00–23:00\n星期二11:00–23:00\n星期三11:00–23:00\n星期四11:00–23:00\n星期五11:00–00:00\n星期六11:00–00:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5cd26f0c23679c1bbc69f6e3-UMAMI-金色三麥"
    },
    {
      "id": "475",
      "name": "Due Italian",
      "address": "臺北市信義區松高路19號B2",
      "lng.": "121.5665906",
      "lat.": "25.03965656",
      "time":
          "星期日10:30–21:30\n星期一10:30–21:30\n星期二10:30–21:30\n星期三10:30–21:30\n星期四10:30–21:30\n星期五10:30–22:00\n星期六10:30–22:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ac34fc923679c3828d3656d-Due-Italian"
    },
    {
      "id": "476",
      "name": "王鍋屋 - 酸白菜鍋專門店 Shabu Ong",
      "address": "臺北市信義區逸仙路50巷20號1樓",
      "lng.": "121.5626333",
      "lat.": "25.04042906",
      "time":
          "星期日11:30–22:30\n星期一11:30–15:00 17:30–22:30\n星期二11:30–15:00 17:30–22:30\n星期三11:30–15:00 17:30–22:30\n星期四11:30–15:00 17:30–22:30\n星期五11:30–15:00 17:30–22:30\n星期六11:30–22:30",
      "cuisine_type": "中式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bdb0c3d2756dd2e2402414a-王鍋屋-Shabu-Ong-酸白菜鍋專門"
    },
    {
      "id": "477",
      "name": "PACKIE銀杏川酒菜館",
      "address": "臺北市信義區松壽路9號6樓",
      "lng.": "121.5667018",
      "lat.": "25.03666089",
      "time":
          "星期日11:00–15:00 17:00–22:00\n星期一11:00–15:00 17:00–22:00\n星期二11:00–15:00 17:00–22:00\n星期三11:00–15:00 17:00–22:00\n星期四11:00–15:00 17:00–22:00\n星期五11:00–15:00 17:00–22:00\n星期六11:00–15:00 17:00–22:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5beadce623679c3099c7f14e-PACKIE銀杏川酒菜館"
    },
    {
      "id": "478",
      "name": "馬辣頂級麻辣鴛鴦火鍋-信義店",
      "address": "臺北市信義區松壽路22號3樓",
      "lng.": "121.5678588",
      "lat.": "25.03549994",
      "time":
          "星期日11:30–02:00\n星期一11:30–02:00\n星期二11:30–02:00\n星期三11:30–02:00\n星期四11:30–02:00\n星期五11:30–02:00\n星期六11:30–02:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559ddd8ac03a103ee86cb6c8-馬辣頂級麻辣鴛鴦火鍋-信義店"
    },
    {
      "id": "479",
      "name": "I’m Kimchi Att4fun 信義店",
      "address": "臺北市信義區松壽路12號5樓",
      "lng.": "121.5660632",
      "lat.": "25.03531102",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–23:00\n星期六11:00–23:00",
      "cuisine_type": "韓式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b86125ff5246829c83fed51-I’m-kimchi"
    },
    {
      "id": "480",
      "name": "Curry For PEACE",
      "address": "臺北市信義區光復南路519巷7號",
      "lng.": "121.5580074",
      "lat.": "25.03194699",
      "time":
          "星期日12:30–20:00\n星期一11:00–20:00\n星期二11:00–20:00\n星期三11:00–20:00\n星期四11:00–20:00\n星期五11:00–20:30\n星期六12:30–20:30",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ad216dff524684b9b2c5a28-Curry-For-PEACE"
    },
    {
      "id": "481",
      "name": "燒丼株式會社",
      "address": "臺北市信義區松壽路20號2樓",
      "lng.": "121.5670865",
      "lat.": "25.03514945",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559dd9cfc03a103ee86cb476-燒丼株式會社"
    },
    {
      "id": "482",
      "name": "裕珍馨",
      "address": "臺北市信義區信義路五段7號B1",
      "lng.": "121.5642764",
      "lat.": "25.03374375",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5d4cee1c2261395738c1fcc1-裕珍馨"
    },
    {
      "id": "483",
      "name": "添好運 (新光三越A8)",
      "address": "臺北市信義區松高路12號B2",
      "lng.": "121.5668361",
      "lat.": "25.03873198",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "中式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d5369c03a103ee86c63cd-添好運"
    },
    {
      "id": "484",
      "name": "段純貞-信義威秀店",
      "address": "臺北市信義區松壽路20號2樓",
      "lng.": "121.567421",
      "lat.": "25.03490405",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "中式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/570f18032756dd2eac7b5524-段純貞牛肉麵"
    },
    {
      "id": "485",
      "name": "烤師傅烤肉飯",
      "address": "臺北市信義區永吉路30巷151弄2-1號",
      "lng.": "121.5688072",
      "lat.": "25.04252633",
      "time":
          "星期日11:00–14:30 17:00–21:00\n星期一11:00–14:30 17:00–21:00\n星期二11:00–14:30 17:00–21:00\n星期三11:00–14:30 17:00–21:00\n星期四11:00–14:30 17:00–21:00\n星期五11:00–14:30 17:00–21:00\n星期六11:00–14:30 17:00–21:00",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/559d2880c03a103ee86c474c-烤師傅"
    },
    {
      "id": "486",
      "name": "臺北君悅酒店 ZIGA ZAGA",
      "address": "臺北市信義區松壽路2號",
      "lng.": "121.5631371",
      "lat.": "25.0353303",
      "time":
          "星期日11:30–14:00 18:00–21:00\n星期一休息\n星期二11:30–14:00 18:00–21:00\n星期三11:30–14:00 18:00–21:00\n星期四11:30–14:00 18:00–21:00\n星期五11:30–14:00 18:00–21:30\n星期六11:30–14:00 18:00–21:30",
      "cuisine_type": "義式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d1d42c03a103ee86c4060-ZIGA-ZAGA-(君悅酒店)"
    },
    {
      "id": "487",
      "name": "臺北鳥喜 produced by Toriki とり喜",
      "address": "臺北市信義區松壽路26號",
      "lng.": "121.5677456",
      "lat.": "25.03534692",
      "time":
          "星期日12:30–14:30 18:00–22:30\n星期一12:30–14:30 18:00–22:30\n星期二12:30–14:30 18:00–22:30\n星期三12:30–14:30 18:00–22:30\n星期四12:30–14:30 18:00–22:30\n星期五12:30–14:30 18:00–22:30\n星期六12:30–14:30 18:00–22:30",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/58fe3ea12756dd27438b50f1-臺北鳥喜-produced-by-Tor"
    },
    {
      "id": "488",
      "name": "石膳日本料理",
      "address": "臺北市信義區基隆路一段428號",
      "lng.": "121.5597589",
      "lat.": "25.03381739",
      "time":
          "星期日11:30–21:30\n星期一11:30–21:30\n星期二11:30–21:30\n星期三11:30–21:30\n星期四11:30–21:30\n星期五11:30–21:30\n星期六11:30–21:30",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/55a57e97c03a10241de66b2b-石膳日本料理"
    },
    {
      "id": "489",
      "name": "焦糖楓串燒漢方無烟撒粉 永吉直營店",
      "address": "臺北市信義區永吉路30巷122號",
      "lng.": "121.5686893",
      "lat.": "25.04295973",
      "time":
          "星期日15:30–00:30\n星期一16:30–00:30\n星期二16:30–00:30\n星期三16:30–00:30\n星期四16:30–00:30\n星期五15:30–00:30\n星期六15:30–00:30",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/56d72ccd2756dd2ab04a2184-焦糖楓(永吉店)"
    },
    {
      "id": "490",
      "name": "赤門居酒屋",
      "address": "臺北市信義區松隆路8號",
      "lng.": "121.566535",
      "lat.": "25.04316755",
      "time":
          "星期日18:00–00:00\n星期一18:00–00:00\n星期二18:00–00:00\n星期三18:00–00:00\n星期四18:00–00:00\n星期五18:00–00:00\n星期六18:00–00:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/55a534b6c03a10241de6519c-赤門居酒屋"
    },
    {
      "id": "491",
      "name": "福昌羊肉 臺北信義店",
      "address": "臺北市信義區松隆路62號",
      "lng.": "121.5684376",
      "lat.": "25.04402745",
      "time":
          "星期日17:30–02:00\n星期一休息\n星期二17:30–02:00\n星期三17:30–02:00\n星期四17:30–02:00\n星期五17:30–02:00星期六17:30–02:00",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5dcff36922613918e769679a-福昌羊肉-臺北信義店"
    },
    {
      "id": "492",
      "name": "欣葉台菜 信義新天地A9",
      "address": "臺北市信義區松壽路9號8樓",
      "lng.": "121.5667022",
      "lat.": "25.03665592",
      "time":
          "星期日11:00–15:00 17:00–21:30\n星期一11:00–15:00 17:00–21:30\n星期二11:00–15:00 17:00–21:30\n星期三11:00–15:00 17:00–21:30\n星期四11:00–15:00 17:00–21:30\n星期五11:00–15:00 17:00–21:30\n星期六11:00–15:00 17:00–21:30",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559daba7c03a103ee86c9873-欣葉台菜"
    },
    {
      "id": "493",
      "name": "The Ukai Taipei",
      "address": "臺北市信義區松智路17號46樓",
      "lng.": "121.5672494",
      "lat.": "25.03413365",
      "time":
          "星期日12:00–15:00 18:00–22:00\n星期一12:00–15:00 18:00–22:00\n星期二12:00–15:00 18:00–22:00\n星期三12:00–15:00 18:00–22:00\n星期四12:00–15:00 18:00–22:00\n星期五12:00–15:00 18:00–22:00\n星期六12:00–15:00 18:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/5c5e4efc2261396c2a0a3ea4-THE-UKAI-TAIPEI"
    },
    {
      "id": "494",
      "name": "香茅廚泰式餐廳新光A4店",
      "address": "臺北市信義區松高路19號6樓",
      "lng.": "121.5664731",
      "lat.": "25.03968855",
      "time":
          "星期日11:30–15:30 17:30–21:30\n星期一11:30–14:30 17:30–21:30\n星期二11:30–14:30 17:30–21:30\n星期三11:30–14:30 17:30–21:30\n星期四11:30–14:30 17:30–21:30\n星期五11:30–14:30 17:30–22:00\n星期六11:30–15:30 17:30–22:00",
      "cuisine_type": "泰式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5add3f2122613955ab378557-香茅廚泰式餐廳-新光A4店"
    },
    {
      "id": "495",
      "name": "毅壽司",
      "address": "臺北市信義區永吉路30巷101弄8號",
      "lng.": "121.5692076",
      "lat.": "25.04342679",
      "time":
          "星期日11:30–14:00 17:00–21:00\n星期一休息\n星期二11:30–14:00 17:00–21:00\n星期三11:30–14:00 17:00–21:00\n星期四11:30–14:00 17:00–21:00\n星期五11:30–14:00 17:00–21:00\n星期六11:30–14:00 17:00–21:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/55a5efdcc03a102ec14158fa-毅壽司"
    },
    {
      "id": "496",
      "name": "HUHA 創意粥品",
      "address": "臺北市信義區基隆路一段380巷1號",
      "lng.": "121.5600505",
      "lat.": "25.03454368",
      "time":
          "星期日11:30–20:00\n星期一11:30–20:00\n星期二11:30–20:00\n星期三11:30–20:00\n星期四11:30–20:00\n星期五11:30–20:00\n星期六11:30–20:00",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5c278dda226139449a3d62c8-HUHA-創意粥品"
    },
    {
      "id": "497",
      "name": "大師兄銷魂麵舖-信義店",
      "address": "臺北市信義區松壽路11號",
      "lng.": "121.5672544",
      "lat.": "25.03665176",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5bfab0a1f524680b126f018a-大師兄銷魂麵舖"
    },
    {
      "id": "498",
      "name": "BANCO棒可 窯烤PIZZA . 自製生麵 世貿店",
      "address": "臺北市信義區基隆路二段13-1號1樓",
      "lng.": "121.5593567",
      "lat.": "25.03234956",
      "time":
          "星期日12:00–15:30 17:00–21:30\n星期一12:00–15:30 17:00–21:30\n星期二12:00–15:30 17:00–21:30\n星期三12:00–15:30 17:00–21:30\n星期四12:00–15:30 17:00–21:30\n星期五12:00–15:30 17:00–21:30\n星期六12:00–15:30 17:00–21:30",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5d0a44cd2756dd5d7b91ebc3-BANCO-世貿店"
    },
    {
      "id": "499",
      "name": "逸鮮棧",
      "address": "臺北市信義區忠孝東路四段500之3號",
      "lng.": "121.5619767",
      "lat.": "25.04070357",
      "time":
          "星期日11:30–14:30 17:30–22:00\n星期一11:30–14:30 17:30–22:00\n星期二11:30–14:30 17:30–22:00\n星期三11:30–14:30 17:30–22:00\n星期四11:30–14:30 17:30–22:00\n星期五11:30–14:30 17:30–22:00\n星期六11:30–14:30 17:30–22:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559d9f73c03a103ee86c91c1-逸鮮棧"
    },
    {
      "id": "500",
      "name": "BaganHood 蔬食餐酒館",
      "address": "臺北市信義區忠孝東路四段553巷46弄11號",
      "lng.": "121.5634681",
      "lat.": "25.04432918",
      "time":
          "星期日11:30–16:00 17:00–22:00\n星期一11:30–16:00 17:00–22:00\n星期二11:30–16:00 17:00–22:00\n星期三11:30–16:00 17:00–22:00\n星期四11:30–16:00 17:00–22:00\n星期五11:30–16:00 17:00–22:00\n星期六11:30–16:00 17:00–22:00",
      "cuisine_type": "美式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5eaadf152756dd71246ecde5-BaganHood-蔬食餐酒館"
    },
    {
      "id": "501",
      "name": "肉伯火雞肉飯",
      "address": "臺北市信義區信義路四段405號",
      "lng.": "121.5588123",
      "lat.": "25.03329183",
      "time":
          "星期日11:00–15:00 17:00–20:30\n星期一11:00–15:00 17:00–20:30\n星期二11:00–15:00 17:00–20:30\n星期三11:00–15:00 17:00–20:30\n星期四11:00–15:00 17:00–20:30\n星期五11:00–15:00 17:00–20:30\n星期六11:00–15:00 17:00–20:30",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5651ccf4699b6e6f58dc8e39-肉伯火雞肉飯"
    },
    {
      "id": "502",
      "name": "大灣碼頭-松隆店",
      "address": "臺北市信義區松隆路1號",
      "lng.": "121.5663653",
      "lat.": "25.04356208",
      "time":
          "星期日11:00–14:00 17:00–02:00\n星期一11:00–14:00 17:00–02:00\n星期二11:00–14:00 17:00–02:00\n星期三11:00–14:00 17:00–02:00\n星期四11:00–14:00 17:00–02:00\n星期五11:00–14:00 17:00–02:00\n星期六11:00–14:00 17:00–02:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/561ea6c32756dd74727fbc9f-大灣碼頭-松隆店"
    },
    {
      "id": "503",
      "name": "安吉食堂",
      "address": "臺北市信義區松信路219號1樓",
      "lng.": "121.5720805",
      "lat.": "25.04150852",
      "time":
          "星期日11:30–14:00 17:30–21:00\n星期一11:30–14:00 17:30–21:00\n星期二休息\n星期三11:30–14:00 17:30–21:00\n星期四11:30–14:00 17:30–21:00\n星期五11:30–14:00 17:30–21:00\n星期六11:30–14:00 17:30–21:00",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5d1062b22261394b43e1bea0-安吉食堂"
    },
    {
      "id": "504",
      "name": "Beef King 信義旗艦店",
      "address": "臺北市信義區松壽路12號10樓之2",
      "lng.": "121.5659555",
      "lat.": "25.0353285",
      "time":
          "星期日11:30–22:00\n星期一11:30–22:00\n星期二11:30–22:00\n星期三11:30–22:00\n星期四11:30–22:00\n星期五11:30–23:00\n星期六11:30–23:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/5cac20d922613924a74c8d39-Beef-King-信義旗艦店"
    },
    {
      "id": "505",
      "name": "蔬漫小姐Miss Shu maan. House",
      "address": "臺北市信義區永吉路120巷82號1樓",
      "lng.": "121.5700997",
      "lat.": "25.04258693",
      "time":
          "星期日11:30–15:00 17:30–21:00\n星期一11:30–15:00 17:30–21:00\n星期二11:30–15:00 17:30–21:00\n星期三11:30–15:00 17:30–21:00\n星期四11:30–15:00 17:30–21:00\n星期五11:30–15:00 17:30–21:00\n星期六11:30–15:00 17:30–21:00",
      "cuisine_type": "義式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/55a5e77fc03a102ec1415651-蔬漫小姐"
    },
    {
      "id": "506",
      "name": "滇味廚房",
      "address": "臺北市信義區永吉路30巷178弄2號",
      "lng.": "121.5686185",
      "lat.": "25.04147946",
      "time":
          "星期日11:00–21:00\n星期一11:00–14:30 17:00–21:00\n星期二11:00–14:30 17:00–21:00\n星期三休息\n星期四11:00–14:30 17:00–21:00\n星期五11:00–14:30 17:00–21:00\n星期六11:00–21:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/559dd8aec03a103ee86cb398-滇味廚房"
    },
    {
      "id": "507",
      "name": "黃亞細肉骨茶 臺北三越信義店",
      "address": "臺北市信義區松高路12號3樓",
      "lng.": "121.5668368",
      "lat.": "25.03771913",
      "time":
          "星期日11:00–22:00\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "東南亞",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5b5b5e4e2756dd2b9fce82a8-黃亞細肉骨茶"
    },
    {
      "id": "508",
      "name": "寬巷子鍋品美食 微風信義店",
      "address": "臺北市信義區忠孝東路五段68號4樓",
      "lng.": "121.5670225",
      "lat.": "25.04058466",
      "time":
          "星期日11:30–15:00 17:30–21:30\n星期一11:30–15:00 17:30–21:30\n星期二11:30–15:00 17:30–21:30\n星期三11:30–15:00 17:30–21:30\n星期四11:30–14:30 17:30–22:00\n星期五11:30–14:30 17:30–22:00\n星期六11:30–14:30 17:30–22:00",
      "cuisine_type": "中式",
      "rating": "4.7",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/569dafe52756dd6c777d94a9-寬巷子鍋品"
    },
    {
      "id": "509",
      "name": "平城苑 東京燒肉 微風信義店",
      "address": "臺北市信義區忠孝東路五段68號4樓",
      "lng.": "121.5668857",
      "lat.": "25.04052382",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "3.9",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/5af90e172261391f43ad49e7-平城苑燒肉"
    },
    {
      "id": "510",
      "name": "厲家菜 宮廷御膳料理",
      "address": "臺北市信義區松仁路28號3樓",
      "lng.": "121.5676926",
      "lat.": "25.03965582",
      "time":
          "星期日11:30–14:30 18:00–22:00\n星期一11:30–14:30 18:00–22:00\n星期二11:30–14:30 18:00–22:00\n星期三11:30–14:30 18:00–22:00\n星期四11:30–14:30 18:00–22:00\n星期五11:30–14:30 18:00–22:30\n星期六11:30–14:30 18:00–22:30",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info": "https://ifoodie.tw/restaurant/559dba6ec03a103ee86ca018-厲家菜"
    },
    {
      "id": "511",
      "name": "時時香 RICE BAR - 微風南山店",
      "address": "臺北市信義區松智路17號6樓",
      "lng.": "121.5661172",
      "lat.": "25.0345666",
      "time":
          "星期日11:00–21:00\n星期一11:00–15:00 17:00–21:30\n星期二11:00–15:00 17:00–21:30\n星期三11:00–15:00 17:00–21:30\n星期四11:00–15:00 17:00–22:00\n星期五11:00–15:00 17:00–22:00\n星期六11:00–21:00",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c37602423679c424e928883-時時香RICE-BAR"
    },
    {
      "id": "512",
      "name": "雞湯大叔 信義店",
      "address": "臺北市信義區松高路11號5樓",
      "lng.": "121.5658651",
      "lat.": "25.03971447",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5ee6e87e8c906d18c6891d5d-雞湯大叔-信義店"
    },
    {
      "id": "513",
      "name": "MAiSEN 邁泉豬排信義新光 A9",
      "address": "臺北市信義區松壽路9號6樓",
      "lng.": "121.5665823",
      "lat.": "25.03608173",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/580a59232756dd0bfe2980e9-邁泉豬排-とんかつまい泉"
    },
    {
      "id": "514",
      "name": "花月嵐 信義威秀店",
      "address": "臺北市信義區松壽路20號2樓",
      "lng.": "121.5670983",
      "lat.": "25.03560944",
      "time":
          "星期日10:30–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六10:30–23:00",
      "cuisine_type": "日式",
      "rating": "3.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559dd9c4c03a103ee86cb460-花月嵐拉麵"
    },
    {
      "id": "515",
      "name": "了凡油雞 臺北101店",
      "address": "臺北市信義區市府路45號B1",
      "lng.": "121.5641013",
      "lat.": "25.0334842",
      "time":
          "星期日10:30–21:30\n星期一10:30–21:30\n星期二10:30–21:30\n星期三10:30–21:30\n星期四10:30–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "東南亞",
      "rating": "3.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c62d9bc23679c0a266d9096-了凡油雞-臺北101店"
    },
    {
      "id": "516",
      "name": "乾杯 信義 ATT店",
      "address": "臺北市信義區松壽路12號3樓",
      "lng.": "121.5660699",
      "lat.": "25.03565968",
      "time":
          "星期日11:00–00:00\n星期一11:00–15:00 17:00–00:00\n星期二11:00–15:00 17:00–00:00\n星期三11:00–15:00 17:00–00:00\n星期四11:00–15:00 17:00–00:00\n星期五11:00–15:00 17:00–00:00\n星期六11:00–00:00",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559dbb7fc03a103ee86ca0ee-乾杯日式燒肉-(Att4Fun)"
    },
    {
      "id": "517",
      "name": "魚君 さかなくん 海鮮丼專門店",
      "address": "臺北市信義區松高路16號B2",
      "lng.": "121.5672751",
      "lat.": "25.03872072",
      "time":
          "星期日11:00–15:00 17:30–21:00\n星期一11:00–14:00 17:30–21:00\n星期二11:00–14:00 17:30–21:00\n星期三11:00–14:00 17:30–21:00\n星期四11:00–14:00 17:30–21:00\n星期五11:00–14:00 17:30–21:00\n星期六11:00–15:00 17:30–21:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5df6f118d6895d04e3658af1-魚君海鮮丼專門店-さかなくん"
    },
    {
      "id": "518",
      "name": "開飯川食堂 市府店",
      "address": "臺北市信義區忠孝東路五段8號7樓",
      "lng.": "121.565391",
      "lat.": "25.0406026",
      "time":
          "星期日11:00–16:00 17:00–21:30\n星期一11:30–16:00 17:30–21:30\n星期二11:30–16:00 17:30–21:30\n星期三11:30–16:00 17:30–21:30\n星期四11:30–16:00 17:30–21:30\n星期五11:30–16:00 17:30–21:30\n星期六11:00–16:00 17:00–21:30",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d455ec03a103ee86c5af2-開飯川食堂"
    },
    {
      "id": "519",
      "name": "天菜TienFood",
      "address": "臺北市信義區忠孝東路四段559巷12號1樓",
      "lng.": "121.5637418",
      "lat.": "25.04205654",
      "time":
          "星期日11:30–20:30\n星期一11:30–14:30 17:30–20:30\n星期二11:30–14:30 17:30–20:30\n星期三11:30–14:30 17:30–20:30\n星期四11:30–14:30 17:30–20:30\n星期五11:30–14:30 17:30–20:30\n星期六11:30–20:30",
      "cuisine_type": "日式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f0c01bed6895d142e69194c-天菜TienFood"
    },
    {
      "id": "520",
      "name": "佬饕心",
      "address": "臺北市信義區忠孝東路四段559巷8-1號",
      "lng.": "121.5637424",
      "lat.": "25.04197431",
      "time":
          "星期日11:30–14:30 17:00–20:30\n星期一11:30–14:30 17:00–20:30\n星期二11:30–14:30 17:00–20:30\n星期三11:30–14:30 17:00–20:30\n星期四11:30–14:30 17:00–20:30\n星期五11:30–14:30 17:00–20:30\n星期六11:30–14:30 17:00–20:30",
      "cuisine_type": "日式",
      "rating": "4.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5f7992988c906d2d7daeefc0-佬饕心"
    },
    {
      "id": "521",
      "name": "Café&Meal MUJI 統一時代店",
      "address": "臺北市信義區忠孝東路五段8號B2",
      "lng.": "121.5656303",
      "lat.": "25.04056995",
      "time":
          "星期日11:00–22:00\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bd0803f2756dd562cfb926e-Café%26Meal-MUJI-統一時代店"
    },
    {
      "id": "522",
      "name": "紅花鐵板燒101旗艦店",
      "address": "臺北市信義區市府路45號5樓",
      "lng.": "121.563882",
      "lat.": "25.03358515",
      "time":
          "星期日11:30–14:30 17:30–22:00\n星期一11:30–14:30 17:30–22:00\n星期二11:30–14:30 17:30–22:00\n星期三11:30–14:30 17:30–22:00\n星期四11:30–14:30 17:30–22:00\n星期五11:30–14:30 17:30–22:00\n星期六11:30–14:30 17:30–22:00",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559d5fadc03a103ee86c6afd-紅花鐵板燒"
    },
    {
      "id": "523",
      "name": "ラーメン凪 Ramen Nagi (信義店)",
      "address": "臺北市信義區松壽路22號2樓",
      "lng.": "121.5677565",
      "lat.": "25.03548685",
      "time":
          "星期日11:30–20:30\n星期一11:30–20:30\n星期二11:30–20:30\n星期三11:30–20:30\n星期四11:30–20:30\n星期五11:30–20:30\n星期六11:30–20:30",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b7f8efdf5246818612690dd-ラーメン凪-Ramen-Nagi-信義店"
    },
    {
      "id": "524",
      "name": "東京豚極",
      "address": "臺北市信義區松高路11號B2",
      "lng.": "121.5652211",
      "lat.": "25.03971271",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–21:30\n星期六11:00–21:30",
      "cuisine_type": "日式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/59ce8bad2756dd6fac8adbc7-東京豚極"
    },
    {
      "id": "525",
      "name": "丸亀製麵 新光三越臺北信義A8店",
      "address": "臺北市信義區松高路12號B2",
      "lng.": "121.5666018",
      "lat.": "25.03835031",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d3f36c03a103ee86c56d9-丸龜製麵"
    },
    {
      "id": "526",
      "name": "Chili's Grill & Bar美式休閒餐廳-信義店 (Xinyi)",
      "address": "臺北市信義區松壽路22號",
      "lng.": "121.56775",
      "lat.": "25.03554815",
      "time":
          "星期日11:30–22:00\n星期一11:30–14:30 17:30–21:30\n星期二11:30–14:30 17:30–21:30\n星期三11:30–14:30 17:30–21:30\n星期四11:30–14:30 17:30–21:30\n星期五11:30–14:30 17:30–22:30\n星期六11:30–22:30",
      "cuisine_type": "美式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559ddd8dc03a103ee86cb6d1-Chili's"
    },
    {
      "id": "527",
      "name": "YKNK club",
      "address": "臺北市信義區松仁路58號14樓",
      "lng.": "121.5681418",
      "lat.": "25.03671087",
      "time":
          "星期日11:00–15:30 17:00–23:00\n星期一11:00–15:30 17:00–23:00\n星期二11:00–15:30 17:00–23:00\n星期三11:00–15:30 17:00–23:00\n星期四11:00–15:30 17:00–23:00\n星期五11:00–15:30 17:00–23:00\n星期六11:00–15:30 17:00–23:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/5e6f1691226139704f3ab9db-YKNK-club"
    },
    {
      "id": "528",
      "name": "元鍋精緻火鍋私房菜",
      "address": "臺北市信義區莊敬路178巷12號",
      "lng.": "121.5606931",
      "lat.": "25.03129981",
      "time":
          "星期日休息\n星期一休息\n星期二12:00–14:30 17:30–23:00\n星期三12:00–14:30 17:30–23:00\n星期四12:00–14:30 17:30–23:00\n星期五12:00–14:30 17:30–23:00\n星期六12:00–14:30 17:30–23:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5bdd660c23679c26756a859a-元鍋3.0"
    },
    {
      "id": "529",
      "name": "Cloud 9 Cafe 信義店",
      "address": "臺北市信義區莊敬路208號",
      "lng.": "121.561489",
      "lat.": "25.03028474",
      "time":
          "星期日11:00–21:00\n星期一11:00–21:00\n星期二11:00–21:00\n星期三11:00–21:00\n星期四11:00–21:00\n星期五11:00–21:00\n星期六11:00–21:00",
      "cuisine_type": "義式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57f29f162756dd78ff0aed8c-Cloud-9-Cafe-信義店"
    },
    {
      "id": "530",
      "name": "老乾杯 信義店",
      "address": "臺北市信義區松壽路9號8樓",
      "lng.": "121.5666331",
      "lat.": "25.03627723",
      "time":
          "星期日11:30–15:00 17:00–00:00\n星期一11:30–15:00 17:00–00:00\n星期二11:30–15:00 17:00–00:00\n星期三11:30–15:00 17:00–00:00\n星期四11:30–15:00 17:00–00:00\n星期五11:30–15:00 17:00–00:00\n星期六11:30–15:00 17:00–00:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559daba4c03a103ee86c986b-老乾杯"
    },
    {
      "id": "531",
      "name": "武鶴個人鍋 信義店",
      "address": "臺北市信義區基隆路一段147巷19號",
      "lng.": "121.566605",
      "lat.": "25.04251649",
      "time":
          "星期日11:30–22:30\n星期一11:30–14:30 17:00–22:30\n星期二11:30–14:30 17:00–22:30\n星期三11:30–14:30 17:00–22:30\n星期四11:30–14:30 17:00–22:30\n星期五11:30–14:30 17:00–22:30\n星期六11:30–22:30",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5dd28239226139525a01a928-武鶴個人鍋-信義店"
    },
    {
      "id": "532",
      "name": "TOKU大眾酒場",
      "address": "臺北市信義區基隆路一段147巷5弄11號",
      "lng.": "121.5661425",
      "lat.": "25.04287738",
      "time":
          "星期日18:00–03:00\n星期一休息\n星期二18:00–03:00\n星期三18:00–03:00\n星期四18:00–03:00\n星期五18:00–03:00\n星期六18:00–03:00",
      "cuisine_type": "日式",
      "rating": "3.6",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/55a67fd6c03a104df53ca6f6-TOKU大眾酒場"
    },
    {
      "id": "533",
      "name": "犇 鐵板燒 微風信義館",
      "address": "臺北市信義區忠孝東路五段68號4樓",
      "lng.": "121.566891",
      "lat.": "25.04049703",
      "time":
          "星期日12:00–14:30 18:00–21:30\n星期一12:00–14:30 18:00–21:30\n星期二12:00–14:30 18:00–21:30\n星期三12:00–14:30 18:00–21:30\n星期四12:00–14:30 18:00–21:30\n星期五12:00–14:30 18:00–21:30\n星期六12:00–14:30 18:00–21:30",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/57f14d0d2756dd0d12f56326-犇鐵板燒-微風信義館"
    },
    {
      "id": "534",
      "name": "橘色涮涮屋A9館",
      "address": "臺北市信義區松壽路9號7樓",
      "lng.": "121.5667015",
      "lat.": "25.03666822",
      "time":
          "星期日11:30–23:30\n星期一11:30–23:30\n星期二11:30–23:30\n星期三11:30–23:30\n星期四11:30–23:30\n星期五11:30–23:30\n星期六11:30–23:30",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/5ea2f6032756dd061604fcd9-橘色涮涮屋A9館"
    },
    {
      "id": "535",
      "name": "黑浮咖啡 臺北信義ATT店",
      "address": "臺北市信義區松壽路12號5樓",
      "lng.": "121.5660669",
      "lat.": "25.03530629",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "義式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fcf8c0b2756dd5e00bf9520-黑浮咖啡-臺北信義ATT店"
    },
    {
      "id": "536",
      "name": "PappaRich 金爸爸信義A9店",
      "address": "臺北市信義區松壽路9號7樓",
      "lng.": "121.5667075",
      "lat.": "25.03666772",
      "time":
          "星期日11:00–21:30\n星期一11:00–15:00 17:00–21:30\n星期二11:00–15:00 17:00–21:30\n星期三11:00–15:00 17:00–21:30\n星期四11:00–15:00 17:00–21:30\n星期五11:00–15:00 17:00–21:30\n星期六11:00–21:30",
      "cuisine_type": "東南亞",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/57701a362756dd515ec80669-PappaRich"
    },
    {
      "id": "537",
      "name": "鶿克米 TSUKUMI",
      "address": "臺北市信義區忠孝東路五段68號4樓",
      "lng.": "121.5669367",
      "lat.": "25.04056587",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56a8e69b2756dd3766b267fc-Tsukumi鶿克米-微風信義店"
    },
    {
      "id": "538",
      "name": "柏克金啤酒餐廳 松仁店",
      "address": "臺北市信義區松仁路91號",
      "lng.": "121.5686519",
      "lat.": "25.03679333",
      "time":
          "星期日08:00–22:00\n星期一08:00–22:00\n星期二08:00–22:00\n星期三08:00–22:00\n星期四08:00–22:00\n星期五08:00–23:00\n星期六08:00–23:00",
      "cuisine_type": "美式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5bc5f4862756dd275b74b8e6-柏克金啤酒餐廳-松仁店"
    },
    {
      "id": "539",
      "name": "世貿名人坊",
      "address": "臺北市信義區基隆路一段333號34樓",
      "lng.": "121.5612234",
      "lat.": "25.03440445",
      "time":
          "星期日11:00–15:30 17:00–21:30\n星期一11:30–14:30 17:30–21:30\n星期二11:30–14:30 17:30–21:30\n星期三11:30–14:30 17:30–21:30\n星期四11:30–14:30 17:30–21:30\n星期五11:30–14:30 17:30–21:30\n星期六11:00–15:30 17:00–21:30",
      "cuisine_type": "中式",
      "rating": "4.6",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5f3a92d32756dd6228e33b07-世貿名人坊"
    },
    {
      "id": "540",
      "name": "石研室 爆炒石頭火鍋專賣店 - 微風南山店",
      "address": "臺北市信義區松智路17號B2",
      "lng.": "121.5668135",
      "lat.": "25.03430147",
      "time":
          "星期日11:00–20:30\n星期一11:00–20:30\n星期二11:00–20:30\n星期三11:00–20:30\n星期四11:00–21:00\n星期五11:00–21:00\n星期六11:00–21:00",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c77ef202756dd46ea1c176d-石研室-石頭火鍋-微風南山店"
    },
    {
      "id": "541",
      "name": "淀殿 YODO DONO",
      "address": "臺北市信義區莊敬路178巷10號",
      "lng.": "121.5608071",
      "lat.": "25.03130735",
      "time":
          "星期日11:30–14:00 17:30–21:30\n星期一11:30–14:00 17:30–21:30\n星期二11:30–14:00 17:30–21:30\n星期三11:30–14:00 17:30–21:30\n星期四11:30–14:00 17:30–21:30\n星期五11:30–14:00 17:30–21:30\n星期六11:30–14:00 17:30–21:30",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/5b6f25ae2756dd51613cf3b2-淀殿-YODO-DONO"
    },
    {
      "id": "542",
      "name": "半島牛肉麵",
      "address": "臺北市信義區忠孝東路五段215巷23號",
      "lng.": "121.5702954",
      "lat.": "25.0419139",
      "time":
          "星期日10:45–14:15 17:00–21:15\n星期一10:45–14:15 17:00–21:15\n星期二10:45–14:15 17:00–21:15\n星期三10:45–14:15 17:00–21:15\n星期四10:45–14:15 17:00–21:15\n星期五10:45–14:15 17:00–21:15\n星期六10:45–14:15 17:00–21:15",
      "cuisine_type": "中式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5a5e3fe12756dd60a52165dd-半島牛肉麵"
    },
    {
      "id": "543",
      "name": "Chambistro 享香檳海鮮餐酒館",
      "address": "臺北市信義區松壽路9號6樓",
      "lng.": "121.5667176",
      "lat.": "25.03667314",
      "time":
          "星期日11:00–14:30 17:30–22:00\n星期一11:00–14:30 17:30–22:00\n星期二11:00–14:30 17:30–22:00\n星期三11:00–14:30 17:30–22:00\n星期四11:00–14:30 17:30–22:00\n星期五11:00–14:30 17:30–22:00\n星期六11:00–14:30 17:30–22:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5c25006b2261395290129121-ChamBistro-Diner-and"
    },
    {
      "id": "544",
      "name": "WAT",
      "address": "臺北市信義區信義路五段16號1樓",
      "lng.": "121.5629442",
      "lat.": "25.03269546",
      "time":
          "星期日18:00–01:00\n星期一18:00–01:00\n星期二18:00–01:00\n星期三18:00–01:00\n星期四18:00–01:00\n星期五18:00–02:30\n星期六16:00–02:30",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5de486ed8c906d1934df397f-WAT-Bar"
    },
    {
      "id": "545",
      "name": "海壽司微風松高店",
      "address": "臺北市信義區松高路16號3樓",
      "lng.": "121.5672794",
      "lat.": "25.03872115",
      "time":
          "星期日11:00–14:30 17:00–21:30\n星期一11:30–14:00 17:30–21:30\n星期二11:30–14:00 17:30–21:30\n星期三11:30–14:00 17:30–21:30\n星期四11:30–14:00 17:30–21:30\n星期五11:30–14:00 17:30–21:30\n星期六11:00–14:30 17:00–21:30",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5c4e81f323679c1e60f55b89-海壽司微風松高店"
    },
    {
      "id": "546",
      "name": "Verona創義廚房",
      "address": "臺北市信義區莊敬路197巷6號",
      "lng.": "121.5617381",
      "lat.": "25.03080765",
      "time":
          "星期日11:30–21:00\n星期一休息\n星期二11:30–14:30 17:30–20:30\n星期三11:30–14:30 17:30–20:30\n星期四11:30–14:30 17:30–20:30\n星期五11:30–14:30 17:30–20:30\n星期六11:30–21:00",
      "cuisine_type": "義式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a678b5c03a104df53ca4e2-Verona創義廚房"
    },
    {
      "id": "547",
      "name": "心齋",
      "address": "臺北市信義區松智路17號2樓",
      "lng.": "121.5659577",
      "lat.": "25.03430426",
      "time":
          "星期日11:00–15:00 18:00–21:30\n星期一11:00–15:00 18:00–21:30\n星期二11:00–15:00 18:00–21:30\n星期三11:00–15:00 18:00–21:30\n星期四11:00–15:00 18:00–22:00\n星期五11:00–15:00 18:00–22:00\n星期六11:00–15:00 18:00–22:00",
      "cuisine_type": "港式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5c4533d3f524682cb4ebeb88-心齋"
    },
    {
      "id": "548",
      "name": "一品活蝦市府店",
      "address": "臺北市信義區忠孝東路五段195號",
      "lng.": "121.5695186",
      "lat.": "25.04121246",
      "time":
          "星期日18:00–03:00\n星期一18:00–03:00\n星期二18:00–03:00\n星期三18:00–03:00\n星期四18:00–03:00\n星期五18:00–03:00\n星期六18:00–03:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559d2496c03a103ee86c4505-一品活蝦市府店"
    },
    {
      "id": "549",
      "name": "京都勝牛-信義新光A11店",
      "address": "臺北市信義區松壽路11號B2",
      "lng.": "121.567239",
      "lat.": "25.03653719",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bc4a2ed2756dd275f74ba05-京都勝牛-信義新光A11店"
    },
    {
      "id": "550",
      "name": "HALEAKALA 美式漢堡",
      "address": "臺北市信義區松仁路28號B2",
      "lng.": "121.5676625",
      "lat.": "25.03962188",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:30\n星期六11:00–22:30",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559dba67c03a103ee86ca00c-HALEAKALA-夏威夷酒吧餐廳"
    },
    {
      "id": "551",
      "name": "英雄塚",
      "address": "臺北市信義區松隆路9巷32號1樓",
      "lng.": "121.5673256",
      "lat.": "25.04448076",
      "time":
          "星期日00:00–06:00\n星期一00:00–06:00\n星期二00:00–06:00\n星期三00:00–06:00\n星期四00:00–06:00\n星期五00:00–06:00\n星期六00:00–06:00",
      "cuisine_type": "日式",
      "rating": "4.8",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5d244e5e2261393c4e34a9c1-英雄塚"
    },
    {
      "id": "552",
      "name": "禾月居寿司處",
      "address": "臺北市信義區忠孝東路四段553巷6弄14號1樓",
      "lng.": "121.5634178",
      "lat.": "25.04221184",
      "time":
          "星期日休息\n星期一休息\n星期二12:00–14:00 18:00–21:00\n星期三12:00–14:00 18:00–21:00\n星期四12:00–14:00 18:00–21:00\n星期五12:00–14:00 18:00–21:00\n星期六12:00–14:00 18:00–21:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/55a5e3d1c03a102ec1415525-禾月居寿司處"
    },
    {
      "id": "553",
      "name": "Shin Pu Yuan 新葡苑四十六",
      "address": "臺北市信義區松智路17號46樓",
      "lng.": "121.5664925",
      "lat.": "25.03441528",
      "time":
          "星期日11:30–14:30 17:30–22:00\n星期一11:30–14:30 17:30–22:00\n星期二11:30–14:30 17:30–22:00\n星期三11:30–14:30 17:30–22:00\n星期四11:30–14:30 17:30–22:00\n星期五11:30–14:30 17:30–22:00\n星期六11:30–14:30 17:30–22:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5c46695c23679c0d64d96d6b-新葡苑四十六-微風南山"
    },
    {
      "id": "554",
      "name": "真心台菜 微風南山店",
      "address": "臺北市信義區松智路17號4樓",
      "lng.": "121.5659531",
      "lat.": "25.03430334",
      "time":
          "星期日11:30–21:30\n星期一11:30–21:30\n星期二11:30–21:30\n星期三11:30–21:30\n星期四11:30–22:00\n星期五11:30–22:00\n星期六11:30–22:00",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5ea654edd6895d19887b3265-真心台菜微風南山店"
    },
    {
      "id": "555",
      "name": "養鍋 Yang Guo 石頭涮涮鍋 (臺北松菸店)",
      "address": "臺北市信義區忠孝東路四段559巷28號",
      "lng.": "121.5638187",
      "lat.": "25.04281522",
      "time":
          "星期日11:00–22:30\n星期一11:30–14:30 17:00–22:30\n星期二11:30–14:30 17:00–22:30\n星期三11:30–14:30 17:00–22:30\n星期四11:30–14:30 17:00–22:30\n星期五11:30–14:30 17:00–22:30\n星期六11:30–14:30 17:00–22:30",
      "cuisine_type": "日式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d0f8ae52756dd2c6918487f-養鍋-Yang-Guo-石頭涮涮鍋-(台"
    },
    {
      "id": "556",
      "name": "薄多義Bite 2 Eat 義式手工披薩 - 臺北ATT4FUN店",
      "address": "臺北市信義區松壽路12號5樓",
      "lng.": "121.5660772",
      "lat.": "25.03530026",
      "time":
          "星期日11:00–16:45 17:30–21:30\n星期一11:00–16:45 17:30–22:00\n星期二11:00–16:45 17:30–22:00\n星期三11:00–16:45 17:30–22:00\n星期四11:00–16:45 17:30–22:00\n星期五11:00–16:45 17:30–23:00\n星期六11:00–16:45 17:30–23:00",
      "cuisine_type": "義式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dbb97c03a103ee86ca116-薄多義-Bite-2-Eat"
    },
    {
      "id": "557",
      "name": "Supreme Salmon 美威鮭魚專賣店 誠品信義店",
      "address": "臺北市信義區松高路11號B2",
      "lng.": "121.5658717",
      "lat.": "25.03971882",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56efa5b3699b6e3e855fd54d-美威鮭魚-supreme-salmon"
    },
    {
      "id": "558",
      "name": "Tavern D the RUM BAR",
      "address": "臺北市信義區莊敬路178巷6號",
      "lng.": "121.5609566",
      "lat.": "25.03129405",
      "time":
          "星期日12:00–18:00\n星期一休息\n星期二12:00–18:00\n星期三12:00–18:00\n星期四12:00–00:00\n星期五12:00–00:00\n星期六12:00–00:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5eddad368c906d217421bc34-Tavern-D-the-RUM-BAR"
    },
    {
      "id": "559",
      "name": "洋城義大利餐廳-誠品信義店",
      "address": "臺北市信義區松高路11號4樓",
      "lng.": "121.5658673",
      "lat.": "25.03970384",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "義式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bfabac8f524680b126f0549-洋城義大利餐廳-誠品信義店"
    },
    {
      "id": "560",
      "name": "黑毛屋本家 信義店",
      "address": "臺北市信義區松高路19號6樓",
      "lng.": "121.5670063",
      "lat.": "25.03937262",
      "time":
          "星期日11:30–22:30\n星期一11:30–15:00 17:00–22:30\n星期二11:30–15:00 17:00–22:30\n星期三11:30–15:00 17:00–22:30\n星期四11:30–15:00 17:00–22:30\n星期五11:30–15:00 17:00–22:30\n星期六11:30–22:30",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/5653ecd72756dd1f85c54df9-黑毛屋"
    },
    {
      "id": "561",
      "name": "夏部火鍋-信義ATT",
      "address": "臺北市信義區松壽路12號4樓",
      "lng.": "121.566088",
      "lat.": "25.03530026",
      "time":
          "星期日11:30–22:00\n星期一11:30–22:00\n星期二11:30–22:00\n星期三11:30–22:00\n星期四11:30–22:00\n星期五11:30–23:00\n星期六11:30–23:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5efc9c6e2756dd06c21e600f-夏部火鍋-信義ATT店"
    },
    {
      "id": "562",
      "name": "小小麥臺北信義店",
      "address": "臺北市信義區永吉路30巷75號",
      "lng.": "121.5688611",
      "lat.": "25.04414893",
      "time":
          "星期日休息\n星期一11:00–23:30\n星期二11:00–23:30\n星期三11:00–23:30\n星期四11:00–23:30\n星期五11:00–23:30\n星期六11:00–23:30",
      "cuisine_type": "日式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5f88908602935e4a8253c745-小小麥-臺北信義店"
    },
    {
      "id": "563",
      "name": "太陽蕃茄拉麵 誠品信義店",
      "address": "臺北市信義區松高路11號B2",
      "lng.": "121.5658524",
      "lat.": "25.03973912",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–23:00\n星期六11:00–23:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/563eb56f2756dd4333a31497-太陽蕃茄拉麵"
    },
    {
      "id": "564",
      "name": "隨意鳥地方101景觀餐廳",
      "address": "臺北市信義區信義路五段7號85樓",
      "lng.": "121.5649303",
      "lat.": "25.03357091",
      "time":
          "星期日11:30–17:00 17:30–22:50\n星期一11:30–14:30 17:30–22:50\n星期二11:30–14:30 17:30–22:50\n星期三11:30–14:30 17:30–22:50\n星期四11:30–14:30 17:30–22:50\n星期五11:30–14:30 17:30–22:50\n星期六11:30–17:00 17:30–22:50",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/559d5ff1c03a103ee86c6b43-隨意鳥地方101觀景餐廳-Diamond"
    },
    {
      "id": "565",
      "name": "涼涼嗆-四川涼麵",
      "address": "臺北市信義區永吉路30巷157弄6號",
      "lng.": "121.5689762",
      "lat.": "25.04223631",
      "time":
          "星期日11:00–21:00\n星期一11:00–21:00\n星期二11:00–21:00\n星期三11:00–21:00\n星期四11:00–21:00\n星期五11:00–21:00\n星期六11:00–21:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5f4c7115d6895d79aecbf28a-涼涼嗆四川涼麵"
    },
    {
      "id": "566",
      "name": "熊屋",
      "address": "臺北市信義區嘉興街11號",
      "lng.": "121.5588365",
      "lat.": "25.03232271",
      "time":
          "星期日休息\n星期一11:00–14:00 17:00–21:00\n星期二11:00–14:00 17:00–21:00\n星期三11:00–14:00 17:00–21:00\n星期四11:00–14:00 17:00–21:00\n星期五11:00–14:00 17:00–21:00\n星期六11:00–14:00 17:00–21:00",
      "cuisine_type": "日式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5cdd6746f52468153ac2f8d1-熊屋"
    },
    {
      "id": "567",
      "name": "這味泰泰 Mrs. Thai - 微風南山店",
      "address": "臺北市信義區松廉路3號B2",
      "lng.": "121.5668204",
      "lat.": "25.03430267",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–21:30\n星期六11:00–21:30",
      "cuisine_type": "泰式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5cb09f2f2756dd4c17072f62-這味泰泰-Mrs.-THAI-微風南山店"
    },
    {
      "id": "568",
      "name": "Mo-Mo-Paradise 臺北Neo19牧場",
      "address": "臺北市信義區松壽路22號",
      "lng.": "121.5678081",
      "lat.": "25.03554699",
      "time":
          "星期日11:00–22:00\n星期一11:30–22:00\n星期二11:30–22:00\n星期三11:30–22:00\n星期四11:30–22:00\n星期五11:30–23:00\n星期六11:00–23:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559ddd95c03a103ee86cb6f0-Mo-Mo-Paradise"
    },
    {
      "id": "569",
      "name": "Parking 149 中式小館",
      "address": "臺北市信義區基隆路一段149號",
      "lng.": "121.5655152",
      "lat.": "25.04248829",
      "time":
          "星期日休息\n星期一11:00–20:00\n星期二11:00–20:00\n星期三11:00–20:00\n星期四11:00–20:00\n星期五11:00–20:00\n星期六休息",
      "cuisine_type": "中式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559dbc07c03a103ee86ca246-Parking-149"
    },
    {
      "id": "570",
      "name": "雞三和 微風南山店",
      "address": "臺北市信義區松智路17號5樓",
      "lng.": "121.566229",
      "lat.": "25.03437783",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–21:30\n星期六11:00–21:30",
      "cuisine_type": "日式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c6a2082f524681eef952e70-尾張雞三和-微風南山店"
    },
    {
      "id": "571",
      "name": "BELLINI Pasta Pasta 臺北信義威秀店",
      "address": "臺北市信義區松壽路20號2樓",
      "lng.": "121.5673083",
      "lat.": "25.03543116",
      "time":
          "星期日11:30–22:00\n星期一11:30–22:00\n星期二11:30–22:00\n星期三11:30–22:00\n星期四11:30–22:00\n星期五11:30–23:00\n星期六11:30–23:00",
      "cuisine_type": "義式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56213f7f2756dd74717fafa2-BELLINI-Pasta-Pasta-"
    },
    {
      "id": "572",
      "name": "餃子樂 信義店",
      "address": "臺北市信義區忠孝東路五段59號",
      "lng.": "121.56669",
      "lat.": "25.04138371",
      "time":
          "星期日休息\n星期一11:30–21:00\n星期二11:30–21:00\n星期三11:30–21:00\n星期四11:30–21:00\n星期五11:30–21:00\n星期六11:30–21:00",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5acaf1c223679c203c9f1996-餃子樂-信義店"
    },
    {
      "id": "573",
      "name": "川田涮涮鍋",
      "address": "臺北市信義區忠孝東路五段201號",
      "lng.": "121.5696791",
      "lat.": "25.04120838",
      "time":
          "星期日11:00–22:30\n星期一11:00–14:00 17:00–22:30\n星期二11:00–14:00 17:00–22:30\n星期三 11:00–14:00 17:00–22:30\n星期四11:00–14:00 17:00–22:30\n星期五11:00–14:00 17:00–22:30\n星期六11:00–22:30",
      "cuisine_type": "日式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559ddf87c03a103ee86cb83e-川田涮涮鍋"
    },
    {
      "id": "574",
      "name": "21風味館 21PLUS臺北時代門市",
      "address": "臺北市信義區忠孝東路五段8號B2",
      "lng.": "121.5649238",
      "lat.": "25.04058474",
      "time":
          "星期日11:00–21:30\n星期一07:30–21:30\n星期二07:30–21:30\n星期三07:30–21:30\n星期四07:30–21:30\n星期五07:30–22:00\n星期六07:30–22:00",
      "cuisine_type": "美式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/585189bc2756dd7578b8ec7d-21PLUS臺北時代門市"
    },
    {
      "id": "575",
      "name": "曹料理",
      "address": "臺北市信義區基隆路二段39巷16號",
      "lng.": "121.5592787",
      "lat.": "25.03075988",
      "time":
          "星期日11:00–14:00 17:30–21:30\n星期一11:00–14:00 17:30–21:30\n星期二11:00–14:00 17:30–21:30\n星期三11:00–14:00 17:30–21:30\n星期四11:00–14:00 17:30–21:30\n星期五11:00–14:00 17:30–21:30\n星期六11:00–14:00 17:30–21:30",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/595222cd23679c647ab52ab0-曹料理"
    },
    {
      "id": "576",
      "name": "bar & restaurant a³ 新義式餐廳",
      "address": "臺北市信義區松仁路28號1樓",
      "lng.": "121.5676517",
      "lat.": "25.03962188",
      "time":
          "星期日10:30–22:00\n星期一10:30–22:00\n星期二10:30–22:00\n星期三10:30–22:00\n星期四10:30–22:00\n星期五10:30–22:30\n星期六10:30–22:30",
      "cuisine_type": "義式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dba87c03a103ee86ca047-bar-%26-restaurant-a³-"
    },
    {
      "id": "577",
      "name": "京都餃子的王將 臺北統一時代店",
      "address": "臺北市大安區忠孝東路五段8號B2",
      "lng.": "121.5649708",
      "lat.": "25.04068691",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5cdb7c9bf524683f2e5d58ef-餃子の王将-統一時代百貨臺北店"
    },
    {
      "id": "578",
      "name": "賣飯食-信義ATT",
      "address": "臺北市信義區松壽路12號4樓",
      "lng.": "121.5660698",
      "lat.": "25.03530421",
      "time":
          "星期日11:30–22:00\n星期一11:30–22:00\n星期二11:30–22:00\n星期三11:30–22:00\n星期四11:30–22:00\n星期五11:30–23:00\n星期六11:30–23:00",
      "cuisine_type": "日式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5ee8dd0222613947b75afb2a-賣飯食-信義ATT"
    },
    {
      "id": "579",
      "name": "鷹流東京涼麺・油そば本舗【涼風庵Ryofuh-An】",
      "address": "臺北市信義區忠孝東路五段183號",
      "lng.": "121.5691671",
      "lat.": "25.04123639",
      "time":
          "星期日11:30–14:00 17:00–23:00\n星期一11:30–14:00 17:00–23:00\n星期二11:30–14:00 17:00–23:00\n星期三11:30–14:00 17:00–23:00\n星期四11:30–14:00 17:00–23:00\n星期五11:30–14:00 17:00–23:00\n星期六11:30–14:00 17:00–23:00",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bb0dcef2756dd3ce23812d3-鷹流東京涼麺・油そば本舗【涼風庵Ryof"
    },
    {
      "id": "580",
      "name": "吉野家 市府店",
      "address": "臺北市信義區忠孝東路五段155號",
      "lng.": "121.5684523",
      "lat.": "25.04124626",
      "time":
          "星期日08:00–23:00\n星期一08:00–23:00\n星期二08:00–23:00\n星期三08:00–23:00\n星期四08:00–23:00\n星期五08:00–23:00\n星期六08:00–23:00",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/559dbe84c03a103ee86ca3f9-吉野家"
    },
    {
      "id": "581",
      "name": "星野肉肉鍋mini-臺北新光三越A11店",
      "address": "臺北市信義區松壽路11號B2",
      "lng.": "121.5672584",
      "lat.": "25.03652514",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "台式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e9e66e48c906d36b38b7af2-星野肉肉鍋-新光A11店"
    },
    {
      "id": "582",
      "name": "麵食主義 KIRIN PASTA 忠孝店",
      "address": "臺北市信義區忠孝東路五段181號",
      "lng.": "121.5691157",
      "lat.": "25.04123143",
      "time":
          "星期日11:00–14:30 17:00–20:30\n星期一11:00–14:30 17:00–20:30\n星期二11:00–14:30 17:00–20:30\n星期三11:00–14:30 17:00–20:30\n星期四11:00–14:30 17:00–20:30\n星期五11:00–14:30 17:00–20:30\n星期六11:00–14:30 17:00–20:30",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/559d7ca5c03a103ee86c7ef2-麵食主義"
    },
    {
      "id": "583",
      "name": "拼拼拌 都滿韓家 市府站",
      "address": "臺北市信義區忠孝東路五段31巷18弄2號",
      "lng.": "121.5659741",
      "lat.": "25.04157619",
      "time":
          "星期日12:00–21:00\n星期一12:00–21:00\n星期二12:00–21:00\n星期三12:00–21:00\n星期四12:00–21:00\n星期五12:00–21:00\n星期六12:00–21:00",
      "cuisine_type": "韓式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b8412d222613970fc2f3434-拼拼拌-Bibimbap"
    },
    {
      "id": "584",
      "name": "泰富豪(信義世貿店)",
      "address": "臺北市信義區嘉興街8號",
      "lng.": "121.5588836",
      "lat.": "25.03249757",
      "time":
          "星期日11:30–14:30 17:00–22:00\n星期一11:30–14:30 17:00–22:00\n星期二休息\n星期三11:30–14:30 17:00–22:00\n星期四11:30–14:30 17:00–22:00\n星期五11:30–14:30 17:00–22:00\n星期六11:30–14:30 17:00–22:00",
      "cuisine_type": "泰式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dc892c03a103ee86caa4e-泰富豪(信義世貿店)"
    },
    {
      "id": "585",
      "name": "Herbivore Vegan料理",
      "address": "臺北市信義區松高路19號2樓",
      "lng.": "121.5666283",
      "lat.": "25.03964572",
      "time":
          "星期日11:00–20:30\n星期一11:00–20:30\n星期二11:00–20:30\n星期三11:00–20:30\n星期四11:00–20:30\n星期五11:00–21:00\n星期六11:00–21:00",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c1efbef2261390532fab982-Herbivore-Vegan料理"
    },
    {
      "id": "586",
      "name": "齋之傳說-傳說食堂素食便當",
      "address": "臺北市信義區永吉路30巷157弄5號",
      "lng.": "121.5689927",
      "lat.": "25.04240692",
      "time":
          "星期日休息\n星期一10:30–14:00 16:30–20:00\n星期二10:30–14:00 16:30–20:00\n星期三10:30–14:00 16:30–20:00\n星期四10:30–14:00 16:30–20:00\n星期五10:30–14:00 16:30–20:00\n星期六10:30–14:00 16:30–20:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57acbf3e2756dd38ae961fc5-齋之傳說素食餐廳永吉店"
    },
    {
      "id": "587",
      "name": "香茅廚 微風南山店(Chef Lemongrass Thai Bistro Namshan)",
      "address": "臺北市信義區松智路17號4樓",
      "lng.": "121.5659563",
      "lat.": "25.03430678",
      "time":
          "星期日11:30–21:30\n星期一11:30–21:30\n星期二11:30–21:30\n星期三11:30–21:30\n星期四11:30–22:00\n星期五11:30–22:00\n星期六11:30–22:00",
      "cuisine_type": "泰式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5eafba98d6895d3873164a5b-香茅廚泰式餐廳-微風南山店"
    },
    {
      "id": "588",
      "name": "掌門精釀啤酒Tap Bistro Zhangmen - 微風松高店",
      "address": "臺北市信義區松高路16號4樓",
      "lng.": "121.5672941",
      "lat.": "25.03770947",
      "time":
          "星期日16:00–00:00\n星期一16:00–00:00\n星期二16:00–00:00\n星期三16:00–00:00\n星期四16:00–00:00\n星期五16:00–00:00\n星期六16:00–00:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5ba31eaa2261397ecbd60c19-掌門精釀啤酒吧"
    },
    {
      "id": "589",
      "name": "一蘭 台灣臺北別館",
      "address": "臺北市信義區松壽路11號B1",
      "lng.": "121.5673241",
      "lat.": "25.0363171",
      "time":
          "星期日24小時營業\n星期一24小時營業\n星期二24小時營業\n星期三24小時營業\n星期四24小時營業\n星期五24小時營業\n星期六24小時營業",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5b3c418f23679c5a927d9f14-一蘭-臺北別館-新光三越A11"
    },
    {
      "id": "590",
      "name": "QAFE Room",
      "address": "臺北市信義區松仁路90號",
      "lng.": "121.5676747",
      "lat.": "25.03504352",
      "time":
          "星期日11:00–00:00\n星期一11:00–00:00\n星期二11:00–00:00\n星期三11:00–00:00\n星期四11:00–00:00\n星期五11:00–02:00\n星期六11:00–02:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5eef6d0b2756dd446e3086ae-QAFE-Room"
    },
    {
      "id": "591",
      "name": "溫叨Cafe & Dining 咖啡餐酒館",
      "address": "臺北市信義區菸廠路88號2樓",
      "lng.": "121.5614456",
      "lat.": "25.04456445",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5dad632322613956ab8325fd-溫叨-Cafe-%26-Dining"
    },
    {
      "id": "592",
      "name": "午餐盒도시락 韓式便當外送",
      "address": "臺北市信義區永吉路30巷102弄11號",
      "lng.": "121.5684323",
      "lat.": "25.04347377",
      "time":
          "星期日休息\n星期一10:00–14:00 17:00–20:00\n星期二10:00–14:00 17:00–20:00\n星期三10:00–14:00 17:00–20:00\n星期四10:00–14:00 17:00–20:00\n星期五10:00–14:00 17:00–20:00\n星期六休息",
      "cuisine_type": "韓式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5bc4a2f92756dd275f74ba0f-午餐盒도시락-韓式便當外送"
    },
    {
      "id": "593",
      "name": "新馬辣經典麻辣鍋-信義遠百店Plus+",
      "address": "臺北市信義區松壽路13號14樓",
      "lng.": "121.5679116",
      "lat.": "25.03621743",
      "time":
          "星期日11:00–02:00\n星期一11:00–02:00\n星期二11:00–02:00\n星期三11:00–02:00\n星期四11:00–02:00\n星期五11:00–02:00\n星期六11:00–02:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5f6613ce2756dd6ac680b37a-新馬辣經典麻辣鍋-信義遠百店Plus%2B"
    },
    {
      "id": "594",
      "name": "1+1鍋物 信義ATT店",
      "address": "臺北市信義區松壽路12號5樓",
      "lng.": "121.5660617",
      "lat.": "25.03530464",
      "time":
          "星期日11:00–22:00\n星期一11:00–14:00 17:00–22:00\n星期二11:00–14:00 17:00–22:00\n星期三11:00–14:00 17:00–22:00\n星期四11:00–14:00 17:00–22:00\n星期五11:00–14:00 17:00–22:00\n星期六11:00–23:00",
      "cuisine_type": "台式",
      "rating": "4.8",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f99397102935e7d6a39e4db-1%2B1鍋物-信義ATT店"
    },
    {
      "id": "595",
      "name": "虎記餃子世貿店",
      "address": "臺北市信義區基隆路二段39巷14號",
      "lng.": "121.5591497",
      "lat.": "25.03081495",
      "time":
          "星期日11:30–14:30 17:00–20:30\n星期一11:30–14:30 17:00–20:30\n星期二11:30–14:30 17:00–20:30\n星期三11:30–14:30 17:00–20:30\n星期四11:30–14:30 17:00–20:30\n星期五11:30–14:30 17:00–20:30\n星期六11:30–14:30 17:00–20:30",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5ed3bd5f2756dd053a4d4c06-虎記餃子世貿店"
    },
    {
      "id": "596",
      "name": "四國讃岐烏龍麺天麩羅専門店-微風南山店",
      "address": "臺北市信義區松智路17號5樓",
      "lng.": "121.5662457",
      "lat.": "25.03440862",
      "time":
          "星期日11:00–21:00\n星期一11:00–21:00\n星期二11:00–21:00\n星期三11:00–21:00\n星期四11:00–21:00\n星期五11:00–21:00\n星期六11:00–21:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c376035f5246846670b34c3-四國讃岐烏龍麺天麩羅専門店-微風南山店"
    },
    {
      "id": "597",
      "name": "紫艷中餐廳",
      "address": "臺北市信義區忠孝東路五段10號31樓",
      "lng.": "121.5657411",
      "lat.": "25.04059331",
      "time":
          "星期日11:30–14:30 18:00–22:00\n星期一11:30–14:30 18:00–22:00\n星期二11:30–14:30 18:00–22:00\n星期三11:30–14:30 18:00–22:00\n星期四11:30–14:30 18:00–22:00\n星期五11:30–14:30 18:00–22:00\n星期六11:30–14:30 18:00–22:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/5fe5f5ad2756dd79fdc4910e-紫艷中餐廳"
    },
    {
      "id": "598",
      "name": "DA ANTONIO By 隨意鳥地方",
      "address": "臺北市信義區市府路45號5樓",
      "lng.": "121.5641025",
      "lat.": "25.03348917",
      "time":
          "星期日11:30–22:00\n星期一11:30–22:00\n星期二11:30–22:00\n星期三11:30–22:00\n星期四11:30–22:00\n星期五11:30–22:00\n星期六11:30–22:00",
      "cuisine_type": "義式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/560aeb5f2756dd7169163a34-DA-ANTONIO-By-隨意鳥地方"
    },
    {
      "id": "599",
      "name": "臺北寒舍艾美酒店寒舍食譜",
      "address": "臺北市信義區松仁路38號",
      "lng.": "121.5681764",
      "lat.": "25.03826504",
      "time":
          "星期日11:30–14:00 18:00–21:30\n星期一11:30–14:00 18:00–21:30\n星期二11:30–14:00 18:00–21:30\n星期三11:30–14:00 18:00–21:30\n星期四11:30–14:00 18:00–21:30\n星期五11:30–14:00 18:00–21:30\n星期六11:30–14:00 18:00–21:30",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d6a3ac03a103ee86c72dd-寒舍食譜-(寒舍艾美酒店)"
    },
    {
      "id": "600",
      "name": "紅豆食府 信義店",
      "address": "臺北市信義區松壽路9號7樓",
      "lng.": "121.5666639",
      "lat.": "25.03670084",
      "time":
          "星期日11:00–14:30 17:00–21:30\n星期一11:00–14:30 17:00–21:30\n星期二11:00–14:30 17:00–21:30\n星期三11:00–14:30 17:00–21:30\n星期四11:00–14:30 17:00–21:30\n星期五11:00–14:30 17:00–21:30\n星期六11:00–14:30 17:00–21:30",
      "cuisine_type": "中式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/559dabafc03a103ee86c9889-紅豆食府"
    },
    {
      "id": "601",
      "name": "広島屋",
      "address": "臺北市信義區基隆路一段105號",
      "lng.": "121.5670901",
      "lat.": "25.04517556",
      "time":
          "星期日11:00–14:00 17:30–21:00\n星期一11:00–14:00 17:30–21:00\n星期二11:00–14:00 17:30–21:00\n星期三11:00–14:00 17:30–21:00\n星期四11:00–14:00 17:30–21:00\n星期五11:00–14:00 17:30–00:00\n星期六11:00–14:00 17:30–00:00",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5cd6ce9c22613905a9d5b76c-広島屋"
    },
    {
      "id": "602",
      "name": "鉄火牛排 新光三越臺北信義新天地A11",
      "address": "臺北市信義區松壽路11號B2",
      "lng.": "121.5672369",
      "lat.": "25.03654171",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "2.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ca2c72823679c3ce8660a93-鉄火牛排-新光三越A11"
    },
    {
      "id": "603",
      "name": "鐵支涮火鍋信義旗艦店",
      "address": "臺北市信義區松壽路28號",
      "lng.": "121.5680193",
      "lat.": "25.03554049",
      "time":
          "星期日11:30–23:00\n星期一11:30–14:30 17:30–22:30\n星期二11:30–14:30 17:30–22:30\n星期三11:30–14:30 17:30–22:30\n星期四11:30–14:30 17:30–22:30\n星期五11:30–01:30\n星期六11:30–01:30",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d23515c2756dd7622eedeb8-鐵支涮火鍋信義旗艦店"
    },
    {
      "id": "604",
      "name": "Papi Pasta",
      "address": "臺北市信義區忠孝東路四段559巷16弄18號",
      "lng.": "121.5642479",
      "lat.": "25.04228546",
      "time":
          "星期日休息\n星期一11:30–14:00 17:30–21:00\n星期二11:30–14:00 17:30–21:00\n星期三11:30–14:00 17:30–21:00\n星期四11:30–14:00 17:30–21:00\n星期五11:30–14:00 17:30–21:00\n星期六休息",
      "cuisine_type": "義式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f58d19722613965eb7e2f67-Papi-Pasta"
    },
    {
      "id": "605",
      "name": "小樂天餃子館",
      "address": "臺北市信義區忠孝東路五段151號1樓",
      "lng.": "121.5682762",
      "lat.": "25.04123443",
      "time":
          "星期日11:00–22:30\n星期一11:00–22:30\n星期二11:00–22:30\n星期三11:00–22:30\n星期四11:00–22:30\n星期五11:00–22:30\n星期六11:00–22:30",
      "cuisine_type": "台式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/55a50a2ac03a10241de642dd-小樂天餃子館"
    },
    {
      "id": "606",
      "name": "發起人肉骨茶",
      "address": "臺北市信義區松壽路12號5樓",
      "lng.": "121.5660632",
      "lat.": "25.03530575",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–23:00\n星期六11:00–23:00",
      "cuisine_type": "東南亞",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5d76f29a22613955026cc6d9-發起人肉骨茶"
    },
    {
      "id": "607",
      "name": "NENE CHICKEN信義誠品店",
      "address": "臺北市信義區松高路11號B2",
      "lng.": "121.5658761",
      "lat.": "25.03971633",
      "time":
          "星期日11:00–21:00\n星期一11:00–21:00\n星期二11:00–21:00\n星期三11:00–21:00\n星期四11:00–21:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "韓式",
      "rating": "2.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5be67b8323679c66b84b20d5-NeNe-Chicken"
    },
    {
      "id": "608",
      "name": "Salt and Stone",
      "address": "臺北市信義區市府路45號4樓",
      "lng.": "121.5644695",
      "lat.": "25.03396375",
      "time":
          "星期日11:30–14:20 14:30–16:30 17:30–22:00\n星期一11:30–14:20 14:30–16:30 17:30–22:00\n星期二11:30–14:20 14:30–16:30 17:30–22:00\n星期三11:30–14:20 14:30–16:30 17:30–22:00\n星期四11:30–14:20 14:30–16:30 17:30–22:00\n星期五11:30–14:20 14:30–16:30 17:30–22:00\n星期六11:30–14:20 14:30–16:30 17:30–22:00",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5f572a652756dd155d8e5958-Salt-and-Stone"
    },
    {
      "id": "609",
      "name": "D弐拾弐",
      "address": "臺北市信義區松智路17號6樓",
      "lng.": "121.5669899",
      "lat.": "25.03461565",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "港式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5cb5e5582756dd4141c0e243-D弐拾弐"
    },
    {
      "id": "610",
      "name": "胡饕米粉湯•黑白切 臺北市府店",
      "address": "臺北市信義區永吉路30巷158弄3號",
      "lng.": "121.5685664",
      "lat.": "25.04242724",
      "time":
          "星期日11:30–21:00\n星期一11:30–21:00\n星期二11:30–21:00\n星期三11:30–21:00\n星期四11:30–21:00\n星期五11:30–01:00\n星期六11:30–01:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d555f4d8c906d6cdb6d7e45-胡饕米粉湯•黑白切-臺北市府店"
    },
    {
      "id": "611",
      "name": "Osteria by Angie 信義微風",
      "address": "臺北市信義區忠孝東路五段68號4樓",
      "lng.": "121.5669214",
      "lat.": "25.04054598",
      "time":
          "星期日11:00–14:30 17:30–21:30\n星期一11:00–14:30 17:30–21:30\n星期二11:00–14:30 17:30–21:30\n星期三11:00–14:30 17:30–21:30\n星期四11:00–14:30 17:30–22:00\n星期五11:00–14:30 17:30–22:00\n星期六11:00–22:00",
      "cuisine_type": "義式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/56a8e7e42756dd3766b26942-Osteria-by-Angie-微風信"
    },
    {
      "id": "612",
      "name": "上悅龍記燒臘-臺北世貿店",
      "address": "臺北市信義區莊敬路279號",
      "lng.": "121.5629318",
      "lat.": "25.02892865",
      "time":
          "星期日休息\n星期一10:00–14:00 16:30–20:00\n星期二10:00–14:00 16:30–20:00\n星期三10:00–14:00 16:30–20:00\n星期四10:00–14:00 16:30–20:00\n星期五10:00–14:00 16:30–20:00\n星期六10:00–14:00 16:30–20:00",
      "cuisine_type": "港式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5af807042261392ca6fe45ee-上悅龍記燒臘-臺北世貿店"
    },
    {
      "id": "613",
      "name": "鴨肉謝",
      "address": "臺北市信義區永吉路30巷168弄2號",
      "lng.": "121.5687049",
      "lat.": "25.04187163",
      "time":
          "星期日休息\n星期一17:00–02:00\n星期二17:00–02:00\n星期三17:00–02:00\n星期四17:00–02:00\n星期五17:00–02:00\n星期六17:00–02:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/57b5bda7699b6e5b0b3c2a3f-鴨肉謝"
    },
    {
      "id": "614",
      "name": "馬蔬蔬蔬食Pizza",
      "address": "臺北市信義區莊敬路209-1號",
      "lng.": "121.5616524",
      "lat.": "25.03041117",
      "time":
          "星期日11:30–14:00 17:30–21:00\n星期一休息\n星期二11:30–14:00 17:30–21:00\n星期三11:30–14:00 17:30–21:00\n星期四11:30–14:00 17:30–21:00\n星期五11:30–14:00 17:30–21:00\n星期六11:30–14:00 17:30–21:00",
      "cuisine_type": "義式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5dafea9dd6895d7831f65948-馬蔬蔬蔬食Pizza"
    },
    {
      "id": "615",
      "name": "TGI FRIDAYS 星期五美式餐廳 信義餐廳",
      "address": "臺北市信義區忠孝東路五段8號2樓",
      "lng.": "121.5646564",
      "lat.": "25.04048532",
      "time":
          "星期日11:00–00:00\n星期一11:00–00:00\n星期二11:00–00:00\n星期三11:00–00:00\n星期四11:00–00:00\n星期五11:00–00:00\n星期六11:00–00:00",
      "cuisine_type": "美式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d6462c03a103ee86c6eaf-T.G.I.Friday's-星期五美式"
    },
    {
      "id": "616",
      "name": "金葉紅廚微風南山店",
      "address": "臺北市信義區松智路17號B2",
      "lng.": "121.5659578",
      "lat.": "25.03430421",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "中式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c40242b226139499c499b08-金葉紅廚-微風南山店"
    },
    {
      "id": "617",
      "name": "PapàRoy 義式手作料理",
      "address": "臺北市信義區忠孝東路四段553巷16弄10號",
      "lng.": "121.5635306",
      "lat.": "25.04254558",
      "time":
          "星期日11:30–14:30 18:00–21:30\n星期一休息\n星期二11:30–14:30\n星期三11:30–14:30 18:00–21:30\n星期四11:30–14:30 18:00–21:30\n星期五11:30–14:30 18:00–21:30\n星期六11:30–14:30 18:00–21:30",
      "cuisine_type": "義式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5f4b9d36226139638e0c2fb5-PapàRoy-義式手作料理"
    },
    {
      "id": "618",
      "name": "豆腐村 Tofu Village - Bellavita店",
      "address": "臺北市信義區松仁路28號B2",
      "lng.": "121.5676388",
      "lat.": "25.03961703",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:30\n星期六11:00–22:30",
      "cuisine_type": "韓式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55c8ec032756dd6313d5db51-豆腐村-Bellavita"
    },
    {
      "id": "619",
      "name": "日本 冰見海鮮丼 粋鮨 信義新光店",
      "address": "臺北市信義區松壽路11號",
      "lng.": "121.567236",
      "lat.": "25.03653965",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5d8884518c906d686b844b70-粋鮨"
    },
    {
      "id": "620",
      "name": "三隻小豬熱炒100",
      "address": "臺北市信義區松隆路22號",
      "lng.": "121.567213",
      "lat.": "25.04329837",
      "time":
          "星期日11:00–23:45\n星期一11:00–23:45\n星期二11:00–00:00\n星期三17:00–23:45\n星期四11:00–23:45\n星期五11:00–23:45\n星期六11:00–23:30",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/55a6099cc03a102ec14160e0-三隻小豬熱炒100"
    },
    {
      "id": "621",
      "name": "食令shabu",
      "address": "臺北市信義區市府路45號4樓",
      "lng.": "121.5641005",
      "lat.": "25.03349175",
      "time":
          "星期日11:30–14:30 17:30–21:30\n星期一11:30–14:30 17:30–21:30\n星期二11:30–14:30 17:30–21:30\n星期三11:30–14:30 17:30–21:30\n星期四11:30–14:30 17:30–21:30\n星期五11:30–14:30 17:30–22:00\n星期六11:30–14:30 17:30–22:00",
      "cuisine_type": "日式",
      "rating": "4.8",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info": "https://ifoodie.tw/restaurant/5f0fd39b02935e219f6c90e5-食令shabu"
    },
    {
      "id": "622",
      "name": "steak bistro 和洋",
      "address": "臺北市信義區松仁路58號3樓",
      "lng.": "121.5681315",
      "lat.": "25.0367109",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/5ea77bdb22613928cc3e5b03-steak-bistro-和洋"
    },
    {
      "id": "623",
      "name": "VJ.show義法餐廳",
      "address": "臺北市信義區忠孝東路四段553巷22弄5號1樓",
      "lng.": "121.5631406",
      "lat.": "25.04343481",
      "time":
          "星期日11:30–15:00 17:30–21:00\n星期一休息\n星期二休息\n星期三11:30–15:00 17:30–21:00\n星期四11:30–15:00 17:30–21:00\n星期五11:30–15:00 17:30–21:00\n星期六11:30–15:00 17:30–21:00",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d625aff2261391d6095aaa1-VJ.show義法餐廳"
    },
    {
      "id": "624",
      "name": "涮乃葉 信義店",
      "address": "臺北市信義區松仁路58號7樓",
      "lng.": "121.5676682",
      "lat.": "25.03685027",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5f8314e62756dd6b1ff56f85-涮乃葉-信義店"
    },
    {
      "id": "625",
      "name": "涮乃葉 統一時代市府店",
      "address": "臺北市信義區忠孝東路五段8號3樓",
      "lng.": "121.5649006",
      "lat.": "25.04060372",
      "time":
          "星期日11:00–23:30\n星期一11:00–23:30\n星期二11:00–23:30\n星期三11:00–23:30\n星期四11:00–23:30\n星期五11:00–00:00\n星期六11:00–00:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d8f6c742756dd79664a99e0-涮乃葉-統一時代市府店"
    },
    {
      "id": "626",
      "name": "五福餃子館",
      "address": "臺北市信義區基隆路一段147巷34-2號",
      "lng.": "121.56703",
      "lat.": "25.04229604",
      "time":
          "星期日休息\n星期一11:00–14:30 17:00–20:00\n星期二11:00–14:30 17:00–20:00\n星期三11:00–14:30 17:00–20:00\n星期四11:00–14:30 17:00–20:00\n星期五11:00–14:30 17:00–20:00\n星期六11:00–14:30 17:00–20:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/55a5ad95c03a10241de67a29-五福餃子館"
    },
    {
      "id": "627",
      "name": "太興茶餐廳 ATT 4 Fun信義店",
      "address": "臺北市信義區松壽路12號1樓",
      "lng.": "121.5660623",
      "lat.": "25.03530702",
      "time":
          "星期日10:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–23:00\n星期六10:00–23:00",
      "cuisine_type": "港式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e86b54ad6895d3ae65125c0-太興茶餐廳-ATT-4-Fun"
    },
    {
      "id": "628",
      "name": "In Between之間",
      "address": "臺北市信義區菸廠路98號",
      "lng.": "121.5618874",
      "lat.": "25.04444131",
      "time":
          "星期日12:00–15:00 18:00–22:00\n星期一休息\n星期二12:00–15:00 18:00–22:00\n星期三12:00–15:00 18:00–22:00\n星期四12:00–15:00 18:00–22:00\n星期五12:00–15:00 18:00–22:00\n星期六12:00–15:00 18:00–22:00",
      "cuisine_type": "美式",
      "rating": "3.9",
      "inout": ['內用'],
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/568cd77d699b6e30976abd94-In-Between之間"
    },
    {
      "id": "629",
      "name": "牛肉麵．雞湯 信義店",
      "address": "臺北市信義區松壽路26號",
      "lng.": "121.5676843",
      "lat.": "25.03526185",
      "time":
          "星期日11:30–04:00\n星期一11:30–04:00\n星期二11:30–04:00\n星期三11:30–04:00\n星期四11:30–04:00\n星期五11:30–04:00\n星期六11:30–04:00",
      "cuisine_type": "中式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e6a45c62756dd355a1d1834-牛肉麵%EF%BC%8E雞湯-信義店"
    },
    {
      "id": "630",
      "name": "泰昌餅家(統一時代市府店)",
      "address": "臺北市信義區忠孝東路五段8號B2",
      "lng.": "121.5649059",
      "lat.": "25.0405984",
      "time":
          "星期日07:30–21:30\n星期一07:30–21:30\n星期二07:30–21:30\n星期三07:30–21:30\n星期四07:30–21:30\n星期五07:30–22:00\n星期六07:30–22:00",
      "cuisine_type": "港式",
      "rating": "2.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/explore/臺北市/信義區/list?sortby=popular&page=48"
    },
    {
      "id": "631",
      "name": "犇 極上 BEN Teppan Suprême",
      "address": "臺北市信義區松廉路3號1樓",
      "lng.": "121.5668149",
      "lat.": "25.03430618",
      "time":
          "星期日12:00–14:00 18:00–21:30\n星期一12:00–14:00 18:00–21:30\n星期二12:00–14:00 18:00–21:30\n星期三12:00–14:00 18:00–21:30\n星期四12:00–14:00 18:00–21:30\n星期五12:00–14:00 18:00–22:00\n星期六12:00–14:00 18:00–22:00",
      "cuisine_type": "日式",
      "rating": "4.7",
      "inout": ['內用'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5f1fd65a02935e7663220b79-犇-極上-BEN-Teppan-Supr"
    },
    {
      "id": "632",
      "name": "洋朵義式廚坊-微風松高店",
      "address": "臺北市信義區松高路16號B2",
      "lng.": "121.5672801",
      "lat.": "25.03872313",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–22:00\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5cf5c51823679c3bb928e8d8-洋朵義式廚坊-微風松高店"
    },
    {
      "id": "633",
      "name": "SEOUL BISTRO",
      "address": "臺北市信義區松壽路11號B2",
      "lng.": "121.5672305",
      "lat.": "25.03601403",
      "time":
          "星期日11:30–21:30\n星期一11:30–21:30\n星期二11:30–21:30\n星期三11:30–21:30\n星期四11:30–21:30\n星期五11:00–22:00\n星期六11:00–22:00",
      "cuisine_type": "韓式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5924791d2756dd3fdd9396dc-SEOUL-BISTRO"
    },
    {
      "id": "634",
      "name": "禾羽軒壽司",
      "address": "臺北市信義區基隆路一段101巷28號",
      "lng.": "121.5679319",
      "lat.": "25.04427037",
      "time":
          "星期日12:00–14:00 18:00–21:00\n星期一休息\n星期二12:00–14:00 18:00–21:00\n星期三12:00–14:00 18:00–21:00\n星期四12:00–14:00 18:00–21:00\n星期五12:00–14:00 18:00–21:00\n星期六12:00–14:00 18:00–21:00",
      "cuisine_type": "日式",
      "rating": "4.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5f63712b2756dd6ac6803b02-禾羽軒壽司"
    },
    {
      "id": "635",
      "name": "The Chapter",
      "address": "臺北市信義區菸廠路98號",
      "lng.": "121.5619458",
      "lat.": "25.04443753",
      "time":
          "星期日06:30–22:00\n星期一06:30–22:00\n星期二06:30–22:00\n星期三06:30–22:00\n星期四06:30–22:00\n星期五06:30–22:00\n星期六06:30–22:00",
      "cuisine_type": "美式",
      "rating": "3.9",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/599338d02756dd4699570746-The-Chapter"
    },
    {
      "id": "636",
      "name": "大叔食事2.0",
      "address": "臺北市信義區忠孝東路四段553巷16弄3號",
      "lng.": "121.5631599",
      "lat.": "25.04281302",
      "time":
          "星期日11:30–20:30\n星期一11:30–13:30 17:30–20:30\n星期二11:30–13:30 17:30–20:30\n星期三11:30–13:30 17:30–20:30\n星期四11:30–13:30 17:30–20:30\n星期五11:30–13:30 17:30–20:30\n星期六11:30–20:30",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info": "https://ifoodie.tw/restaurant/5faaa821d6895d6691b7857b-大叔食事2.0"
    },
    {
      "id": "637",
      "name": "小鼎膾",
      "address": "臺北市信義區松仁路28號",
      "lng.": "121.567641",
      "lat.": "25.03961995",
      "time":
          "星期日11:00–22:00\n星期一11:00–22:00\n星期二11:00–22:00\n星期三11:00–22:00\n星期四11:00–22:00\n星期五11:00–22:30\n星期六11:00–22:30",
      "cuisine_type": "日式",
      "rating": "3.9",
      "inout": ['內用'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5cb6ac7223679c3aa35737a0-小鼎膾"
    },
    {
      "id": "638",
      "name": "鼎泰豐 新光A4店",
      "address": "臺北市信義區松高路19號B2",
      "lng.": "121.566592",
      "lat.": "25.03956817",
      "time":
          "星期日11:00–21:30\n星期一11:00–21:30\n星期二11:00–21:30\n星期三11:00–21:30\n星期四11:00–21:30\n星期五11:00–21:30\n星期六11:00–21:30",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/57716c802756dd5159c807a8-鼎泰豐"
    },
    {
      "id": "639",
      "name": "貓空觀鼎茶園-枝仔冰城",
      "address": "臺北市文山區指南路三段38巷16號",
      "lng.": "121.587659",
      "lat.": "24.969037",
      "cuisine_type": "飲料",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/602156848c906d47e852507e-%E8%B2%93%E7%A9%BA%E8%A7%80%E9%BC%8E%E8%8C%B6%E5%9C%92-%E6%9E%9D%E4%BB%94%E5%86%B0%E5%9F%8E"
    },
    {
      "id": "640",
      "name": "貓空 四爺",
      "address": "臺北市文山區指南路三段38巷16之2號",
      "lng.": "121.5880029",
      "lat.": "24.9681043",
      "time": "10:30-22:00",
      "cuisine_type": "台式|日式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d5de620d6895d74cfdce286-%E8%B2%93%E7%A9%BA-%E5%9B%9B%E7%88%BA"
    },
    {
      "id": "641",
      "name": "好鍋1+1",
      "address": "臺北市文山區興隆路三段112巷2弄17號",
      "lng.": "121.5565486",
      "lat.": "24.999163",
      "time": "11:00-00:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5efc87d422613945fabd56cc-%E5%A5%BD%E9%8D%8B1%2B1"
    },
    {
      "id": "642",
      "name": "無招牌麵飯店",
      "address": "臺北市文山區木柵路四段74號",
      "lng.": "121.574357",
      "lat.": "24.99775",
      "time": "10:30-19:30",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/601ff7be2756dd4e15c8f964-%E7%84%A1%E6%8B%9B%E7%89%8C%E9%BA%B5%E9%A3%AF%E5%BA%97"
    },
    {
      "id": "643",
      "name": "廖家祖傳秘方紅糟肉",
      "address": "臺北市文山區景美街127之79號",
      "lng.": "121.541448",
      "lat.": "24.9898213",
      "time": "08:30-12:30",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e8f2f822756dd191855cc42-%E5%BB%96%E5%AE%B6%E7%A5%96%E5%82%B3%E7%A7%98%E6%96%B9%E7%B4%85%E7%B3%9F%E8%82%89"
    },
    {
      "id": "644",
      "name": "福鼎湯包店",
      "address": "臺北市文山區興隆路三段112巷2弄13號",
      "lng.": "121.5566935",
      "lat.": "24.9991747",
      "time": "07:00-21:30",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d1516c03a103ee86c3b8c-%E7%A6%8F%E9%BC%8E%E6%B9%AF%E5%8C%85%E5%BA%97"
    },
    {
      "id": "645",
      "name": "光羽塩 Lytea",
      "address": "臺北市文山區指南路三段38巷14之2號",
      "lng.": "121.5867214",
      "lat.": "24.9700959",
      "time": "11:00-00:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c1cf7382756dd6a78db12c7-%E5%85%89%E7%BE%BD%E5%A1%A9-Lytea"
    },
    {
      "id": "646",
      "name": "PIZZA HUT必勝客",
      "address": "臺北市文山區景興路193號",
      "lng.": "121.5442847",
      "lat.": "24.99241",
      "time": "11:00-21:30",
      "cuisine_type": "義式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5621402e2756dd74717fb015-PIZZA-HUT%E5%BF%85%E5%8B%9D%E5%AE%A2"
    },
    {
      "id": "647",
      "name": "越來越pho",
      "address": "臺北市文山區羅斯福路五段281號",
      "lng.": "121.5396498",
      "lat.": "25.0008277",
      "time": "11:30-13:50, 17:30-21:00",
      "cuisine_type": "東南亞",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c6a52e2f5246839bcb02bae-%E8%B6%8A%E4%BE%86%E8%B6%8Apho"
    },
    {
      "id": "648",
      "name": "貓空 找茶屋 found.your.tea",
      "address": "臺北市文山區指南路三段38巷33之5號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "12:00-21:00",
      "cuisine_type": "台式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f451eb42756dd2484d7e146-%E8%B2%93%E7%A9%BA-%E6%89%BE%E8%8C%B6%E5%B1%8B-found.your.te"
    },
    {
      "id": "649",
      "name": "德意事歐式美食屋",
      "address": "臺北市文山區木新路三段97號",
      "lng.": "121.5627893",
      "lat.": "24.9820278",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "德式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/55a59b30c03a10241de67474-%E5%BE%B7%E6%84%8F%E4%BA%8B%E6%AD%90%E5%BC%8F%E7%BE%8E%E9%A3%9F%E5%B1%8B"
    },
    {
      "id": "650",
      "name": "狸奴 LI-NU",
      "address": "臺北市文山區興隆路三段231號",
      "lng.": "121.5592252",
      "lat.": "24.9933762",
      "rating": "4",
      "cuisine_type": "中式|美式|歐式",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/600532d42261394835d34a5f-%E7%8B%B8%E5%A5%B4-LI-NU"
    },
    {
      "id": "651",
      "name": "巷仔內米粉湯",
      "address": "臺北市文山區景美街119號",
      "lng.": "121.5413679",
      "lat.": "24.9899102",
      "time": "18:00-00:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5beffc03a10241de67f8c-%E5%B7%B7%E4%BB%94%E5%85%A7%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "652",
      "name": "星靚點花園飯店",
      "address": "臺北市文山區景後街81號",
      "lng.": "121.5435223",
      "lat.": "24.9919951",
      "time": "10:00-22:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5feb19c9d6895d5cb8c6fb0f-%E6%98%9F%E9%9D%9A%E9%BB%9E%E8%8A%B1%E5%9C%92%E9%A3%AF%E5%BA%97"
    },
    {
      "id": "653",
      "name": "香港珍園燒臘店",
      "address": "臺北市文山區興隆路三段176號",
      "lng.": "121.5585696",
      "lat.": "24.998053",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "港式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ffdb0732756dd705ee292e6-%E9%A6%99%E6%B8%AF%E7%8F%8D%E5%9C%92%E7%87%92%E8%87%98%E5%BA%97"
    },
    {
      "id": "654",
      "name": "鴻記石鍋",
      "address": "臺北市文山區興隆路四段130號",
      "lng.": "121.5622009",
      "lat.": "24.9824113",
      "time": "17:30-21:30",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fe74e8002935e671887ab26-%E9%B4%BB%E8%A8%98%E7%9F%B3%E9%8D%8B"
    },
    {
      "id": "655",
      "name": "Spyci私宅咖哩炸雞店",
      "address": "臺北市文山區景興路30之1號",
      "lng.": "121.54454",
      "lat.": "24.997384",
      "time": "15:00-22:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59c15e3a2756dd528db72d62-Spyci%E7%A7%81%E5%AE%85%E5%92%96%E5%93%A9%E7%82%B8%E9%9B%9E%E5%BA%97"
    },
    {
      "id": "656",
      "name": "清原芋圓—臺北景美店",
      "address": "臺北市文山區景華街67號",
      "lng.": "121.5449871",
      "lat.": "24.9952522",
      "time": "10:30-22:00",
      "cuisine_type": "飲料",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe3528d2756dd79fdc48365-%E6%B8%85%E5%8E%9F%E8%8A%8B%E5%9C%93%E2%80%94%E5%8F%B0%E5%8C%97%E6%99%AF%E7%BE%8E%E5%BA%97"
    },
    {
      "id": "657",
      "name": "胖夫妻日式料理",
      "address": "臺北市文山區興隆路三段36巷6號",
      "lng.": "121.5552827",
      "lat.": "25.000191",
      "time": "11:00-14:30, 17:30-21:00",
      "cuisine_type": "日本",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fe1ad488c906d2bdcc0fffd-%E8%83%96%E5%A4%AB%E5%A6%BB%E6%97%A5%E5%BC%8F%E6%96%99%E7%90%86"
    },
    {
      "id": "658",
      "name": "景美夜市炸三鮮/米粉湯",
      "address": "臺北市文山區景美街119號",
      "lng.": "121.5413679",
      "lat.": "24.9899102",
      "time": "16:00-22:30",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f621f902756dd3c89419a4f-%E6%99%AF%E7%BE%8E%E5%A4%9C%E5%B8%82%E7%82%B8%E4%B8%89%E9%AE%AE%2F%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "659",
      "name": "李白Breakfast x coffee",
      "address": "臺北市文山區萬壽路25巷7號1樓",
      "lng.": "121.5761242",
      "lat.": "24.988972",
      "time": "07:00-15:00",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe00b73d6895d5b179483c2-%E6%9D%8E%E7%99%BDBreakfast-x-coffee"
    },
    {
      "id": "660",
      "name": "夜奔咖哩 Fleeingbynightcurry",
      "address": "臺北市文山區景文街19號",
      "lng.": "121.54143",
      "lat.": "24.992661",
      "time": "17:00-22:00",
      "cuisine_type": "日式|中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ab854a223679c276511fbcf-%E5%A4%9C%E5%A5%94%E5%92%96%E5%93%A9-Fleeingbynightc"
    },
    {
      "id": "661",
      "name": "肉多多火鍋-臺北景美店",
      "address": "臺北市文山區景文街42號2樓號",
      "lng.": "121.5411941",
      "lat.": "24.9917264",
      "time": "00:00-04:00, 11:30-15:00, 17:30-00:00",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ad788bf2756dd41bce10a2a-%E8%82%89%E5%A4%9A%E5%A4%9A%E7%81%AB%E9%8D%8B-%E5%8F%B0%E5%8C%97%E6%99%AF%E7%BE%8E%E5%BA%97"
    },
    {
      "id": "662",
      "name": "爐子煮賣所 Forno & Stufa",
      "address": "臺北市文山區汀州路四段132號",
      "lng.": "121.5357441",
      "lat.": "25.00542",
      "time": "11:30-14:30, 17:30-20:30",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/598ca0b12756dd407aa87a36-%E7%88%90%E5%AD%90%E7%85%AE%E8%B3%A3%E6%89%80-Forno-%26-Stufa"
    },
    {
      "id": "663",
      "name": "晟豐北斗肉圓",
      "address": "臺北市文山區景隆街10號",
      "lng.": "121.540246",
      "lat.": "25.0000366",
      "time": "11:30-20:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fd774f32756dd3b52ec765c-%E6%99%9F%E8%B1%90%E5%8C%97%E6%96%97%E8%82%89%E5%9C%93"
    },
    {
      "id": "664",
      "name": "滇味廚房",
      "address": "臺北市文山區指南路二段167號",
      "lng.": "121.5776291",
      "lat.": "24.9874019",
      "time": "11:00-21:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57127f122756dd066e9d3800-%E6%BB%87%E5%91%B3%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "665",
      "name": "如意豆漿店",
      "address": "臺北市文山區忠順街一段119號",
      "lng.": "121.5598926",
      "lat.": "24.9843205",
      "time": "05:00-11:00",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": "內用|",
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56aa57872756dd600d5e5900-%E5%A6%82%E6%84%8F%E8%B1%86%E6%BC%BF%E5%BA%97"
    },
    {
      "id": "666",
      "name": "辛王記涼麵美食專賣店",
      "address": "臺北市文山區木柵路三段3號",
      "lng.": "121.564606",
      "lat.": "24.988598",
      "time": "11:00-21:00",
      "cuisine_type": "台式|日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fd4d22c2756dd406822b654-%E8%BE%9B%E7%8E%8B%E8%A8%98%E6%B6%BC%E9%BA%B5%E7%BE%8E%E9%A3%9F%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "667",
      "name": "鵝媽媽鵝肉切仔麵",
      "address": "臺北市文山區景美街37之3號",
      "lng.": "121.5418094",
      "lat.": "24.9915751",
      "time": "15:00-23:30",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d1a80c03a103ee86c3ed7-%E9%B5%9D%E5%AA%BD%E5%AA%BD%E9%B5%9D%E8%82%89%E5%88%87%E4%BB%94%E9%BA%B5"
    },
    {
      "id": "668",
      "name": "成家小館",
      "address": "臺北市文山區木新路三段154號",
      "lng.": "121.5612754",
      "lat.": "24.9819877",
      "time": "11:30-13:30, 17:00-21:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5545cc03a10241de65cab-%E6%88%90%E5%AE%B6%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "669",
      "name": "貓空清泉山莊",
      "address": "臺北市文山區指南路三段38巷33之3號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "10:00-21:00",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e0ecb3f8c906d485fc4b686-%E8%B2%93%E7%A9%BA%E6%B8%85%E6%B3%89%E5%B1%B1%E8%8E%8A"
    },
    {
      "id": "670",
      "name": "MAG麵革",
      "address": "臺北市文山區福興路36號",
      "lng.": "121.5509422",
      "lat.": "25.0031282",
      "time": "11:30-21:00",
      "cuisine_type": "義式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fac9f5d2261396bcb7b6baa-MAG%E9%BA%B5%E9%9D%A9"
    },
    {
      "id": "671",
      "name": "生活在他方-夜貓店",
      "address": "臺北市文山區指南路三段40巷8之5號",
      "lng.": "121.5949951",
      "lat.": "24.9689748",
      "time": "12:00-00:00",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5eb56b1f2756dd0ba876909f-%E7%94%9F%E6%B4%BB%E5%9C%A8%E4%BB%96%E6%96%B9-%E5%A4%9C%E8%B2%93%E5%BA%97"
    },
    {
      "id": "672",
      "name": "黑碗豆花",
      "address": "臺北市文山區木柵路二段197號",
      "lng.": "121.563882",
      "lat.": "24.9888687",
      "time": "12:00-19:00",
      "cuisine_type": "飲料",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fb3dc882756dd3ffeb9049a-%E9%BB%91%E7%A2%97%E8%B1%86%E8%8A%B1"
    },
    {
      "id": "673",
      "name": "石川日式食堂",
      "address": "臺北市文山區景華街60號",
      "lng.": "121.5443195",
      "lat.": "24.9949778",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "日本",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/595541d12756dd4ec3f45117-%E7%9F%B3%E5%B7%9D%E6%97%A5%E5%BC%8F%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "674",
      "name": "江記水盆羊肉",
      "address": "臺北市文山區指南路二段45巷12號",
      "lng.": "121.574557",
      "lat.": "24.988768",
      "time": "11:30-14:00, 17:00-20:30",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d9e09c03a103ee86c910c-%E6%B1%9F%E8%A8%98%E6%B0%B4%E7%9B%86%E7%BE%8A%E8%82%89"
    },
    {
      "id": "675",
      "name": "Ruins Coffee Roasters",
      "address": "臺北市文山區木柵路三段242號",
      "lng.": "121.5710487",
      "lat.": "24.9907558",
      "time": "13:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/582f43af2756dd2cb59c9ae5-Ruins-Coffee-Roaster"
    },
    {
      "id": "676",
      "name": "墨•山崴-MORE‧shan wei",
      "address": "臺北市文山區羅斯福路五段215號",
      "lng.": "121.539124",
      "lat.": "25.002185",
      "cuisine_type": "台式|日式|歐式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5edf277ad6895d37bdc03ee0-%E5%A2%A8%E2%80%A2%E5%B1%B1%E5%B4%B4-MORE%E2%80%A7shan-wei"
    },
    {
      "id": "677",
      "name": "兩盞燈食試所 X 大毛陶磁器",
      "address": "臺北市文山區羅斯福路六段310號2樓",
      "lng.": "121.539649",
      "lat.": "24.990558",
      "time": "暫時無資訊",
      "cuisine_type": "飲料|日式|美式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bf418c82756dd4b96d3ef3b-%E5%85%A9%E7%9B%9E%E7%87%88%E9%A3%9F%E8%A9%A6%E6%89%80-X-%E5%A4%A7%E6%AF%9B%E9%99%B6%E7%A3%81%E5%99%A8"
    },
    {
      "id": "678",
      "name": "陶媽大餛飩/水餃",
      "address": "臺北市文山區育英街5號",
      "lng.": "121.5394124",
      "lat.": "24.9904532",
      "time": "11:00-20:00",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5faeb21a02935e22d67b09a8-%E9%99%B6%E5%AA%BD%E5%A4%A7%E9%A4%9B%E9%A3%A9%2F%E6%B0%B4%E9%A4%83"
    },
    {
      "id": "679",
      "name": "PATIO46 美式餐廳",
      "address": "臺北市文山區興隆路三段112巷4弄46號1樓號",
      "lng.": "121.5557477",
      "lat.": "24.9993247",
      "time": "11:00-21:00",
      "cuisine_type": "美式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bfb94a5226139568f6491c7-PATIO46-%E7%BE%8E%E5%BC%8F%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "680",
      "name": "5senses cafe",
      "address": "臺北市文山區興隆路三段112巷2弄25號",
      "lng.": "121.5562851",
      "lat.": "24.9993494",
      "time": "12:00-20:30",
      "cuisine_type": "咖啡",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55d76a6f2756dd0b3b8dbb1f-5senses-cafe"
    },
    {
      "id": "681",
      "name": "巷仔內傳統碳燒豆花專賣店",
      "address": "臺北市文山區興隆路三段304巷11號",
      "lng.": "121.5584137",
      "lat.": "24.9934827",
      "time": "15:00-21:00",
      "cuisine_type": "飲料",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f9c217a2756dd2d99d34a1a-%E5%B7%B7%E4%BB%94%E5%85%A7%E5%82%B3%E7%B5%B1%E7%A2%B3%E7%87%92%E8%B1%86%E8%8A%B1%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "682",
      "name": "滕老私廚",
      "address": "臺北市文山區木新路三段403號",
      "lng.": "121.554528",
      "lat.": "24.979967",
      "time": "12:00-21:00",
      "cuisine_type": "中式",
      "rating": "3.7",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56568491699b6e098414dc10-%E6%BB%95%E8%80%81%E7%A7%81%E5%BB%9A"
    },
    {
      "id": "683",
      "name": "富貴饅頭",
      "address": "臺北市文山區辛亥路五段15號",
      "lng.": "121.5544345",
      "lat.": "25.0001795",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f8ce2062261394a508ab012-%E5%AF%8C%E8%B2%B4%E9%A5%85%E9%A0%AD"
    },
    {
      "id": "684",
      "name": "鼎豐鴛鴦麻辣火鍋",
      "address": "臺北市文山區羅斯福路四段200號",
      "lng.": "121.5365841",
      "lat.": "25.0106968",
      "time": "11:30-23:45",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5caeaf8bf5246874dd81196b-%E9%BC%8E%E8%B1%90%E9%B4%9B%E9%B4%A6%E9%BA%BB%E8%BE%A3%E7%81%AB%E9%8D%8B"
    },
    {
      "id": "685",
      "name": "雞老闆 桶仔雞 萬隆店",
      "address": "臺北市文山區羅斯福路五段69號",
      "lng.": "121.539205",
      "lat.": "25.006343",
      "time": "00:00-02:30, 17:00-00:00",
      "cuisine_type": "台式|日式|餐酒館/酒吧",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d35194ad6895d079b93976c-%E9%9B%9E%E8%80%81%E9%97%86-%E6%A1%B6%E4%BB%94%E9%9B%9E-%E8%90%AC%E9%9A%86%E5%BA%97"
    },
    {
      "id": "686",
      "name": "麥味登文山饗食大亨店(羅斯福饗食大亨)",
      "address": "臺北市文山區羅斯福路五段218巷25號一樓",
      "lng.": "121.5375974",
      "lat.": "25.0020335",
      "time": "06:00-20:00",
      "cuisine_type": "日式|台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f5e3f072261393d9cee0b08-%E9%BA%A5%E5%91%B3%E7%99%BB%E6%96%87%E5%B1%B1%E9%A5%97%E9%A3%9F%E5%A4%A7%E4%BA%A8%E5%BA%97(%E7%BE%85%E6%96%AF%E7%A6%8F%E9%A5%97%E9%A3%9F%E5%A4%A7%E4%BA%A8)"
    },
    {
      "id": "687",
      "name": "富察號",
      "address": "臺北市文山區忠順街一段26巷11弄2號",
      "lng.": "121.559622",
      "lat.": "24.982927",
      "time": "14:00-21:00",
      "cuisine_type": "飲料",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ed270102756dd5139e6a039-%E5%AF%8C%E5%AF%9F%E8%99%9F"
    },
    {
      "id": "688",
      "name": "龍哥食堂",
      "address": "臺北市文山區萬慶街17號",
      "lng.": "121.5397623",
      "lat.": "24.9923824",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "日本",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f534dc902935e289d74c9bd-%E9%BE%8D%E5%93%A5%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "689",
      "name": "雪敲 Ice Climber",
      "address": "臺北市文山區指南路三段38巷33之2號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "11:00-18:00",
      "cuisine_type": "飲料",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f4f6674d6895d52294fa3d2-%E9%9B%AA%E6%95%B2-Ice-Climber"
    },
    {
      "id": "690",
      "name": "TDH 貓茶町 下午茶",
      "address": "臺北市文山區保儀路115號",
      "lng.": "121.5676709",
      "lat.": "24.985714",
      "time": "10:00-20:00",
      "cuisine_type": "飲料",
      "rating": "4.1",
      "inout": "內用|",
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a537cfc03a10241de652c4-TDH-%E8%B2%93%E8%8C%B6%E7%94%BA-%E4%B8%8B%E5%8D%88%E8%8C%B6"
    },
    {
      "id": "691",
      "name": "CAFE巷",
      "address": "臺北市文山區指南路三段38巷33之5號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "10:00-19:30",
      "cuisine_type": "咖啡",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5936ef1d2756dd5f7e556a8f-CAFE%E5%B7%B7"
    },
    {
      "id": "692",
      "name": "開源社雞排 木新店",
      "address": "臺北市文山區木新路三段269號",
      "lng.": "121.5581456",
      "lat.": "24.9809189",
      "time": "00:00-01:00, 15:00-00:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ea5bcb12261393a0e7c2932-%E9%96%8B%E6%BA%90%E7%A4%BE%E9%9B%9E%E6%8E%92-%E6%9C%A8%E6%96%B0%E5%BA%97"
    },
    {
      "id": "693",
      "name": "景美祖傳牛肉麵",
      "address": "臺北市文山區景文街133號",
      "lng.": "121.541162",
      "lat.": "24.990145",
      "time": "11:00-20:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fead93402935e5673b7eb83-%E6%99%AF%E7%BE%8E%E7%A5%96%E5%82%B3%E7%89%9B%E8%82%89%E9%BA%B5"
    },
    {
      "id": "694",
      "name": "紅木屋休閒茶館",
      "address": "臺北市文山區指南路三段38巷33號",
      "lng.": "121.590704",
      "lat.": "24.9671039",
      "time": "10:30-21:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d77a4c03a103ee86c7c2b-%E7%B4%85%E6%9C%A8%E5%B1%8B%E4%BC%91%E9%96%92%E8%8C%B6%E9%A4%A8"
    },
    {
      "id": "695",
      "name": "食旅光廚房",
      "address": "臺北市文山區萬美街一段19巷5號後棟",
      "lng.": "121.5691763",
      "lat.": "25.0015902",
      "time": "00:00-06:00, 08:30-18:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f310f6dd6895d2d616528c8-%E9%A3%9F%E6%97%85%E5%85%89%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "696",
      "name": "黑牛穆場牛排館",
      "address": "臺北市文山區興隆路三段112巷2弄10號1",
      "lng.": "121.5569279",
      "lat.": "24.9992523",
      "time": "11:00-14:30, 17:00-21:00",
      "cuisine_type": "美式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5cebf2b62756dd3eeb8ff130-%E9%BB%91%E7%89%9B%E7%A9%86%E5%A0%B4%E7%89%9B%E6%8E%92%E9%A4%A8"
    },
    {
      "id": "697",
      "name": "辣椒多一點-麻辣鍋物",
      "address": "臺北市文山區興隆路二段245號",
      "lng.": "121.5514581",
      "lat.": "25.0019909",
      "time": "17:00-23:00",
      "cuisine_type": "中式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5dc2111d8c906d1860bd3fef-%E8%BE%A3%E6%A4%92%E5%A4%9A%E4%B8%80%E9%BB%9E-%E9%BA%BB%E8%BE%A3%E9%8D%8B%E7%89%A9"
    },
    {
      "id": "698",
      "name": "Portafiltro Coffee。撥啡",
      "address": "臺北市文山區興隆路三段290號",
      "lng.": "121.5596705",
      "lat.": "24.9956412",
      "time": "07:30-17:00",
      "cuisine_type": "咖啡",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f2380dd8c906d6cd91a5ce9-Portafiltro-Coffee%E3%80%82%E6%92%A5"
    },
    {
      "id": "699",
      "name": "棋盤角法式甜點",
      "address": "臺北市文山區興隆路三段192巷2弄3號1樓",
      "lng.": "121.558209",
      "lat.": "24.997929",
      "time": "13:00-19:00",
      "cuisine_type": "歐式|日式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f2183ad8c906d42d14f92da-%E6%A3%8B%E7%9B%A4%E8%A7%92%E6%B3%95%E5%BC%8F%E7%94%9C%E9%BB%9E"
    },
    {
      "id": "700",
      "name": "邀月茶坊",
      "address": "臺北市文山區指南路三段40巷6號",
      "lng.": "121.597309",
      "lat.": "24.96743",
      "time": "24小時營業",
      "cuisine_type": "飲料|台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/55a67c1ec03a104df53ca5ef-%E9%82%80%E6%9C%88%E8%8C%B6%E5%9D%8A"
    },
    {
      "id": "701",
      "name": "老娘米粉湯",
      "address": "臺北市文山區木柵路一段227號",
      "lng.": "121.5519778",
      "lat.": "24.9879111",
      "time": "17:00-00:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5e65ac03a102ec14155ed-%E8%80%81%E5%A8%98%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "702",
      "name": "聰明油飯",
      "address": "臺北市文山區景美街45號",
      "lng.": "121.5421518",
      "lat.": "24.9913326",
      "time": "15:30-23:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f0b36ed22613969e552ed04-%E8%81%B0%E6%98%8E%E6%B2%B9%E9%A3%AF"
    },
    {
      "id": "703",
      "name": "肉匠爺漢堡專賣店",
      "address": "臺北市文山區興隆路三段36巷15弄12號滷味旁",
      "lng.": "121.5555386",
      "lat.": "24.9995663",
      "time": "11:50-22:30",
      "cuisine_type": "美式",
      "rating": "4.6",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f09d3b52261393c665397e5-%E8%82%89%E5%8C%A0%E7%88%BA%E6%BC%A2%E5%A0%A1%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "704",
      "name": "獨特花生湯",
      "address": "臺北市文山區興隆路一段293號",
      "lng.": "121.544759",
      "lat.": "24.9988299",
      "time": "00:00-10:30, 21:00-00:00",
      "cuisine_type": "飲料",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a53025c03a10241de64fe3-%E7%8D%A8%E7%89%B9%E8%8A%B1%E7%94%9F%E6%B9%AF"
    },
    {
      "id": "705",
      "name": "CelloBakery 千樂手作",
      "address": "臺北市文山區木柵路一段269號",
      "lng.": "121.5534212",
      "lat.": "24.9881645",
      "time": "16:00-19:00",
      "cuisine_type": "飲料|日式|歐式|美式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/564cbe5f2756dd71d63f5cd6-CelloBakery-%E5%8D%83%E6%A8%82%E6%89%8B%E4%BD%9C"
    },
    {
      "id": "706",
      "name": "印尼小吃",
      "address": "臺北市文山區辛亥路五段25巷1號",
      "lng.": "121.5544497",
      "lat.": "24.9999092",
      "time": "08:00-19:00",
      "cuisine_type": "東南亞",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a67f35c03a104df53ca6c9-%E5%8D%B0%E5%B0%BC%E5%B0%8F%E5%90%83"
    },
    {
      "id": "707",
      "name": "獨特牛排館",
      "address": "臺北市文山區景美街92號",
      "lng.": "121.5412896",
      "lat.": "24.9896134",
      "time": "12:00-13:30, 17:00-21:30",
      "cuisine_type": "美式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57112de32756dd37a7fda759-%E7%8D%A8%E7%89%B9%E7%89%9B%E6%8E%92%E9%A4%A8"
    },
    {
      "id": "708",
      "name": "景美豆花",
      "address": "臺北市文山區景美街",
      "lng.": "121.5416403",
      "lat.": "24.9916431",
      "time": "00:00-00:30, 16:00-00:00",
      "cuisine_type": "飲料",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a50a36c03a10241de642e4-%E6%99%AF%E7%BE%8E%E8%B1%86%E8%8A%B1"
    },
    {
      "id": "709",
      "name": "邱家碳烤鹽酥雞",
      "address": "臺北市文山區興隆路二段220巷18號",
      "lng.": "121.5522475",
      "lat.": "25.0006501",
      "time": "15:00-23:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f9a343002935e023a3d59e2-%E9%82%B1%E5%AE%B6%E7%A2%B3%E7%83%A4%E9%B9%BD%E9%85%A5%E9%9B%9E"
    },
    {
      "id": "710",
      "name": "112巷牛排",
      "address": "臺北市文山區興隆路三段112巷2弄26號",
      "lng.": "121.5564663",
      "lat.": "24.9995319",
      "time": "11:00-21:00",
      "cuisine_type": "美式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5baa123723679c6c9d9a8185-112%E5%B7%B7%E7%89%9B%E6%8E%92"
    },
    {
      "id": "711",
      "name": "咖啡這件小事Coffee Little Things",
      "address": "臺北市文山區試院路58號之5號",
      "lng.": "121.549349",
      "lat.": "24.989552",
      "time": "10:45-19:45",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5edf9b3d2756dd46d0f26489-%E5%92%96%E5%95%A1%E9%80%99%E4%BB%B6%E5%B0%8F%E4%BA%8BCoffee-Little-"
    },
    {
      "id": "712",
      "name": "三三活力早餐店",
      "address": "臺北市文山區木新路三段122號",
      "lng.": "121.5620886",
      "lat.": "24.9821411",
      "time": "06:30-12:30",
      "cuisine_type": "台式|日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d7ea1c03a103ee86c8046-%E4%B8%89%E4%B8%89%E6%B4%BB%E5%8A%9B%E6%97%A9%E9%A4%90%E5%BA%97"
    },
    {
      "id": "713",
      "name": "Old Ginger Cafe & Vintage 老薑咖啡",
      "address": "臺北市文山區指南路三段6號",
      "lng.": "121.5798858",
      "lat.": "24.98519",
      "time": "13:00-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5eda0b932261393a633198b5-Old-Ginger-Cafe-%26-Vi"
    },
    {
      "id": "714",
      "name": "阿義師的大茶壺茶餐廳",
      "address": "臺北市文山區指南路三段38巷37之1號",
      "lng.": "121.5918065",
      "lat.": "24.9686888",
      "time": "10:00-22:00",
      "cuisine_type": "港式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a53a8dc03a10241de653c1-%E9%98%BF%E7%BE%A9%E5%B8%AB%E7%9A%84%E5%A4%A7%E8%8C%B6%E5%A3%BA%E8%8C%B6%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "715",
      "name": "A Mini Bistro。小館",
      "address": "臺北市文山區辛亥路四段101巷13弄2號",
      "lng.": "121.560122",
      "lat.": "25.006532",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "義式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57efc820699b6e36353e9477-A-Mini-Bistro%E3%80%82%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "716",
      "name": "佳香點心大王",
      "address": "臺北市文山區羅斯福路六段142巷255號",
      "lng.": "121.5410762",
      "lat.": "24.9959645",
      "time": "04:00-11:15",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b2d3b5f2756dd6d1c978ed9-%E4%BD%B3%E9%A6%99%E9%BB%9E%E5%BF%83%E5%A4%A7%E7%8E%8B"
    },
    {
      "id": "717",
      "name": "景美無名米粉湯",
      "address": "臺北市文山區興隆路二段130巷2號",
      "lng.": "121.5503945",
      "lat.": "25.0003444",
      "time": "06:30-13:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ebab1202756dd5ff25cbca2-%E6%99%AF%E7%BE%8E%E7%84%A1%E5%90%8D%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "718",
      "name": "徐老爹涼麵專賣",
      "address": "臺北市文山區景文街69號",
      "lng.": "121.5415163",
      "lat.": "24.9914521",
      "time": "暫時無資訊",
      "cuisine_type": "台式|日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe9abe802935e2d1f75b374-%E5%BE%90%E8%80%81%E7%88%B9%E6%B6%BC%E9%BA%B5%E5%B0%88%E8%B3%A3"
    },
    {
      "id": "719",
      "name": "張媽媽香大雞排",
      "address": "臺北市文山區景後街83號",
      "lng.": "121.5431171",
      "lat.": "24.9922915",
      "time": "15:00-21:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5eb80ded2756dd7fef6a3680-%E5%BC%B5%E5%AA%BD%E5%AA%BD%E9%A6%99%E5%A4%A7%E9%9B%9E%E6%8E%92"
    },
    {
      "id": "720",
      "name": "雪球咖啡 景美店",
      "address": "臺北市文山區景文街13之2號",
      "lng.": "121.5415407",
      "lat.": "24.9933776",
      "time": "07:00-14:00",
      "cuisine_type": "咖啡",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ec1486a2756dd19cbdacf4f-%E9%9B%AA%E7%90%83%E5%92%96%E5%95%A1-%E6%99%AF%E7%BE%8E%E5%BA%97"
    },
    {
      "id": "721",
      "name": "啾啾哥",
      "address": "臺北市文山區樟新街11號1樓",
      "lng.": "121.5553486",
      "lat.": "24.9793562",
      "time": "06:30-13:30",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/579f91502756dd715c15efd8-%E5%95%BE%E5%95%BE%E5%93%A5"
    },
    {
      "id": "722",
      "name": "巧味豬腳12 號",
      "address": "臺北市文山區木新路三段310巷4號",
      "lng.": "121.5569807",
      "lat.": "24.9817726",
      "time": "07:00-13:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e9f017b2756dd7d216b2871-%E5%B7%A7%E5%91%B3%E8%B1%AC%E8%85%B312-%E8%99%9F"
    },
    {
      "id": "723",
      "name": "MEOW House喵好時早餐號",
      "address": "臺北市文山區木新路三段74巷8弄15號",
      "lng.": "121.5639371",
      "lat.": "24.983109",
      "time": "07:00-13:00",
      "cuisine_type": "台式|日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57dd44be23679c13db46dc0c-MEOW-House%E5%96%B5%E5%A5%BD%E6%99%82%E6%97%A9%E9%A4%90%E8%99%9F"
    },
    {
      "id": "724",
      "name": "潮飯",
      "address": "臺北市文山區木柵路三段115號",
      "lng.": "121.568236",
      "lat.": "24.988949",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ae0c38e2756dd33f62951ae-%E6%BD%AE%E9%A3%AF"
    },
    {
      "id": "725",
      "name": "陽城燒臘店",
      "address": "臺北市文山區木新路二段244號",
      "lng.": "121.5665447",
      "lat.": "24.9833628",
      "time": "11:00-14:30, 16:30-20:00",
      "cuisine_type": "港式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d8358c03a103ee86c8259-%E9%99%BD%E5%9F%8E%E7%87%92%E8%87%98%E5%BA%97"
    },
    {
      "id": "726",
      "name": "米澤製麵(臺北萬芳店)-讚岐烏龍麵",
      "address": "臺北市文山區興隆路三段117號",
      "lng.": "121.558128",
      "lat.": "24.9990486",
      "time": "11:30-21:00",
      "cuisine_type": "日本",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e35a2c88c906d5a5911ac6b-%E7%B1%B3%E6%BE%A4%E8%A3%BD%E9%BA%B5(%E5%8F%B0%E5%8C%97%E8%90%AC%E8%8A%B3%E5%BA%97)-%E8%AE%9A%E5%B2%90%E7%83%8F%E9%BE%8D%E9%BA%B5"
    },
    {
      "id": "727",
      "name": "米粒活力早餐",
      "address": "臺北市文山區興隆路三段112巷2弄7號",
      "lng.": "121.5568683",
      "lat.": "24.9989758",
      "time": "06:30-13:30",
      "cuisine_type": "台式|日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57643c922756dd1d439e4a3b-%E7%B1%B3%E7%B2%92%E6%B4%BB%E5%8A%9B%E6%97%A9%E9%A4%90"
    },
    {
      "id": "728",
      "name": "黑貓工作室Cafe Chat Noir",
      "address": "臺北市文山區景華街52巷2號",
      "lng.": "121.5437286",
      "lat.": "24.9946103",
      "time": "13:30-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b65eb7d2756dd2dc3e2af8f-%E9%BB%91%E8%B2%93%E5%B7%A5%E4%BD%9C%E5%AE%A4Cafe-Chat-Noir"
    },
    {
      "id": "729",
      "name": "CorkyBear呆呆熊早午餐",
      "address": "臺北市文山區木新路三段74巷1弄20號1F",
      "lng.": "121.562712",
      "lat.": "24.9826599",
      "time": "07:00-15:00",
      "cuisine_type": "日式|歐式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e70dd142756dd355d213ca2-CorkyBear%E5%91%86%E5%91%86%E7%86%8A%E6%97%A9%E5%8D%88%E9%A4%90"
    },
    {
      "id": "730",
      "name": "師大分部臭豆腐",
      "address": "臺北市文山區Unnamed Road",
      "lng.": "121.5810358",
      "lat.": "24.9983469",
      "time": "22:30-23:59",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e80aeef2756dd6032d6855e-%E5%B8%AB%E5%A4%A7%E5%88%86%E9%83%A8%E8%87%AD%E8%B1%86%E8%85%90"
    },
    {
      "id": "731",
      "name": "A.B.D. Coffee&Life",
      "address": "臺北市文山區羅斯福路五段269巷32號",
      "lng.": "121.5409281",
      "lat.": "25.0013471",
      "time": "暫時無資訊",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b9e8f5ff5246841da609a02-A.B.D.-Coffee%26Life"
    },
    {
      "id": "732",
      "name": "景美上海生煎包",
      "address": "臺北市文山區景文街55號",
      "lng.": "121.5413998",
      "lat.": "24.9917036",
      "time": "07:30-11:30, 15:30-23:30",
      "cuisine_type": "中式",
      "rating": "3.6",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559de3dcc03a103ee86cbb9f-%E6%99%AF%E7%BE%8E%E4%B8%8A%E6%B5%B7%E7%94%9F%E7%85%8E%E5%8C%85"
    },
    {
      "id": "733",
      "name": "韓月半飯",
      "address": "臺北市文山區興隆路二段323號",
      "lng.": "121.55392",
      "lat.": "25.001229",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "韓式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59a30a952756dd5445be4d72-%E9%9F%93%E6%9C%88%E5%8D%8A%E9%A3%AF"
    },
    {
      "id": "734",
      "name": "Trattoria al Sole 豔陽下義大利小餐館",
      "address": "臺北市文山區新光路一段44號",
      "lng.": "121.573614",
      "lat.": "24.9897689",
      "time": "11:30-14:00, 17:30-21:30",
      "cuisine_type": "義式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ceb95b8226139300d743c2c-Trattoria-al-Sole-%E8%B1%94%E9%99%BD"
    },
    {
      "id": "735",
      "name": "Purrson 呼嚕小酒館",
      "address": "臺北市文山區指南路二段106號",
      "lng.": "121.5794662",
      "lat.": "24.986129",
      "time": "11:30-22:30",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e67a2782756dd355917d3a9-Purrson-%E5%91%BC%E5%9A%95%E5%B0%8F%E9%85%92%E9%A4%A8"
    },
    {
      "id": "736",
      "name": "真好味烤鴨莊",
      "address": "臺北市文山區木新路三段108號",
      "lng.": "121.5626941",
      "lat.": "24.9822903",
      "time": "10:30-20:00",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4f4f7c03a10241de63b80-%E7%9C%9F%E5%A5%BD%E5%91%B3%E7%83%A4%E9%B4%A8%E8%8E%8A"
    },
    {
      "id": "737",
      "name": "土角厝懷舊小吃店",
      "address": "臺北市文山區三福街2之1號",
      "lng.": "121.5417588",
      "lat.": "24.9960498",
      "time": "00:00-00:30, 17:00-00:00",
      "cuisine_type": "中式|台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d580d3d2756dd2f11198396-%E5%9C%9F%E8%A7%92%E5%8E%9D%E6%87%B7%E8%88%8A%E5%B0%8F%E5%90%83%E5%BA%97"
    },
    {
      "id": "738",
      "name": "松町和風小舖",
      "address": "臺北市文山區木新路二段60號",
      "lng.": "121.570516",
      "lat.": "24.986033",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "日本",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559ddebfc03a103ee86cb789-%E6%9D%BE%E7%94%BA%E5%92%8C%E9%A2%A8%E5%B0%8F%E8%88%96"
    },
    {
      "id": "739",
      "name": "你後面咖啡廳",
      "address": "臺北市文山區木柵路三段48巷1弄2號1樓",
      "lng.": "121.5653413",
      "lat.": "24.9879705",
      "time": "11:00-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a219a9f2756dd68a7f09391-%E4%BD%A0%E5%BE%8C%E9%9D%A2%E5%92%96%E5%95%A1%E5%BB%B3"
    },
    {
      "id": "740",
      "name": "廟口臭豆腐",
      "address": "臺北市文山區景美街45號",
      "lng.": "121.5421518",
      "lat.": "24.9913326",
      "time": "15:00-21:30",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe9abf802935e2d1f75b37d-%E5%BB%9F%E5%8F%A3%E8%87%AD%E8%B1%86%E8%85%90"
    },
    {
      "id": "741",
      "name": "濟鴻火鍋",
      "address": "臺北市文山區景興路202巷10號",
      "lng.": "121.543261",
      "lat.": "24.992032",
      "time": "11:30-23:00",
      "cuisine_type": "台式|日式",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/590cbf0f2756dd17cd7fa7eb-%E6%BF%9F%E9%B4%BB%E7%81%AB%E9%8D%8B"
    },
    {
      "id": "742",
      "name": "秘徑咖啡Alley's cafe",
      "address": "臺北市文山區羅斯福路五段218巷9弄3號",
      "lng.": "121.5384752",
      "lat.": "25.0016877",
      "time": "11:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e4e95f02756dd63a431e2c5-%E7%A7%98%E5%BE%91%E5%92%96%E5%95%A1Alley's-cafe"
    },
    {
      "id": "743",
      "name": "古早味蛋餅飯糰",
      "address": "臺北市文山區萬壽路14號",
      "lng.": "121.5762952",
      "lat.": "24.9881403",
      "time": "06:00-11:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5f506c03a102ec1415a7c-%E5%8F%A4%E6%97%A9%E5%91%B3%E8%9B%8B%E9%A4%85%E9%A3%AF%E7%B3%B0"
    },
    {
      "id": "744",
      "name": "石二鍋 / 臺北興隆店",
      "address": "臺北市文山區興隆路四段149號",
      "lng.": "121.5617507",
      "lat.": "24.9848357",
      "time": "11:30-22:30",
      "cuisine_type": "中式|日式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57546aad2756dd0896fa0a22-%E7%9F%B3%E4%BA%8C%E9%8D%8B-%2F-%E5%8F%B0%E5%8C%97%E8%88%88%E9%9A%86%E5%BA%97"
    },
    {
      "id": "745",
      "name": "寶島麵線站木新店",
      "address": "臺北市文山區木新路三段296號",
      "lng.": "121.5575691",
      "lat.": "24.9809509",
      "time": "11:00-19:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e80bf8ad6895d702f7cc5c3-%E5%AF%B6%E5%B3%B6%E9%BA%B5%E7%B7%9A%E7%AB%99%E6%9C%A8%E6%96%B0%E5%BA%97"
    },
    {
      "id": "746",
      "name": "蕃薯の店生猛活海鮮",
      "address": "臺北市文山區景文街181號舊橋旁",
      "lng.": "121.5409208",
      "lat.": "24.9887762",
      "time": "11:00-14:00, 17:00-23:00",
      "cuisine_type": "台式|中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5e32e69f2756dd184aac478e-%E8%95%83%E8%96%AF%E3%81%AE%E5%BA%97%E7%94%9F%E7%8C%9B%E6%B4%BB%E6%B5%B7%E9%AE%AE"
    },
    {
      "id": "747",
      "name": "三老村",
      "address": "臺北市文山區木柵路三段5號",
      "lng.": "121.564694",
      "lat.": "24.988576",
      "time": "11:30-21:00",
      "cuisine_type": "韓式|中式|台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a67f9fc03a104df53ca6e5-%E4%B8%89%E8%80%81%E6%9D%91"
    },
    {
      "id": "748",
      "name": "真的咖啡 ZHEN DE Cafe",
      "address": "臺北市文山區萬隆街19巷1號",
      "lng.": "121.5383447",
      "lat.": "25.0001025",
      "time": "09:00-22:00",
      "cuisine_type": "咖啡",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/597b7e352756dd22a9bd2957-%E7%9C%9F%E7%9A%84%E5%92%96%E5%95%A1-ZHEN-DE-Cafe"
    },
    {
      "id": "749",
      "name": "遇見",
      "address": "臺北市文山區羅斯福路六段18號",
      "lng.": "121.539451",
      "lat.": "25.000084",
      "time": "12:00-23:00",
      "cuisine_type": "飲料",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5967b7742756dd3b1c41aa6f-%E9%81%87%E8%A6%8B"
    },
    {
      "id": "750",
      "name": "火鍋哥涮涮屋",
      "address": "臺北市文山區羅斯福路五段218巷1號",
      "lng.": "121.538518",
      "lat.": "25.0020686",
      "time": "11:00-15:00, 17:00-22:00",
      "cuisine_type": "日式|台式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58557edc2756dd7579b8ee5a-%E7%81%AB%E9%8D%8B%E5%93%A5%E6%B6%AE%E6%B6%AE%E5%B1%8B"
    },
    {
      "id": "751",
      "name": "TAIGA 針葉林",
      "address": "臺北市文山區木柵路三段125之1號",
      "lng.": "121.5684242",
      "lat.": "24.9889765",
      "time": "09:00-17:00",
      "cuisine_type": "歐式|日式|美式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bd08bcbf524683fcb6a3aa0-TAIGA-%E9%87%9D%E8%91%89%E6%9E%97"
    },
    {
      "id": "752",
      "name": "壽喜燒一丁 景美店",
      "address": "臺北市文山區景興路188號B2",
      "lng.": "121.543815",
      "lat.": "24.9923",
      "time": "11:00-21:30",
      "cuisine_type": "日式",
      "rating": "3.9",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d6791c03a103ee86c7167-%E5%A3%BD%E5%96%9C%E7%87%92%E4%B8%80%E4%B8%81-%E6%99%AF%E7%BE%8E%E5%BA%97"
    },
    {
      "id": "753",
      "name": "小黑菓長崎蛋糕",
      "address": "臺北市文山區景美街5巷1號",
      "lng.": "121.541765",
      "lat.": "24.9934439",
      "time": "11:00-17:30",
      "cuisine_type": "美式|日式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b894ffa2756dd37ce912e8e-%E5%B0%8F%E9%BB%91%E8%8F%93%E9%95%B7%E5%B4%8E%E8%9B%8B%E7%B3%95"
    },
    {
      "id": "754",
      "name": "龍門客棧",
      "address": "臺北市文山區指南路三段38巷22之2號",
      "lng.": "121.5868023",
      "lat.": "24.9671038",
      "time": "00:00-01:00, 11:00-00:00",
      "cuisine_type": "中式|台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d1e40c03a103ee86c4109-%E9%BE%8D%E9%96%80%E5%AE%A2%E6%A3%A7"
    },
    {
      "id": "755",
      "name": "tnt美式碳烤牛排",
      "address": "臺北市文山區景興路168號",
      "lng.": "121.5441712",
      "lat.": "24.9930756",
      "time": "11:30-14:30, 17:30-22:00",
      "cuisine_type": "美式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58ac820a2756dd1e62effd50-tnt%E7%BE%8E%E5%BC%8F%E7%A2%B3%E7%83%A4%E7%89%9B%E6%8E%92"
    },
    {
      "id": "756",
      "name": "滷獲人心養生加熱滷味",
      "address": "臺北市文山區景美街2號",
      "lng.": "121.5415861",
      "lat.": "24.9942973",
      "time": "17:00-00:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5af5992723679c52659b1f9b-%E6%BB%B7%E7%8D%B2%E4%BA%BA%E5%BF%83%E9%A4%8A%E7%94%9F%E5%8A%A0%E7%86%B1%E6%BB%B7%E5%91%B3"
    },
    {
      "id": "757",
      "name": "辣椒先生-川味麻辣燙",
      "address": "臺北市文山區景華街78號",
      "lng.": "121.5452105",
      "lat.": "24.9950493",
      "time": "12:00-14:00, 16:00-00:00",
      "cuisine_type": "中式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c41402123679c26d55cec8c-%E8%BE%A3%E6%A4%92%E5%85%88%E7%94%9F-%E5%B7%9D%E5%91%B3%E9%BA%BB%E8%BE%A3%E7%87%99"
    },
    {
      "id": "758",
      "name": "賴桑香腸",
      "address": "臺北市文山區木柵路五段18號",
      "lng.": "121.581806",
      "lat.": "25.0024419",
      "time": "17:00-20:30",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559da69ac03a103ee86c9516-%E8%B3%B4%E6%A1%91%E9%A6%99%E8%85%B8"
    },
    {
      "id": "759",
      "name": "焱鬼鍋燒專門店",
      "address": "臺北市文山區木新路二段252號",
      "lng.": "121.5662939",
      "lat.": "24.983258",
      "time": "11:00-14:00, 16:30-20:30",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5602ebd82756dd161930ba2f-%E7%84%B1%E9%AC%BC%E9%8D%8B%E7%87%92%E5%B0%88%E9%96%80%E5%BA%97"
    },
    {
      "id": "760",
      "name": "木柵水煎包",
      "address": "臺北市文山區指南路一段25號",
      "lng.": "121.5693555",
      "lat.": "24.9877215",
      "time": "06:20-12:00",
      "cuisine_type": "中式",
      "rating": "4.4",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56aa58402756dd600d5e5920-%E6%9C%A8%E6%9F%B5%E6%B0%B4%E7%85%8E%E5%8C%85"
    },
    {
      "id": "761",
      "name": "有雞可乘(炸物專賣店)",
      "address": "臺北市文山區木新路三段289號",
      "lng.": "121.5575112",
      "lat.": "24.9807562",
      "time": "15:30-00:00",
      "cuisine_type": "日式|台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5dc5103cd6895d2fd9e09b32-%E6%9C%89%E9%9B%9E%E5%8F%AF%E4%B9%98(%E7%82%B8%E7%89%A9%E5%B0%88%E8%B3%A3%E5%BA%97)"
    },
    {
      "id": "762",
      "name": "等一個人咖啡(景美本店)",
      "address": "臺北市文山區一壽街44巷1號",
      "lng.": "121.5566568",
      "lat.": "24.9793218",
      "time": "11:00-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d3b00c03a103ee86c540d-%E7%AD%89%E4%B8%80%E5%80%8B%E4%BA%BA%E5%92%96%E5%95%A1(%E6%99%AF%E7%BE%8E%E6%9C%AC%E5%BA%97)"
    },
    {
      "id": "763",
      "name": "老元香雞湯專賣",
      "address": "臺北市文山區木柵路一段278號",
      "lng.": "121.5548445",
      "lat.": "24.9879753",
      "time": "暫時無資訊",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5dbd90c52756dd48e20a77fc-%E8%80%81%E5%85%83%E9%A6%99%E9%9B%9E%E6%B9%AF%E5%B0%88%E8%B3%A3"
    },
    {
      "id": "764",
      "name": "阿郎鹹酥雞",
      "address": "臺北市文山區興隆路三段36巷15弄12號",
      "lng.": "121.5555386",
      "lat.": "24.9995663",
      "cuisine_type": "台式",
      "rating": "2.5",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59c15d8b2756dd528db72d1d-%E9%98%BF%E9%83%8E%E9%B9%B9%E9%85%A5%E9%9B%9E"
    },
    {
      "id": "765",
      "name": "御神四季食藝料理",
      "address": "臺北市文山區木柵路三段48巷1弄9號",
      "lng.": "121.5648665",
      "lat.": "24.9878",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5d6147cf2756dd2f151a5d30-%E5%BE%A1%E7%A5%9E%E5%9B%9B%E5%AD%A3%E9%A3%9F%E8%97%9D%E6%96%99%E7%90%86"
    },
    {
      "id": "766",
      "name": "德國農夫廚房",
      "address": "臺北市文山區興隆路2段220巷35號1樓",
      "lng.": "121.552251",
      "lat.": "25.0003473",
      "time": "13:30-22:00",
      "cuisine_type": "德式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/55a53ae9c03a10241de653e2-%E5%BE%B7%E5%9C%8B%E8%BE%B2%E5%A4%AB%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "767",
      "name": "老爹鵝肉專賣店",
      "address": "臺北市文山區木新路三段9號",
      "lng.": "121.5649913",
      "lat.": "24.9825664",
      "time": "11:30-20:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a6830cc03a104df53ca7bb-%E8%80%81%E7%88%B9%E9%B5%9D%E8%82%89%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "768",
      "name": "阿二麻辣食堂-景美堂",
      "address": "臺北市文山區景文街71號",
      "lng.": "121.5415005",
      "lat.": "24.9914587",
      "time": "11:30-23:00",
      "cuisine_type": "中式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a7ab2f62756dd7bff171e80-%E9%98%BF%E4%BA%8C%E9%BA%BB%E8%BE%A3%E9%A3%9F%E5%A0%82-%E6%99%AF%E7%BE%8E%E5%A0%82"
    },
    {
      "id": "769",
      "name": "ConfitRémi",
      "address": "臺北市文山區羅斯福路五段269巷16號",
      "lng.": "121.5399713",
      "lat.": "25.001109",
      "time": "12:00-14:00, 17:30-22:00",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b9e8e59f5246841b6311f22-ConfitR%C3%A9mi"
    },
    {
      "id": "770",
      "name": "8鍋臭臭鍋",
      "address": "臺北市文山區興隆路三段36巷9弄5號",
      "lng.": "121.5556795",
      "lat.": "24.9998304",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d94310a8c906d0342c04084-8%E9%8D%8B%E8%87%AD%E8%87%AD%E9%8D%8B"
    },
    {
      "id": "771",
      "name": "麵疙瘩‧烤肉飯",
      "address": "臺北市文山區木柵路三段102巷3號",
      "lng.": "121.567616",
      "lat.": "24.9883949",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "台式|韓式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56bf705c2756dd1775878153-%E9%BA%B5%E7%96%99%E7%98%A9%E2%80%A7%E7%83%A4%E8%82%89%E9%A3%AF"
    },
    {
      "id": "772",
      "name": "小旺仔宜蘭蛋餅",
      "address": "臺北市文山區景美街83號",
      "lng.": "121.5417941",
      "lat.": "24.9905549",
      "time": "16:30-22:00",
      "cuisine_type": "台式",
      "rating": "4.6",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c3b49a62756dd69e67f411d-%E5%B0%8F%E6%97%BA%E4%BB%94%E5%AE%9C%E8%98%AD%E8%9B%8B%E9%A4%85"
    },
    {
      "id": "773",
      "name": "兄弟麵館",
      "address": "臺北市文山區興隆路三段36巷16弄2號",
      "lng.": "121.5550125",
      "lat.": "24.9996762",
      "time": "11:30-14:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/581636082756dd4cef4eaae4-%E5%85%84%E5%BC%9F%E9%BA%B5%E9%A4%A8"
    },
    {
      "id": "774",
      "name": "小尚品精制鍋物",
      "address": "臺北市文山區木柵路一段325之3號",
      "lng.": "121.556227",
      "lat.": "24.9885628",
      "time": "11:00-22:00",
      "cuisine_type": "義式|中式|韓式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bd8288e2261394a8bd7dd2a-%E5%B0%8F%E5%B0%9A%E5%93%81%E7%B2%BE%E5%88%B6%E9%8D%8B%E7%89%A9"
    },
    {
      "id": "775",
      "name": "松包子Os桑的包子(景美分店)",
      "address": "臺北市文山區興隆路三段35號",
      "lng.": "121.5556348",
      "lat.": "25.0005708",
      "time": "12:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d6356248c906d155e98cbd8-%E6%9D%BE%E5%8C%85%E5%AD%90Os%E6%A1%91%E7%9A%84%E5%8C%85%E5%AD%90(%E6%99%AF%E7%BE%8E%E5%88%86%E5%BA%97)"
    },
    {
      "id": "776",
      "name": "小公寓",
      "address": "臺北市文山區指南路二段56號2樓號",
      "lng.": "121.5754459",
      "lat.": "24.9876087",
      "time": "11:00-21:00",
      "cuisine_type": "咖啡|日式|美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c1d035ef524687c09e2db3e-%E5%B0%8F%E5%85%AC%E5%AF%93"
    },
    {
      "id": "777",
      "name": "轉角冰",
      "address": "臺北市文山區景興路42巷8弄1號1樓",
      "lng.": "121.5426777",
      "lat.": "24.9971513",
      "time": "12:00-21:00",
      "cuisine_type": "飲料",
      "rating": "4.6",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5af9d1432756dd5e0a5dc7a8-%E8%BD%89%E8%A7%92%E5%86%B0"
    },
    {
      "id": "778",
      "name": "瀚星百貨 edoraPARK",
      "address": "臺北市文山區景興路188號",
      "lng.": "121.543815",
      "lat.": "24.9923",
      "time": "11:00-21:30",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d6299722756dd2f1027cec8-%E7%80%9A%E6%98%9F%E7%99%BE%E8%B2%A8-edoraPARK"
    },
    {
      "id": "779",
      "name": "誠鵝肉專賣",
      "address": "臺北市文山區木柵路二段191號",
      "lng.": "121.5637789",
      "lat.": "24.988915",
      "time": "11:00-20:00",
      "cuisine_type": "台式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d3a33c03a103ee86c53a9-%E8%AA%A0%E9%B5%9D%E8%82%89%E5%B0%88%E8%B3%A3"
    },
    {
      "id": "780",
      "name": "波波恰恰大馬風味餐",
      "address": "臺北市文山區指南路二段48號",
      "lng.": "121.5752569",
      "lat.": "24.9877122",
      "time": "11:00-20:00",
      "cuisine_type": "東南亞",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a6824dc03a104df53ca78e-%E6%B3%A2%E6%B3%A2%E6%81%B0%E6%81%B0%E5%A4%A7%E9%A6%AC%E9%A2%A8%E5%91%B3%E9%A4%90"
    },
    {
      "id": "781",
      "name": "鬼頭鍋物食堂",
      "address": "臺北市文山區木新路二段258號",
      "lng.": "121.5661529",
      "lat.": "24.9832119",
      "time": "11:30-21:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b15804e2756dd3d0f88958a-%E9%AC%BC%E9%A0%AD%E9%8D%8B%E7%89%A9%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "782",
      "name": "Boulangerie Shan Wei 山崴 - 未來廚房",
      "address": "臺北市文山區木柵路一段270號",
      "lng.": "121.554661",
      "lat.": "24.987968",
      "time": "10:00-21:30",
      "cuisine_type": "義式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59fe01052756dd6f07e9b4c4-Boulangerie-Shan-Wei"
    },
    {
      "id": "783",
      "name": "Mars Coffee",
      "address": "臺北市文山區辛亥路四段235號",
      "lng.": "121.5550973",
      "lat.": "25.0013548",
      "time": "09:00-18:00",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d4a6efa22613915657dca81-Mars-Coffee"
    },
    {
      "id": "784",
      "name": "偵軒廚房",
      "address": "臺北市文山區羅斯福路六段28號",
      "lng.": "121.539595",
      "lat.": "24.9997899",
      "time": "11:30-23:00",
      "cuisine_type": "日式|台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d4131c03a103ee86c583f-%E5%81%B5%E8%BB%92%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "785",
      "name": "景美鄭家碳烤",
      "address": "臺北市文山區景文街51號",
      "lng.": "121.5414055",
      "lat.": "24.9917198",
      "time": "18:15-00:00",
      "cuisine_type": "日式|台式",
      "rating": "3.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4aae4c03a1002ad8ad583-%E6%99%AF%E7%BE%8E%E9%84%AD%E5%AE%B6%E7%A2%B3%E7%83%A4"
    },
    {
      "id": "786",
      "name": "越南順化米線",
      "address": "臺北市文山區興隆路四段145巷20號1樓",
      "lng.": "121.5626113",
      "lat.": "24.9850226",
      "time": "11:00-20:00",
      "cuisine_type": "東南亞",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d76ee9f2261395501e09cbe-%E8%B6%8A%E5%8D%97%E9%A0%86%E5%8C%96%E7%B1%B3%E7%B7%9A"
    },
    {
      "id": "787",
      "name": "BÁNH MÌ 越式法國麵包",
      "address": "臺北市文山區興隆路四段134之1號",
      "lng.": "121.562278",
      "lat.": "24.9823584",
      "time": "07:00-14:00",
      "cuisine_type": "東南亞",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5dce1a9a226139571a9e49f3-B%C3%81NH-M%C3%8C-%E8%B6%8A%E5%BC%8F%E6%B3%95%E5%9C%8B%E9%BA%B5%E5%8C%85"
    },
    {
      "id": "788",
      "name": "ÎLE 島嶼法式海鮮",
      "address": "臺北市文山區一壽街16號",
      "lng.": "121.5564306",
      "lat.": "24.9799939",
      "time": "11:30-14:00, 18:00-22:00",
      "cuisine_type": "法式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5d23515e2756dd7622eedeba-%C3%8ELE-%E5%B3%B6%E5%B6%BC%E6%B3%95%E5%BC%8F%E6%B5%B7%E9%AE%AE"
    },
    {
      "id": "789",
      "name": "晨食早餐",
      "address": "臺北市文山區羅斯福路五段192巷8號",
      "lng.": "121.5375969",
      "lat.": "25.0036113",
      "time": "06:00-13:30",
      "cuisine_type": "台式|美式|日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a60c99c03a102ec14161cf-%E6%99%A8%E9%A3%9F%E6%97%A9%E9%A4%90"
    },
    {
      "id": "790",
      "name": "尋常生活小坊",
      "address": "臺北市文山區公館街54號",
      "lng.": "121.537401",
      "lat.": "25.00572",
      "time": "10:00-18:00",
      "cuisine_type": "咖啡",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57cb10842756dd6aad99bd1b-%E5%B0%8B%E5%B8%B8%E7%94%9F%E6%B4%BB%E5%B0%8F%E5%9D%8A"
    },
    {
      "id": "791",
      "name": "怡客咖啡 文山店",
      "address": "臺北市文山區興隆路三段222號",
      "lng.": "121.559673",
      "lat.": "24.9970166",
      "time": "07:00-20:00",
      "cuisine_type": "咖啡",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d08f3932756dd2c77f1703e-%E6%80%A1%E5%AE%A2%E5%92%96%E5%95%A1-%E6%96%87%E5%B1%B1%E5%BA%97"
    },
    {
      "id": "792",
      "name": "嘎逼。ㄉㄟˊ",
      "address": "臺北市文山區試院路58號",
      "lng.": "121.549335",
      "lat.": "24.989577",
      "time": "00:00-02:00, 09:00-00:00",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ce54fa2f524683e6c830dac-%E5%98%8E%E9%80%BC%E3%80%82%E3%84%89%E3%84%9F%CB%8A"
    },
    {
      "id": "793",
      "name": "義興樓",
      "address": "臺北市文山區景文街121號",
      "lng.": "121.541221",
      "lat.": "24.9904119",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/55a66a47c03a104df53ca0f4-%E7%BE%A9%E8%88%88%E6%A8%93"
    },
    {
      "id": "794",
      "name": "63brunch",
      "address": "臺北市文山區景興路63號",
      "lng.": "121.5448585",
      "lat.": "24.9964527",
      "time": "11:00-19:00",
      "cuisine_type": "美式|義式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5cc4124e22613939a1e02a1c-63brunch"
    },
    {
      "id": "795",
      "name": "珍味海南雞飯",
      "address": "臺北市文山區景後街149巷5號",
      "lng.": "121.5423156",
      "lat.": "24.9901935",
      "time": "11:00-21:30",
      "cuisine_type": "東南亞",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a51112f2756dd4707619359-%E7%8F%8D%E5%91%B3%E6%B5%B7%E5%8D%97%E9%9B%9E%E9%A3%AF"
    },
    {
      "id": "796",
      "name": "三角冰",
      "address": "臺北市文山區羅斯福路五段170巷10號",
      "lng.": "121.5380329",
      "lat.": "25.004741",
      "time": "12:00-21:30",
      "cuisine_type": "飲料",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/576ad37f2756dd134634d15f-%E4%B8%89%E8%A7%92%E5%86%B0"
    },
    {
      "id": "797",
      "name": "貓空小木屋茶坊",
      "address": "臺北市文山區指南路三段38巷28號",
      "lng.": "121.5866545",
      "lat.": "24.9668591",
      "time": "10:00-22:00",
      "cuisine_type": "飲料|台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a683d3c03a104df53ca7f4-%E8%B2%93%E7%A9%BA%E5%B0%8F%E6%9C%A8%E5%B1%8B%E8%8C%B6%E5%9D%8A"
    },
    {
      "id": "798",
      "name": "怡源麵粥之屋",
      "address": "臺北市文山區忠順街一段34號",
      "lng.": "121.5595484",
      "lat.": "24.9840663",
      "time": "10:30-21:30",
      "cuisine_type": "台式|中式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58f700cbf5246815d0a75ef9-%E6%80%A1%E6%BA%90%E9%BA%B5%E7%B2%A5%E4%B9%8B%E5%B1%8B"
    },
    {
      "id": "799",
      "name": "風箏人咖啡",
      "address": "臺北市文山區景豐街48巷1號",
      "lng.": "121.5461509",
      "lat.": "25.0002076",
      "time": "07:30-18:00",
      "cuisine_type": "咖啡",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a6b6e6a2756dd652a8e0c70-%E9%A2%A8%E7%AE%8F%E4%BA%BA%E5%92%96%E5%95%A1"
    },
    {
      "id": "800",
      "name": "MINT PASTA (世新店)",
      "address": "臺北市文山區景興路274之2號",
      "lng.": "121.5424561",
      "lat.": "24.9897431",
      "time": "11:00-21:00",
      "cuisine_type": "義式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d33a6c03a103ee86c4f8f-MINT-PASTA-(%E4%B8%96%E6%96%B0%E5%BA%97)"
    },
    {
      "id": "801",
      "name": "楊家手工水餃",
      "address": "臺北市文山區景後街178號",
      "lng.": "121.5420583",
      "lat.": "24.9904912",
      "time": "17:00-23:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b11714423679c51883fc998-%E6%A5%8A%E5%AE%B6%E6%89%8B%E5%B7%A5%E6%B0%B4%E9%A4%83"
    },
    {
      "id": "802",
      "name": "老饒牛肉麵",
      "address": "臺北市文山區木新路二段263號",
      "lng.": "121.5663873",
      "lat.": "24.9829912",
      "time": "暫時無資訊",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d8128c03a103ee86c816f-%E8%80%81%E9%A5%92%E7%89%9B%E8%82%89%E9%BA%B5"
    },
    {
      "id": "803",
      "name": "三一活力早餐 (原三三早餐二店)",
      "address": "臺北市文山區木新路二段103號",
      "lng.": "121.570101",
      "lat.": "24.984411",
      "time": "06:00-13:00",
      "cuisine_type": "台式|日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559dbf57c03a103ee86ca480-%E4%B8%89%E4%B8%80%E6%B4%BB%E5%8A%9B%E6%97%A9%E9%A4%90-(%E5%8E%9F%E4%B8%89%E4%B8%89%E6%97%A9%E9%A4%90%E4%BA%8C%E5%BA%97)"
    },
    {
      "id": "804",
      "name": "滾吧 Qunba 鍋物 萬隆店",
      "address": "臺北市文山區羅斯福路五段247號",
      "lng.": "121.5393464",
      "lat.": "25.0015575",
      "time": "11:30-22:00",
      "cuisine_type": "日式|台式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5afd1a0bf524687e344652d5-%E6%BB%BE%E5%90%A7-Qunba-%E9%8D%8B%E7%89%A9-%E8%90%AC%E9%9A%86%E5%BA%97"
    },
    {
      "id": "805",
      "name": "敏忠餐廳",
      "address": "臺北市文山區指南路二段57號1樓",
      "lng.": "121.574567",
      "lat.": "24.9879813",
      "time": "11:45-14:00, 17:15-20:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a4f5ccc03a10241de63bcb-%E6%95%8F%E5%BF%A0%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "806",
      "name": "呷麵騎士",
      "address": "臺北市文山區指南路二段45巷2弄1之1號",
      "lng.": "121.57443",
      "lat.": "24.9882559",
      "time": "11:30-14:30, 17:30-20:30",
      "cuisine_type": "泰式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58043a3f23679c7cef928863-%E5%91%B7%E9%BA%B5%E9%A8%8E%E5%A3%AB"
    },
    {
      "id": "807",
      "name": "渣男 Taiwan Bistro",
      "address": "臺北市文山區萬芳路9之1號",
      "lng.": "121.5705899",
      "lat.": "24.99848",
      "time": "00:00-01:30, 17:30-00:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5849a0bb2756dd614fb5136a-%E6%B8%A3%E7%94%B7-Taiwan-Bistro"
    },
    {
      "id": "808",
      "name": "芮比特",
      "address": "臺北市文山區木新路三段128號",
      "lng.": "121.5618484",
      "lat.": "24.9821146",
      "time": "14:00-22:00",
      "cuisine_type": "飲料",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c9e261ff5246847f70af2fd-%E8%8A%AE%E6%AF%94%E7%89%B9"
    },
    {
      "id": "809",
      "name": "好口樂傳統美食",
      "address": "臺北市文山區景美街35號",
      "lng.": "121.5417747",
      "lat.": "24.9918617",
      "time": "05:30-14:00",
      "cuisine_type": "台式",
      "rating": "3.6",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe9ac088c906d47f19b474d-%E5%A5%BD%E5%8F%A3%E6%A8%82%E5%82%B3%E7%B5%B1%E7%BE%8E%E9%A3%9F"
    },
    {
      "id": "810",
      "name": "阿葉米粉湯",
      "address": "臺北市文山區保儀路26巷4號",
      "lng.": "121.568126",
      "lat.": "24.98817",
      "time": "05:30-20:30",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56aa58922756dd600d5e5939-%E9%98%BF%E8%91%89%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "811",
      "name": "自由51",
      "address": "臺北市文山區羅斯福路五段150巷59號",
      "lng.": "121.5378133",
      "lat.": "25.0073894",
      "time": "11:30-23:00",
      "cuisine_type": "咖啡",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bf7ac56f524687ff1d98239-%E8%87%AA%E7%94%B151"
    },
    {
      "id": "812",
      "name": "火鍋 海 精緻涮涮鍋",
      "address": "臺北市文山區木新路三段68號",
      "lng.": "121.5636895",
      "lat.": "24.9825222",
      "time": "11:30-14:00, 17:30-21:30",
      "cuisine_type": "日式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5bf2353f23679c0bbffc0afb-%E7%81%AB%E9%8D%8B-%E6%B5%B7-%E7%B2%BE%E7%B7%BB%E6%B6%AE%E6%B6%AE%E9%8D%8B"
    },
    {
      "id": "813",
      "name": "舒曼六號 Schumann's Bistro No. 6",
      "address": "臺北市文山區萬壽路6號",
      "lng.": "121.5761855",
      "lat.": "24.98807",
      "time": "11:00-22:00",
      "cuisine_type": "歐式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57effb0e2756dd0d0ff56524-%E8%88%92%E6%9B%BC%E5%85%AD%E8%99%9F-Schumann's-Bist"
    },
    {
      "id": "814",
      "name": "三媽臭臭鍋（新光店）",
      "address": "臺北市文山區新光路一段117號",
      "lng.": "121.573818",
      "lat.": "24.991361",
      "time": "11:00-23:00",
      "cuisine_type": "台式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bf2352723679c0bc0c228a6-%E4%B8%89%E5%AA%BD%E8%87%AD%E8%87%AD%E9%8D%8B%EF%BC%88%E6%96%B0%E5%85%89%E5%BA%97%EF%BC%89"
    },
    {
      "id": "815",
      "name": "西紅柿麵店",
      "address": "臺北市文山區興隆路三段112巷2弄2號",
      "lng.": "121.5571585",
      "lat.": "24.9990949",
      "time": "11:00-22:00",
      "cuisine_type": "日式|台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a68158c03a104df53ca757-%E8%A5%BF%E7%B4%85%E6%9F%BF%E9%BA%B5%E5%BA%97"
    },
    {
      "id": "816",
      "name": "吃香喝辣牛肉麵",
      "address": "臺北市文山區忠順街二段42號",
      "lng.": "121.5640757",
      "lat.": "24.9848023",
      "time": "11:00-20:30",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5beab6cf2261392c4fc178e8-%E5%90%83%E9%A6%99%E5%96%9D%E8%BE%A3%E7%89%9B%E8%82%89%E9%BA%B5"
    },
    {
      "id": "817",
      "name": "孫東寶牛排 文山興隆店",
      "address": "臺北市文山區興隆路三段138號",
      "lng.": "121.5580141",
      "lat.": "24.9987532",
      "time": "11:30-21:00",
      "cuisine_type": "台式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59f0d32c2756dd291cc670ab-%E5%AD%AB%E6%9D%B1%E5%AF%B6%E7%89%9B%E6%8E%92-%E6%96%87%E5%B1%B1%E8%88%88%E9%9A%86%E5%BA%97"
    },
    {
      "id": "818",
      "name": "魚玄雞小館",
      "address": "臺北市文山區興隆路三段231號",
      "lng.": "121.5592252",
      "lat.": "24.9933762",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5ed03c03a102ec1415812-%E9%AD%9A%E7%8E%84%E9%9B%9E%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "819",
      "name": "好棒棒食堂",
      "address": "臺北市文山區木柵路二段113號",
      "lng.": "121.561872",
      "lat.": "24.9889945",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5be2a30e226139265b847166-%E5%A5%BD%E6%A3%92%E6%A3%92%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "820",
      "name": "阿枝米粉湯",
      "address": "臺北市文山區景美街113號",
      "lng.": "121.5414046",
      "lat.": "24.9901044",
      "time": "暫時無資訊",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a301a722756dd68d8793267-%E9%98%BF%E6%9E%9D%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "821",
      "name": "雨。聲。咖。啡",
      "address": "臺北市文山區景華街28號",
      "lng.": "121.54266",
      "lat.": "24.9949513",
      "time": "08:30-22:00",
      "cuisine_type": "咖啡",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57e6c0312756dd606f45b8f2-%E9%9B%A8%E3%80%82%E8%81%B2%E3%80%82%E5%92%96%E3%80%82%E5%95%A1"
    },
    {
      "id": "822",
      "name": "寶島肉圓店",
      "address": "臺北市文山區羅斯福路五段136號",
      "lng.": "121.538799",
      "lat.": "25.005884",
      "time": "11:30-20:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5feabc03a102ec1415d77-%E5%AF%B6%E5%B3%B6%E8%82%89%E5%9C%93%E5%BA%97"
    },
    {
      "id": "823",
      "name": "興記燒腊",
      "address": "臺北市文山區景文街17號",
      "lng.": "121.54143",
      "lat.": "24.992661",
      "time": "11:00-13:30, 15:30-18:00",
      "cuisine_type": "港式|台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a4faf3c03a10241de63db8-%E8%88%88%E8%A8%98%E7%87%92%E8%85%8A"
    },
    {
      "id": "824",
      "name": "川國麵館麻瘋麵",
      "address": "臺北市文山區興隆路四段116號",
      "lng.": "121.559638",
      "lat.": "24.989451",
      "time": "12:00-14:00, 17:30-20:30",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5be2a34d226139265c665db8-%E5%B7%9D%E5%9C%8B%E9%BA%B5%E9%A4%A8%E9%BA%BB%E7%98%8B%E9%BA%B5"
    },
    {
      "id": "825",
      "name": "飛驒涮涮鍋",
      "address": "臺北市文山區興隆路四段59號",
      "lng.": "121.5599699",
      "lat.": "24.9894784",
      "time": "12:00-14:30, 17:00-22:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b8167312756dd4701921cb0-%E9%A3%9B%E9%A9%92%E6%B6%AE%E6%B6%AE%E9%8D%8B"
    },
    {
      "id": "826",
      "name": "山的另 一邊",
      "address": "臺北市文山區木新路二段264號1樓號",
      "lng.": "121.566041",
      "lat.": "24.983152",
      "time": "06:00-14:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b65eb592756dd2dc3e2af8a-%E5%B1%B1%E7%9A%84%E5%8F%A6-%E4%B8%80%E9%82%8A"
    },
    {
      "id": "827",
      "name": "驢爸爸凉麵",
      "address": "臺北市文山區景後街190號",
      "lng.": "121.5417271",
      "lat.": "24.990172",
      "time": "06:00-14:30",
      "cuisine_type": "台式|日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d6ba9c03a103ee86c742e-%E9%A9%A2%E7%88%B8%E7%88%B8%E5%87%89%E9%BA%B5"
    },
    {
      "id": "828",
      "name": "飽飽食府",
      "address": "臺北市文山區指南路二段119巷117號",
      "lng.": "121.576551",
      "lat.": "24.9876569",
      "time": "11:20-19:30",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b6f26d52756dd51613cf3f5-%E9%A3%BD%E9%A3%BD%E9%A3%9F%E5%BA%9C"
    },
    {
      "id": "829",
      "name": "Fun山豬香腸",
      "address": "臺北市文山區景美街37之33號",
      "lng.": "121.5418094",
      "lat.": "24.9915751",
      "time": "15:00-23:00",
      "cuisine_type": "台式",
      "rating": "4.6",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe9abd68c906d47f19b4728-Fun%E5%B1%B1%E8%B1%AC%E9%A6%99%E8%85%B8"
    },
    {
      "id": "830",
      "name": "景美好吃豆花",
      "address": "臺北市文山區景文街133號",
      "lng.": "121.541162",
      "lat.": "24.990145",
      "time": "16:00-00:00",
      "cuisine_type": "飲料",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5bdbfc03a10241de67f2a-%E6%99%AF%E7%BE%8E%E5%A5%BD%E5%90%83%E8%B1%86%E8%8A%B1"
    },
    {
      "id": "831",
      "name": "龐家肉羹",
      "address": "臺北市文山區新光路一段193號",
      "lng.": "121.5740014",
      "lat.": "24.9934971",
      "time": "06:00-13:30",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b69e2772756dd2dc3e32b86-%E9%BE%90%E5%AE%B6%E8%82%89%E7%BE%B9"
    },
    {
      "id": "832",
      "name": "清泉廣場",
      "address": "臺北市文山區指南路三段38巷33之1號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "11:00-21:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d01c7c03a103ee86c32b6-%E6%B8%85%E6%B3%89%E5%BB%A3%E5%A0%B4"
    },
    {
      "id": "833",
      "name": "鬼匠拉麵-木柵店",
      "address": "臺北市文山區指南路二段28號",
      "lng.": "121.5746506",
      "lat.": "24.9877794",
      "time": "11:00-14:00, 17:00-20:30",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c2c72b1f5246818d4cd8cbe-%E9%AC%BC%E5%8C%A0%E6%8B%89%E9%BA%B5-%E6%9C%A8%E6%9F%B5%E5%BA%97"
    },
    {
      "id": "834",
      "name": "MY麵屋",
      "address": "臺北市文山區指南路二段45巷7號",
      "lng.": "121.574246",
      "lat.": "24.9883459",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "台式|中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c2c72a622613958b26e1aab-MY%E9%BA%B5%E5%B1%8B"
    },
    {
      "id": "835",
      "name": "永和豆漿大王(木新店)",
      "address": "臺北市文山區木新路二段293號",
      "lng.": "121.5655409",
      "lat.": "24.9827027",
      "time": "00:00-10:30, 19:00-00:00",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b28701e23679c19b35d4a09-%E6%B0%B8%E5%92%8C%E8%B1%86%E6%BC%BF%E5%A4%A7%E7%8E%8B(%E6%9C%A8%E6%96%B0%E5%BA%97)"
    },
    {
      "id": "836",
      "name": "老大房食品",
      "address": "臺北市文山區羅斯福路六段30之1號",
      "lng.": "121.539611",
      "lat.": "24.999752",
      "time": "07:00-22:30",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b12dce52756dd3d0c883604-%E8%80%81%E5%A4%A7%E6%88%BF%E9%A3%9F%E5%93%81"
    },
    {
      "id": "837",
      "name": "潘鵝肉專賣店",
      "address": "臺北市文山區木新路二段283號",
      "lng.": "121.565796",
      "lat.": "24.9828002",
      "time": "11:30-20:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b103bd52756dd5361ca1658-%E6%BD%98%E9%B5%9D%E8%82%89%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "838",
      "name": "咖啡大亨",
      "address": "臺北市文山區指南路二段45巷1號",
      "lng.": "121.574199",
      "lat.": "24.98818",
      "time": "08:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5655df9e2756dd1d7a1aff63-%E5%92%96%E5%95%A1%E5%A4%A7%E4%BA%A8"
    },
    {
      "id": "839",
      "name": "京華小館",
      "address": "臺北市文山區新光路一段13號",
      "lng.": "121.573815",
      "lat.": "24.9885999",
      "time": "11:00-19:50",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5fc6fc03a102ec1415cc8-%E4%BA%AC%E8%8F%AF%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "840",
      "name": "trouble maker搗蛋鬼手工鬆餅",
      "address": "臺北市文山區羅斯福路六段455巷12號",
      "lng.": "121.5405293",
      "lat.": "24.9900273",
      "time": "10:30-18:00",
      "cuisine_type": "美式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/592085492756dd5484ad9390-trouble-maker%E6%90%97%E8%9B%8B%E9%AC%BC%E6%89%8B%E5%B7%A5%E9%AC%86%E9%A4%85"
    },
    {
      "id": "841",
      "name": "屏東清蒸肉圓",
      "address": "臺北市文山區景美街",
      "lng.": "121.5416403",
      "lat.": "24.9916431",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5accfe552756dd7b4e1324f3-%E5%B1%8F%E6%9D%B1%E6%B8%85%E8%92%B8%E8%82%89%E5%9C%93"
    },
    {
      "id": "842",
      "name": "加賀日式料理",
      "address": "臺北市文山區指南路二段17號",
      "lng.": "121.573499",
      "lat.": "24.988308",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a718c3bf5246808fa6e5d21-%E5%8A%A0%E8%B3%80%E6%97%A5%E5%BC%8F%E6%96%99%E7%90%86"
    },
    {
      "id": "843",
      "name": "廟邊阿珠芋圓",
      "address": "臺北市文山區深坑老街",
      "lng.": "121.6147377",
      "lat.": "25.0016916",
      "rating": "4",
      "cuisine_type": "飲料",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a58cffc03a10241de66ff1-%E5%BB%9F%E9%82%8A%E9%98%BF%E7%8F%A0%E8%8A%8B%E5%9C%93"
    },
    {
      "id": "844",
      "name": "阿里郎韓國小吃",
      "address": "臺北市文山區指南路二段31號",
      "lng.": "121.573879",
      "lat.": "24.9881579",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "韓式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c2c7298f5246818b0ea0106-%E9%98%BF%E9%87%8C%E9%83%8E%E9%9F%93%E5%9C%8B%E5%B0%8F%E5%90%83"
    },
    {
      "id": "845",
      "name": "Tenshima 天島咖啡",
      "address": "臺北市文山區羅斯福路六段311號",
      "lng.": "121.541397",
      "lat.": "24.9940195",
      "time": "11:30-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bab5101f524687094f6eae9-Tenshima-%E5%A4%A9%E5%B3%B6%E5%92%96%E5%95%A1"
    },
    {
      "id": "846",
      "name": "小白ㄔ麵館",
      "address": "臺北市文山區興隆路二段220巷29號",
      "lng.": "121.5524083",
      "lat.": "25.0005949",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56df14c92756dd19d835e7db-%E5%B0%8F%E7%99%BD%E3%84%94%E9%BA%B5%E9%A4%A8"
    },
    {
      "id": "847",
      "name": "阿昌麵線臭豆腐",
      "address": "臺北市文山區景美街45號",
      "lng.": "121.5421518",
      "lat.": "24.9913326",
      "time": "15:30-23:30",
      "cuisine_type": "台式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559dbf6ec03a103ee86ca498-%E9%98%BF%E6%98%8C%E9%BA%B5%E7%B7%9A%E8%87%AD%E8%B1%86%E8%85%90"
    },
    {
      "id": "848",
      "name": "高雙管四神湯",
      "address": "臺北市文山區景美街139號",
      "lng.": "121.5415143",
      "lat.": "24.9895567",
      "time": "15:00-22:30",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d137f742756dd4ea96f963c-%E9%AB%98%E9%9B%99%E7%AE%A1%E5%9B%9B%E7%A5%9E%E6%B9%AF"
    },
    {
      "id": "849",
      "name": "老溫大餛飩麵店",
      "address": "臺北市文山區興隆路三段112巷1號",
      "lng.": "121.557318",
      "lat.": "24.9988925",
      "time": "11:00-22:30",
      "cuisine_type": "台式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a7ab11d2756dd7bff171daf-%E8%80%81%E6%BA%AB%E5%A4%A7%E9%A4%9B%E9%A3%A9%E9%BA%B5%E5%BA%97"
    },
    {
      "id": "850",
      "name": "越南小吃",
      "address": "臺北市文山區景美街9之11號",
      "lng.": "121.5417644",
      "lat.": "24.9940988",
      "time": "16:30-23:00",
      "cuisine_type": "東南亞",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a7aae9a2756dd7bff171cbe-%E8%B6%8A%E5%8D%97%E5%B0%8F%E5%90%83"
    },
    {
      "id": "851",
      "name": "越南河內小吃",
      "address": "臺北市文山區景美街6號",
      "lng.": "121.5418351",
      "lat.": "24.992583",
      "time": "11:00-22:00",
      "cuisine_type": "東南亞",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a6cc0762756dd65298e3176-%E8%B6%8A%E5%8D%97%E6%B2%B3%E5%85%A7%E5%B0%8F%E5%90%83"
    },
    {
      "id": "852",
      "name": "Lecker里克德義廚房",
      "address": "臺北市文山區新光路一段22之1號",
      "lng.": "121.573465",
      "lat.": "24.98884",
      "time": "11:30-15:00, 17:00-21:00",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dbe11c03a103ee86ca3b1-Lecker%E9%87%8C%E5%85%8B%E5%BE%B7%E7%BE%A9%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "853",
      "name": "揉道Nubun不老麵糰",
      "address": "臺北市文山區新光路一段143號",
      "lng.": "121.573884",
      "lat.": "24.991961",
      "time": "12:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a68cc2a2756dd35cfc67b68-%E6%8F%89%E9%81%93Nubun%E4%B8%8D%E8%80%81%E9%BA%B5%E7%B3%B0"
    },
    {
      "id": "854",
      "name": "欣帝堡活力早午餐",
      "address": "臺北市文山區保儀路171號，1樓",
      "lng.": "121.5659988",
      "lat.": "24.9835287",
      "time": "06:00-13:00",
      "cuisine_type": "美式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a4ef7c3f524683d3ce70466-%E6%AC%A3%E5%B8%9D%E5%A0%A1%E6%B4%BB%E5%8A%9B%E6%97%A9%E5%8D%88%E9%A4%90"
    },
    {
      "id": "855",
      "name": "德利香雞排",
      "address": "臺北市文山區景美街6之1號",
      "lng.": "121.5417685",
      "lat.": "24.9940027",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a5111432756dd470761935e-%E5%BE%B7%E5%88%A9%E9%A6%99%E9%9B%9E%E6%8E%92"
    },
    {
      "id": "856",
      "name": "Creative Pasta 創義麵",
      "address": "臺北市文山區興隆路三段67號2樓",
      "lng.": "121.5563129",
      "lat.": "25.0002018",
      "time": "11:00-21:30",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a4bcab92756dd4707613075-Creative-Pasta-%E5%89%B5%E7%BE%A9%E9%BA%B5"
    },
    {
      "id": "857",
      "name": "小法國早餐坊",
      "address": "臺北市文山區景興路28號",
      "lng.": "121.544521",
      "lat.": "24.997458",
      "time": "06:30-14:00",
      "cuisine_type": "法式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5c0f8c03a10241de68043-%E5%B0%8F%E6%B3%95%E5%9C%8B%E6%97%A9%E9%A4%90%E5%9D%8A"
    },
    {
      "id": "858",
      "name": "米塔義式廚房",
      "address": "臺北市文山區萬壽路2號1樓",
      "lng.": "121.5757922",
      "lat.": "24.9878909",
      "time": "11:00-22:00",
      "cuisine_type": "義式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5f0f9c03a102ec1415951-%E7%B1%B3%E5%A1%94%E7%BE%A9%E5%BC%8F%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "859",
      "name": "No. 8+9 一起冰沙吧",
      "address": "臺北市文山區新光路一段19號",
      "lng.": "121.5737677",
      "lat.": "24.9886958",
      "time": "10:30-21:30",
      "cuisine_type": "飲料",
      "rating": "4.3",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5af87f122756dd17962859f4-No.-8%2B9-%E4%B8%80%E8%B5%B7%E5%86%B0%E6%B2%99%E5%90%A7"
    },
    {
      "id": "860",
      "name": "王德福滷担麵館",
      "address": "臺北市文山區木新路三段357號",
      "lng.": "121.5556084",
      "lat.": "24.9802443",
      "time": "11:00-14:00, 16:45-20:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f572a312756dd155d8e58ec-%E7%8E%8B%E5%BE%B7%E7%A6%8F%E6%BB%B7%E6%8B%85%E9%BA%B5%E9%A4%A8"
    },
    {
      "id": "861",
      "name": "餐一咖",
      "address": "臺北市文山區萬慶街14號",
      "lng.": "121.5400305",
      "lat.": "24.9924415",
      "time": "11:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59e4f6052756dd59ca88e577-%E9%A4%90%E4%B8%80%E5%92%96"
    },
    {
      "id": "862",
      "name": "荷理固 麵館",
      "address": "臺北市文山區木新路三段75號",
      "lng.": "121.5634269",
      "lat.": "24.9821693",
      "time": "11:30-14:30, 17:30-20:30",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/590e0fef2756dd73705009c4-%E8%8D%B7%E7%90%86%E5%9B%BA-%E9%BA%B5%E9%A4%A8"
    },
    {
      "id": "863",
      "name": "人从众厚切牛排 (景美店)",
      "address": "臺北市文山區景文街137號",
      "lng.": "121.541122",
      "lat.": "24.9899846",
      "time": "11:00-22:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58fb9b3e2756dd27448b4ddc-%E4%BA%BA%E4%BB%8E%E4%BC%97%E5%8E%9A%E5%88%87%E7%89%9B%E6%8E%92-(%E6%99%AF%E7%BE%8E%E5%BA%97)"
    },
    {
      "id": "864",
      "name": "池上吾家木盒便當",
      "address": "臺北市文山區興隆路一段67號",
      "lng.": "121.5411853",
      "lat.": "25.0036763",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59af718ef5246859c43a7324-%E6%B1%A0%E4%B8%8A%E5%90%BE%E5%AE%B6%E6%9C%A8%E7%9B%92%E4%BE%BF%E7%95%B6"
    },
    {
      "id": "865",
      "name": "LIRA里拉義大利廚房",
      "address": "臺北市文山區木新路三段67號",
      "lng.": "121.5637081",
      "lat.": "24.982222",
      "time": "11:30-14:30, 17:00-21:30",
      "cuisine_type": "義式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57e963752756dd606545ba81-LIRA%E9%87%8C%E6%8B%89%E7%BE%A9%E5%A4%A7%E5%88%A9%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "866",
      "name": "老凃食堂 Tu's Meal House",
      "address": "臺北市文山區羅斯福路六段202巷1號",
      "lng.": "121.5405644",
      "lat.": "24.9937824",
      "time": "11:30-14:00, 17:30-20:30",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59875b352756dd22a8bd293b-%E8%80%81%E5%87%83%E9%A3%9F%E5%A0%82-Tu's-Meal-House"
    },
    {
      "id": "867",
      "name": "豐滿/總匯三明治",
      "address": "臺北市文山區景華街127號",
      "lng.": "121.547247",
      "lat.": "24.9962139",
      "time": "08:00-17:00",
      "cuisine_type": "美式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a407e3423679c4a791264d3-%E8%B1%90%E6%BB%BF%2F%E7%B8%BD%E5%8C%AF%E4%B8%89%E6%98%8E%E6%B2%BB"
    },
    {
      "id": "868",
      "name": "頂鼎食堂",
      "address": "臺北市文山區興隆路三段112巷3號",
      "lng.": "121.5572241",
      "lat.": "24.9988506",
      "time": "11:00-21:30",
      "cuisine_type": "台式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58600b1f2756dd757bb8f277-%E9%A0%82%E9%BC%8E%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "869",
      "name": "Creative Pasta 創義麵",
      "address": "臺北市文山區景文街155號",
      "lng.": "121.5410131",
      "lat.": "24.9893974",
      "time": "11:00-22:00",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5655fdf92756dd1d7a1b0189-Creative-Pasta-%E5%89%B5%E7%BE%A9%E9%BA%B5"
    },
    {
      "id": "870",
      "name": "義蘿蒂義大利麵",
      "address": "臺北市文山區景興路202巷8號",
      "lng.": "121.54331",
      "lat.": "24.992006",
      "time": "11:00-14:30, 17:00-21:00",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/595bd95c2756dd27dfff135a-%E7%BE%A9%E8%98%BF%E8%92%82%E7%BE%A9%E5%A4%A7%E5%88%A9%E9%BA%B5"
    },
    {
      "id": "871",
      "name": "FunCafe親子餐廳",
      "address": "臺北市文山區羅斯福路五段236巷3之2號3弄號",
      "lng.": "121.53829",
      "lat.": "25.0014493",
      "time": "11:30-20:30",
      "cuisine_type": "咖啡",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5665ca6e2756dd1228aa7d72-FunCafe%E8%A6%AA%E5%AD%90%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "872",
      "name": "龍角咖啡Dragon horn coffee",
      "address": "臺北市文山區指南路二段33號",
      "lng.": "121.573936",
      "lat.": "24.988132",
      "time": "11:00-21:00",
      "cuisine_type": "飲料|咖啡",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58372b482756dd4994cca22a-%E9%BE%8D%E8%A7%92%E5%92%96%E5%95%A1Dragon-horn-coff"
    },
    {
      "id": "873",
      "name": "巴東蜀味",
      "address": "臺北市文山區新光路一段40號",
      "lng.": "121.5736685",
      "lat.": "24.9896584",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a68259c03a104df53ca792-%E5%B7%B4%E6%9D%B1%E8%9C%80%E5%91%B3"
    },
    {
      "id": "874",
      "name": "海味豐",
      "address": "臺北市文山區景美街81號",
      "lng.": "121.5417928",
      "lat.": "24.9905717",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "日式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/594812af2756dd524dd0909d-%E6%B5%B7%E5%91%B3%E8%B1%90"
    },
    {
      "id": "875",
      "name": "小丼作食堂",
      "address": "臺北市文山區木新路三段13號",
      "lng.": "121.564914",
      "lat.": "24.9825458",
      "time": "12:00-14:00, 17:30-20:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5915a433699b6e035c137823-%E5%B0%8F%E4%B8%BC%E4%BD%9C%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "876",
      "name": "Hunger",
      "address": "臺北市文山區忠順街二段51號",
      "lng.": "121.5641941",
      "lat.": "24.9850187",
      "time": "06:30-15:30",
      "cuisine_type": "美式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/56744bba2756dd3d5352acb3-Hunger"
    },
    {
      "id": "877",
      "name": "菁串蔬食燒烤bar",
      "address": "臺北市文山區忠順街一段35號",
      "lng.": "121.558149",
      "lat.": "24.984042",
      "time": "17:00-23:00",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/593d1106699b6e2a61dc00c9-%E8%8F%81%E4%B8%B2%E8%94%AC%E9%A3%9F%E7%87%92%E7%83%A4bar"
    },
    {
      "id": "878",
      "name": "偵軒精緻鍋物(總店)",
      "address": "臺北市文山區景福街1號",
      "lng.": "121.539383",
      "lat.": "24.999398",
      "time": "11:30-14:30, 17:00-23:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57716b962756dd5159c80772-%E5%81%B5%E8%BB%92%E7%B2%BE%E7%B7%BB%E9%8D%8B%E7%89%A9(%E7%B8%BD%E5%BA%97)"
    },
    {
      "id": "879",
      "name": "一口壽司",
      "address": "臺北市文山區興隆路三段146號",
      "lng.": "121.5581103",
      "lat.": "24.9986932",
      "time": "10:00-20:20",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58275a162756dd1998ef6bad-%E4%B8%80%E5%8F%A3%E5%A3%BD%E5%8F%B8"
    },
    {
      "id": "880",
      "name": "Juicy Bun Burger 就是棒 美式餐廳",
      "address": "臺北市文山區萬壽路19號",
      "lng.": "121.5760434",
      "lat.": "24.9882457",
      "time": "11:30-22:00",
      "cuisine_type": "美式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5e489c03a102ec1415553-Juicy-Bun-Burger-%E5%B0%B1%E6%98%AF%E6%A3%92"
    },
    {
      "id": "881",
      "name": "木新蚵仔麵線",
      "address": "臺北市文山區木新路三段183巷",
      "lng.": "121.5603807",
      "lat.": "24.9812356",
      "time": "11:30-19:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/592048cef5246847927ff2c9-%E6%9C%A8%E6%96%B0%E8%9A%B5%E4%BB%94%E9%BA%B5%E7%B7%9A"
    },
    {
      "id": "882",
      "name": "福鼎湯包店二店",
      "address": "臺北市文山區興隆路三段31號",
      "lng.": "121.5555773",
      "lat.": "25.0006348",
      "time": "06:30-22:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59bb781e23679c4ecb5b88c1-%E7%A6%8F%E9%BC%8E%E6%B9%AF%E5%8C%85%E5%BA%97%E4%BA%8C%E5%BA%97"
    },
    {
      "id": "883",
      "name": "佳香北平烤鴨",
      "address": "臺北市文山區興隆路二段204號",
      "lng.": "121.552081",
      "lat.": "25.001545",
      "time": "10:30-21:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/590fd789699b6e5795dd2892-%E4%BD%B3%E9%A6%99%E5%8C%97%E5%B9%B3%E7%83%A4%E9%B4%A8"
    },
    {
      "id": "884",
      "name": "青島包子專賣店",
      "address": "臺北市文山區興隆路二段220巷18號",
      "lng.": "121.5522475",
      "lat.": "25.0006501",
      "time": "06:30-11:00, 15:30-20:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d7f2bc03a103ee86c8082-%E9%9D%92%E5%B3%B6%E5%8C%85%E5%AD%90%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "885",
      "name": "永康街左撇子",
      "address": "臺北市文山區指南路二段119巷10號",
      "lng.": "121.5765219",
      "lat.": "24.9878368",
      "time": "11:30-14:00, 17:00-20:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5908cb7c2756dd5ad265daf2-%E6%B0%B8%E5%BA%B7%E8%A1%97%E5%B7%A6%E6%92%87%E5%AD%90"
    },
    {
      "id": "886",
      "name": "佳味自助餐",
      "address": "臺北市文山區指南路二段155號",
      "lng.": "121.5774447",
      "lat.": "24.987466",
      "time": "10:00-14:00, 16:30-20:00",
      "cuisine_type": "台式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5906a6c823679c5ccf198e9d-%E4%BD%B3%E5%91%B3%E8%87%AA%E5%8A%A9%E9%A4%90"
    },
    {
      "id": "887",
      "name": "九湯屋日式拉麵 景美店",
      "address": "臺北市文山區景美街141號",
      "lng.": "121.5415322",
      "lat.": "24.9895168",
      "time": "11:30-21:30",
      "cuisine_type": "日式",
      "rating": "3.7",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5904d5db2756dd5ad565d947-%E4%B9%9D%E6%B9%AF%E5%B1%8B%E6%97%A5%E5%BC%8F%E6%8B%89%E9%BA%B5-%E6%99%AF%E7%BE%8E%E5%BA%97"
    },
    {
      "id": "888",
      "name": "榆小舖",
      "address": "臺北市文山區羅斯福路六段269號後棟",
      "lng.": "121.5415737",
      "lat.": "24.9948236",
      "time": "17:30-22:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4f46dc03a10241de63b4c-%E6%A6%86%E5%B0%8F%E8%88%96"
    },
    {
      "id": "889",
      "name": "景美夜市-油飯.蚵仔麵線",
      "address": "臺北市文山區景美街139號",
      "lng.": "121.5415143",
      "lat.": "24.9895567",
      "time": "17:00-23:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/587e5dc42756dd3ab3f6b585-%E6%99%AF%E7%BE%8E%E5%A4%9C%E5%B8%82-%E6%B2%B9%E9%A3%AF.%E8%9A%B5%E4%BB%94%E9%BA%B5%E7%B7%9A"
    },
    {
      "id": "890",
      "name": "磨豆花棧",
      "address": "臺北市文山區保儀路73號",
      "lng.": "121.568596",
      "lat.": "24.9870019",
      "time": "14:00-22:30",
      "cuisine_type": "飲料",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d6387c03a103ee86c6de7-%E7%A3%A8%E8%B1%86%E8%8A%B1%E6%A3%A7"
    },
    {
      "id": "891",
      "name": "白師父熱炒",
      "address": "臺北市文山區興隆路三段15號",
      "lng.": "121.555062",
      "lat.": "25.000876",
      "time": "17:00-00:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a530b4c03a10241de65016-%E7%99%BD%E5%B8%AB%E7%88%B6%E7%86%B1%E7%82%92"
    },
    {
      "id": "892",
      "name": "Jim's Burger",
      "address": "臺北市文山區景興路282巷1號",
      "lng.": "121.54202",
      "lat.": "24.989523",
      "time": "06:30-18:00",
      "cuisine_type": "美式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/564387462756dd40eaa05fbe-Jim's-Burger"
    },
    {
      "id": "893",
      "name": "景美夜市詹氏燒肉刈包",
      "address": "臺北市文山區景美街75號",
      "lng.": "121.541812",
      "lat.": "24.990672",
      "time": "16:30-22:30",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58ed1a402756dd328d6c4f6d-%E6%99%AF%E7%BE%8E%E5%A4%9C%E5%B8%82%E8%A9%B9%E6%B0%8F%E7%87%92%E8%82%89%E5%88%88%E5%8C%85"
    },
    {
      "id": "894",
      "name": "韓國首爾小吃",
      "address": "臺北市文山區木柵路二段147號",
      "lng.": "121.5627449",
      "lat.": "24.9891092",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "韓式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5eb75c03a102ec1415794-%E9%9F%93%E5%9C%8B%E9%A6%96%E7%88%BE%E5%B0%8F%E5%90%83"
    },
    {
      "id": "895",
      "name": "葉記鴨肉飯",
      "address": "臺北市文山區指南路一段60號",
      "lng.": "121.570419",
      "lat.": "24.98767",
      "time": "11:30-14:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58edbca823679c103482baff-%E8%91%89%E8%A8%98%E9%B4%A8%E8%82%89%E9%A3%AF"
    },
    {
      "id": "896",
      "name": "老頭家客家菜",
      "address": "臺北市文山區忠順街一段159號",
      "lng.": "121.5612903",
      "lat.": "24.9845227",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/58de9b552756dd7a7c2b3bb7-%E8%80%81%E9%A0%AD%E5%AE%B6%E5%AE%A2%E5%AE%B6%E8%8F%9C"
    },
    {
      "id": "897",
      "name": "福圓號真功夫養生饅頭",
      "address": "臺北市文山區興隆路三段298號",
      "lng.": "121.5588256",
      "lat.": "24.9932123",
      "time": "12:00-20:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d96b1c03a103ee86c8d69-%E7%A6%8F%E5%9C%93%E8%99%9F%E7%9C%9F%E5%8A%9F%E5%A4%AB%E9%A4%8A%E7%94%9F%E9%A5%85%E9%A0%AD"
    },
    {
      "id": "898",
      "name": "景明蚵仔麵線",
      "address": "臺北市文山區羅斯福路五段269巷景明街",
      "lng.": "121.5409502",
      "lat.": "25.0015103",
      "time": "暫時無資訊",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/577aa4bf2756dd3ca9069804-%E6%99%AF%E6%98%8E%E8%9A%B5%E4%BB%94%E9%BA%B5%E7%B7%9A"
    },
    {
      "id": "899",
      "name": "韓大佬韓式精緻料理",
      "address": "臺北市文山區新光路一段27號",
      "lng.": "121.573903",
      "lat.": "24.9892959",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "韓式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58b1c75a2756dd4b2e792050-%E9%9F%93%E5%A4%A7%E4%BD%AC%E9%9F%93%E5%BC%8F%E7%B2%BE%E7%B7%BB%E6%96%99%E7%90%86"
    },
    {
      "id": "900",
      "name": "Arty Burger(政大店)",
      "address": "臺北市文山區指南路二段45巷12號",
      "lng.": "121.574557",
      "lat.": "24.988768",
      "time": "07:00-15:00",
      "cuisine_type": "美式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/576983122756dd134b34d02f-Arty-Burger(%E6%94%BF%E5%A4%A7%E5%BA%97)"
    },
    {
      "id": "901",
      "name": "貓空咖啡巷",
      "address": "臺北市文山區指南路三段38巷33之5號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "10:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56744bb72756dd3d5352acad-%E8%B2%93%E7%A9%BA%E5%92%96%E5%95%A1%E5%B7%B7"
    },
    {
      "id": "902",
      "name": "Iceパン霜淇淋堡",
      "address": "臺北市文山區興隆路二段220巷31弄28號",
      "lng.": "121.552975",
      "lat.": "25.000159",
      "time": "11:00-22:00",
      "cuisine_type": "飲料",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5859734a2756dd757bb8f0d2-Ice%E3%83%91%E3%83%B3%E9%9C%9C%E6%B7%87%E6%B7%8B%E5%A0%A1"
    },
    {
      "id": "903",
      "name": "Louisa Coffee 路易．莎咖啡(木新店)",
      "address": "臺北市文山區木新路三段177號",
      "lng.": "121.5605018",
      "lat.": "24.9815344",
      "time": "07:00-20:00",
      "cuisine_type": "飲料",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/581b2c572756dd14161a0158-Louisa-Coffee-%E8%B7%AF%E6%98%93%EF%BC%8E%E8%8E%8E%E5%92%96%E5%95%A1"
    },
    {
      "id": "904",
      "name": "Go! Cafe 早午餐",
      "address": "臺北市文山區新光路一段34之1號",
      "lng.": "121.5736",
      "lat.": "24.9893179",
      "time": "06:30-14:30",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5812a7b823679c3507dad40e-Go!-Cafe-%E6%97%A9%E5%8D%88%E9%A4%90"
    },
    {
      "id": "905",
      "name": "四哥的店",
      "address": "臺北市文山區指南路三段38巷33之1號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "11:30-22:00",
      "cuisine_type": "港式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d01c9c03a103ee86c32ba-%E5%9B%9B%E5%93%A5%E7%9A%84%E5%BA%97"
    },
    {
      "id": "906",
      "name": "let's italy 出發義大利廚房",
      "address": "臺北市文山區木柵路一段137號",
      "lng.": "121.5502165",
      "lat.": "24.9876051",
      "time": "11:30-14:30, 17:00-20:30",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/579ed470699b6e62dfa4183c-let's-italy-%E5%87%BA%E7%99%BC%E7%BE%A9%E5%A4%A7%E5%88%A9%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "907",
      "name": "大家素食",
      "address": "臺北市文山區車前路3號",
      "lng.": "121.541107",
      "lat.": "24.9912299",
      "time": "11:00-14:00, 17:00-20:30",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57b2073a2756dd37bbd6ed9e-%E5%A4%A7%E5%AE%B6%E7%B4%A0%E9%A3%9F"
    },
    {
      "id": "908",
      "name": "小張小吃店",
      "address": "臺北市文山區景文街49號",
      "lng.": "121.5414047",
      "lat.": "24.9917802",
      "time": "暫時無資訊",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/576c25d52756dd05fa6ca50a-%E5%B0%8F%E5%BC%B5%E5%B0%8F%E5%90%83%E5%BA%97"
    },
    {
      "id": "909",
      "name": "樂山食堂",
      "address": "臺北市文山區新光路一段26號",
      "lng.": "121.573557",
      "lat.": "24.989007",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d0160c03a103ee86c328b-%E6%A8%82%E5%B1%B1%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "910",
      "name": "緣聚成家蔬食料理",
      "address": "臺北市文山區木新路三段152號",
      "lng.": "121.5613715",
      "lat.": "24.9819767",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c74e5e22261395854b93685-%E7%B7%A3%E8%81%9A%E6%88%90%E5%AE%B6%E8%94%AC%E9%A3%9F%E6%96%99%E7%90%86"
    },
    {
      "id": "911",
      "name": "味自慢 居酒屋",
      "address": "臺北市文山區景興路118號",
      "lng.": "121.5443145",
      "lat.": "24.9935417",
      "time": "17:30-22:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/55a5041dc03a10241de640ff-%E5%91%B3%E8%87%AA%E6%85%A2-%E5%B1%85%E9%85%92%E5%B1%8B"
    },
    {
      "id": "912",
      "name": "羅馬蕃茄義大利麵蔬食",
      "address": "臺北市文山區木新路三段139號",
      "lng.": "121.5616563",
      "lat.": "24.9818032",
      "time": "11:30-14:30, 17:30-21:00",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56d094602756dd66e76a5d41-%E7%BE%85%E9%A6%AC%E8%95%83%E8%8C%84%E7%BE%A9%E5%A4%A7%E5%88%A9%E9%BA%B5%E8%94%AC%E9%A3%9F"
    },
    {
      "id": "913",
      "name": "大家素食",
      "address": "臺北市文山區興隆路三段112巷2弄23號",
      "lng.": "121.5563548",
      "lat.": "24.9993013",
      "time": "11:30-14:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56c4b6f72756dd75130ce443-%E5%A4%A7%E5%AE%B6%E7%B4%A0%E9%A3%9F"
    },
    {
      "id": "914",
      "name": "永旺水餃",
      "address": "臺北市文山區保儀路163號",
      "lng.": "121.5662736",
      "lat.": "24.9839672",
      "time": "暫時無資訊",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56b2412b2756dd3609e2ff67-%E6%B0%B8%E6%97%BA%E6%B0%B4%E9%A4%83"
    },
    {
      "id": "915",
      "name": "天恩至德素食糕餅",
      "address": "臺北市文山區指南路三段38巷37之2號",
      "lng.": "121.5918065",
      "lat.": "24.9686888",
      "time": "08:00-18:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56aa58882756dd600d5e592d-%E5%A4%A9%E6%81%A9%E8%87%B3%E5%BE%B7%E7%B4%A0%E9%A3%9F%E7%B3%95%E9%A4%85"
    },
    {
      "id": "916",
      "name": "小曼谷滇泰料理",
      "address": "臺北市文山區指南路二段19號",
      "lng.": "121.573542",
      "lat.": "24.988301",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "泰式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a67909c03a104df53ca4f2-%E5%B0%8F%E6%9B%BC%E8%B0%B7%E6%BB%87%E6%B3%B0%E6%96%99%E7%90%86"
    },
    {
      "id": "917",
      "name": "Hot 7新鐵板料理",
      "address": "臺北市文山區景中街1號",
      "lng.": "121.541543",
      "lat.": "24.993062",
      "time": "11:30-14:30, 17:30-22:00",
      "cuisine_type": "日式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5af3043223679c29aa040ccf-Hot-7%E6%96%B0%E9%90%B5%E6%9D%BF%E6%96%99%E7%90%86"
    },
    {
      "id": "918",
      "name": "榮記點心",
      "address": "臺北市文山區景文街27號",
      "lng.": "121.5414106",
      "lat.": "24.9924998",
      "time": "07:30-19:30",
      "cuisine_type": "中式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55e0a4852756dd647bd686d1-%E6%A6%AE%E8%A8%98%E9%BB%9E%E5%BF%83"
    },
    {
      "id": "919",
      "name": "竹壽司",
      "address": "臺北市文山區羅斯福路六段9號",
      "lng.": "121.539863",
      "lat.": "25.000299",
      "time": "12:00-14:30, 17:30-21:30",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d97e4c03a103ee86c8dfb-%E7%AB%B9%E5%A3%BD%E5%8F%B8"
    },
    {
      "id": "920",
      "name": "順園美食",
      "address": "臺北市文山區木柵路三段1號",
      "lng.": "121.5644101",
      "lat.": "24.9886737",
      "time": "11:00-21:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d80c5c03a103ee86c8136-%E9%A0%86%E5%9C%92%E7%BE%8E%E9%A3%9F"
    },
    {
      "id": "921",
      "name": "微笑碳烤",
      "address": "臺北市文山區景美街",
      "lng.": "121.5416403",
      "lat.": "24.9916431",
      "time": "00:00-01:00, 17:30-00:00",
      "cuisine_type": "台式",
      "rating": "3",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55b9390f40b5e303a1d56637-%E5%BE%AE%E7%AC%91%E7%A2%B3%E7%83%A4"
    },
    {
      "id": "922",
      "name": "寒舍茶坊",
      "address": "臺北市文山區指南路三段40巷6號",
      "lng.": "121.597309",
      "lat.": "24.96743",
      "time": "09:00-22:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55b935da40b5e303a1d5658f-%E5%AF%92%E8%88%8D%E8%8C%B6%E5%9D%8A"
    },
    {
      "id": "923",
      "name": "新味珍海產店",
      "address": "臺北市文山區興隆路三段27號旁邊",
      "lng.": "121.5554642",
      "lat.": "25.0007207",
      "time": "00:00-00:45, 17:30-00:00",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a582e8c03a10241de66c93-%E6%96%B0%E5%91%B3%E7%8F%8D%E6%B5%B7%E7%94%A2%E5%BA%97"
    },
    {
      "id": "924",
      "name": "金鮨日式料理",
      "address": "臺北市文山區指南路二段205號",
      "lng.": "121.578674",
      "lat.": "24.9869622",
      "time": "11:00-15:00, 17:00-20:30",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d2cfbc03a103ee86c4ac4-%E9%87%91%E9%AE%A8%E6%97%A5%E5%BC%8F%E6%96%99%E7%90%86"
    },
    {
      "id": "925",
      "name": "四川飯館",
      "address": "臺北市文山區指南路二段65號2樓",
      "lng.": "121.5747597",
      "lat.": "24.9879209",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4f747c03a10241de63c39-%E5%9B%9B%E5%B7%9D%E9%A3%AF%E9%A4%A8"
    },
    {
      "id": "926",
      "name": "王記手工水餃",
      "address": "臺北市文山區興隆路二段97號",
      "lng.": "121.5474476",
      "lat.": "24.9997246",
      "time": "10:00-18:00",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a6693ec03a104df53ca09f-%E7%8E%8B%E8%A8%98%E6%89%8B%E5%B7%A5%E6%B0%B4%E9%A4%83"
    },
    {
      "id": "927",
      "name": "東京小城",
      "address": "臺北市文山區指南路二段207號",
      "lng.": "121.5786804",
      "lat.": "24.9869282",
      "time": "11:00-14:00, 17:00-20:30",
      "cuisine_type": "日式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d01a7c03a103ee86c32a8-%E6%9D%B1%E4%BA%AC%E5%B0%8F%E5%9F%8E"
    },
    {
      "id": "928",
      "name": "私房麵",
      "address": "臺北市文山區指南路二段2號",
      "lng.": "121.574073",
      "lat.": "24.987844",
      "time": "11:00-14:30, 17:00-20:30",
      "cuisine_type": "中式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a68201c03a104df53ca77b-%E7%A7%81%E6%88%BF%E9%BA%B5"
    },
    {
      "id": "929",
      "name": "越南大食館",
      "address": "臺北市文山區保儀路86號",
      "lng.": "121.568308",
      "lat.": "24.9871",
      "time": "09:00-20:00",
      "cuisine_type": "東南亞",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559de39bc03a103ee86cbb57-%E8%B6%8A%E5%8D%97%E5%A4%A7%E9%A3%9F%E9%A4%A8"
    },
    {
      "id": "930",
      "name": "宣德炭燒羊肉爐",
      "address": "臺北市文山區景隆街40號",
      "lng.": "121.543845",
      "lat.": "24.998626",
      "time": "16:00-00:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55b9495940b5e303a1d56982-%E5%AE%A3%E5%BE%B7%E7%82%AD%E7%87%92%E7%BE%8A%E8%82%89%E7%88%90"
    },
    {
      "id": "931",
      "name": "鳳臨食養天地",
      "address": "臺北市文山區老泉街26巷27號",
      "lng.": "121.5678809",
      "lat.": "24.9711676",
      "time": "11:30-14:30, 17:30-20:30",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": "內用|",
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/559d1b03c03a103ee86c3f20-%E9%B3%B3%E8%87%A8%E9%A3%9F%E9%A4%8A%E5%A4%A9%E5%9C%B0"
    },
    {
      "id": "932",
      "name": "shabu鮮涮涮鍋",
      "address": "臺北市文山區萬壽路23號",
      "lng.": "121.5761296",
      "lat.": "24.9882596",
      "cuisine_type": "日式",
      "rating": "3.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f572a8d2756dd155d8e599e-shabu%E9%AE%AE%E6%B6%AE%E6%B6%AE%E9%8D%8B"
    },
    {
      "id": "933",
      "name": "齊味餃子館",
      "address": "臺北市文山區景華街178號",
      "lng.": "121.5480155",
      "lat.": "24.9973242",
      "time": "11:30-14:00, 17:30-20:30",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d5919c03a103ee86c678f-%E9%BD%8A%E5%91%B3%E9%A4%83%E5%AD%90%E9%A4%A8"
    },
    {
      "id": "934",
      "name": "福利餐廳",
      "address": "臺北市文山區興隆路一段167號",
      "lng.": "121.5427523",
      "lat.": "25.0014613",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4f78bc03a10241de63c51-%E7%A6%8F%E5%88%A9%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "935",
      "name": "迺妙茶廬",
      "address": "臺北市文山區指南路三段34巷53號",
      "lng.": "121.5832996",
      "lat.": "24.9657734",
      "time": "09:00-22:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dbe51c03a103ee86ca3d6-%E8%BF%BA%E5%A6%99%E8%8C%B6%E5%BB%AC"
    },
    {
      "id": "936",
      "name": "錢都涮涮鍋",
      "address": "臺北市文山區羅斯福路六段26號",
      "lng.": "121.539486",
      "lat.": "24.999876",
      "time": "11:00-22:30",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/565624882756dd1d7a1b04e8-%E9%8C%A2%E9%83%BD%E6%B6%AE%E6%B6%AE%E9%8D%8B"
    },
    {
      "id": "937",
      "name": "吉野家",
      "address": "臺北市文山區景文街99號",
      "lng.": "121.541355",
      "lat.": "24.9908479",
      "time": "00:00-04:00, 05:00-00:00",
      "cuisine_type": "日式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4f528c03a10241de63b90-%E5%90%89%E9%87%8E%E5%AE%B6"
    },
    {
      "id": "938",
      "name": "西貢越南美食",
      "address": "臺北市文山區興隆路三段36巷14弄2號",
      "lng.": "121.5551436",
      "lat.": "24.999905",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "東南亞",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a684f6c03a104df53ca844-%E8%A5%BF%E8%B2%A2%E8%B6%8A%E5%8D%97%E7%BE%8E%E9%A3%9F"
    },
    {
      "id": "939",
      "name": "好菜場生猛海鮮",
      "address": "臺北市文山區興隆路一段225號",
      "lng.": "121.543797",
      "lat.": "25.00017",
      "time": "00:00-02:00, 16:00-00:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f5f6a7fd6895d2531ea2b24-%E5%A5%BD%E8%8F%9C%E5%A0%B4%E7%94%9F%E7%8C%9B%E6%B5%B7%E9%AE%AE"
    }
  ];
/*
  var _restaurants_data2 = [
    {
      "id": "650",
      "name": "狸奴 LI-NU",
      "address": "臺北市文山區興隆路三段231號",
      "lng.": "121.5592252",
      "lat.": "24.9933762",
      "cuisine_type": "中式|美式|歐式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/600532d42261394835d34a5f-%E7%8B%B8%E5%A5%B4-LI-NU"
    },
    {
      "id": "651",
      "name": "巷仔內米粉湯",
      "address": "臺北市文山區景美街119號",
      "lng.": "121.5413679",
      "lat.": "24.9899102",
      "time": "18:00-00:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用','外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5beffc03a10241de67f8c-%E5%B7%B7%E4%BB%94%E5%85%A7%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "652",
      "name": "星靚點花園飯店",
      "address": "臺北市文山區景後街81號",
      "lng.": "121.5435223",
      "lat.": "24.9919951",
      "time": "10:00-22:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用','外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5feb19c9d6895d5cb8c6fb0f-%E6%98%9F%E9%9D%9A%E9%BB%9E%E8%8A%B1%E5%9C%92%E9%A3%AF%E5%BA%97"
    },
    {
      "id": "653",
      "name": "香港珍園燒臘店",
      "address": "臺北市文山區興隆路三段176號",
      "lng.": "121.5585696",
      "lat.": "24.998053",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "港式",
      "rating": "4",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ffdb0732756dd705ee292e6-%E9%A6%99%E6%B8%AF%E7%8F%8D%E5%9C%92%E7%87%92%E8%87%98%E5%BA%97"
    },
    {
      "id": "654",
      "name": "鴻記石鍋",
      "address": "臺北市文山區興隆路四段130號",
      "lng.": "121.5622009",
      "lat.": "24.9824113",
      "time": "17:30-21:30",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fe74e8002935e671887ab26-%E9%B4%BB%E8%A8%98%E7%9F%B3%E9%8D%8B"
    },
    {
      "id": "655",
      "name": "Spyci私宅咖哩炸雞店",
      "address": "臺北市文山區景興路30之1號",
      "lng.": "121.54454",
      "lat.": "24.997384",
      "time": "15:00-22:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59c15e3a2756dd528db72d62-Spyci%E7%A7%81%E5%AE%85%E5%92%96%E5%93%A9%E7%82%B8%E9%9B%9E%E5%BA%97"
    },
    {
      "id": "656",
      "name": "清原芋圓—臺北景美店",
      "address": "臺北市文山區景華街67號",
      "lng.": "121.5449871",
      "lat.": "24.9952522",
      "time": "10:30-22:00",
      "cuisine_type": "飲料",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe3528d2756dd79fdc48365-%E6%B8%85%E5%8E%9F%E8%8A%8B%E5%9C%93%E2%80%94%E5%8F%B0%E5%8C%97%E6%99%AF%E7%BE%8E%E5%BA%97"
    },
    {
      "id": "657",
      "name": "胖夫妻日式料理",
      "address": "臺北市文山區興隆路三段36巷6號",
      "lng.": "121.5552827",
      "lat.": "25.000191",
      "time": "11:00-14:30, 17:30-21:00",
      "cuisine_type": "日本",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fe1ad488c906d2bdcc0fffd-%E8%83%96%E5%A4%AB%E5%A6%BB%E6%97%A5%E5%BC%8F%E6%96%99%E7%90%86"
    },
    {
      "id": "658",
      "name": "景美夜市炸三鮮/米粉湯",
      "address": "臺北市文山區景美街119號",
      "lng.": "121.5413679",
      "lat.": "24.9899102",
      "time": "16:00-22:30",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f621f902756dd3c89419a4f-%E6%99%AF%E7%BE%8E%E5%A4%9C%E5%B8%82%E7%82%B8%E4%B8%89%E9%AE%AE%2F%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "659",
      "name": "李白Breakfast x coffee",
      "address": "臺北市文山區萬壽路25巷7號1樓",
      "lng.": "121.5761242",
      "lat.": "24.988972",
      "time": "07:00-15:00",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe00b73d6895d5b179483c2-%E6%9D%8E%E7%99%BDBreakfast-x-coffee"
    },
    {
      "id": "660",
      "name": "夜奔咖哩 Fleeingbynightcurry",
      "address": "臺北市文山區景文街19號",
      "lng.": "121.54143",
      "lat.": "24.992661",
      "time": "17:00-22:00",
      "cuisine_type": "日式|中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ab854a223679c276511fbcf-%E5%A4%9C%E5%A5%94%E5%92%96%E5%93%A9-Fleeingbynightc"
    },
    {
      "id": "661",
      "name": "肉多多火鍋-臺北景美店",
      "address": "臺北市文山區景文街42號2樓號",
      "lng.": "121.5411941",
      "lat.": "24.9917264",
      "time": "00:00-04:00, 11:30-15:00, 17:30-00:00",
      "cuisine_type": "日式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ad788bf2756dd41bce10a2a-%E8%82%89%E5%A4%9A%E5%A4%9A%E7%81%AB%E9%8D%8B-%E5%8F%B0%E5%8C%97%E6%99%AF%E7%BE%8E%E5%BA%97"
    },
    {
      "id": "662",
      "name": "爐子煮賣所 Forno & Stufa",
      "address": "臺北市文山區汀州路四段132號",
      "lng.": "121.5357441",
      "lat.": "25.00542",
      "time": "11:30-14:30, 17:30-20:30",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/598ca0b12756dd407aa87a36-%E7%88%90%E5%AD%90%E7%85%AE%E8%B3%A3%E6%89%80-Forno-%26-Stufa"
    },
    {
      "id": "663",
      "name": "晟豐北斗肉圓",
      "address": "臺北市文山區景隆街10號",
      "lng.": "121.540246",
      "lat.": "25.0000366",
      "time": "11:30-20:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fd774f32756dd3b52ec765c-%E6%99%9F%E8%B1%90%E5%8C%97%E6%96%97%E8%82%89%E5%9C%93"
    },
    {
      "id": "664",
      "name": "滇味廚房",
      "address": "臺北市文山區指南路二段167號",
      "lng.": "121.5776291",
      "lat.": "24.9874019",
      "time": "11:00-21:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57127f122756dd066e9d3800-%E6%BB%87%E5%91%B3%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "665",
      "name": "如意豆漿店",
      "address": "臺北市文山區忠順街一段119號",
      "lng.": "121.5598926",
      "lat.": "24.9843205",
      "time": "05:00-11:00",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": "內用|",
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56aa57872756dd600d5e5900-%E5%A6%82%E6%84%8F%E8%B1%86%E6%BC%BF%E5%BA%97"
    },
    {
      "id": "666",
      "name": "辛王記涼麵美食專賣店",
      "address": "臺北市文山區木柵路三段3號",
      "lng.": "121.564606",
      "lat.": "24.988598",
      "time": "11:00-21:00",
      "cuisine_type": "台式|日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fd4d22c2756dd406822b654-%E8%BE%9B%E7%8E%8B%E8%A8%98%E6%B6%BC%E9%BA%B5%E7%BE%8E%E9%A3%9F%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "667",
      "name": "鵝媽媽鵝肉切仔麵",
      "address": "臺北市文山區景美街37之3號",
      "lng.": "121.5418094",
      "lat.": "24.9915751",
      "time": "15:00-23:30",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d1a80c03a103ee86c3ed7-%E9%B5%9D%E5%AA%BD%E5%AA%BD%E9%B5%9D%E8%82%89%E5%88%87%E4%BB%94%E9%BA%B5"
    },
    {
      "id": "668",
      "name": "成家小館",
      "address": "臺北市文山區木新路三段154號",
      "lng.": "121.5612754",
      "lat.": "24.9819877",
      "time": "11:30-13:30, 17:00-21:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5545cc03a10241de65cab-%E6%88%90%E5%AE%B6%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "669",
      "name": "貓空清泉山莊",
      "address": "臺北市文山區指南路三段38巷33之3號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "10:00-21:00",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e0ecb3f8c906d485fc4b686-%E8%B2%93%E7%A9%BA%E6%B8%85%E6%B3%89%E5%B1%B1%E8%8E%8A"
    },
    {
      "id": "670",
      "name": "MAG麵革",
      "address": "臺北市文山區福興路36號",
      "lng.": "121.5509422",
      "lat.": "25.0031282",
      "time": "11:30-21:00",
      "cuisine_type": "義式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fac9f5d2261396bcb7b6baa-MAG%E9%BA%B5%E9%9D%A9"
    },
    {
      "id": "671",
      "name": "生活在他方-夜貓店",
      "address": "臺北市文山區指南路三段40巷8之5號",
      "lng.": "121.5949951",
      "lat.": "24.9689748",
      "time": "12:00-00:00",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5eb56b1f2756dd0ba876909f-%E7%94%9F%E6%B4%BB%E5%9C%A8%E4%BB%96%E6%96%B9-%E5%A4%9C%E8%B2%93%E5%BA%97"
    },
    {
      "id": "672",
      "name": "黑碗豆花",
      "address": "臺北市文山區木柵路二段197號",
      "lng.": "121.563882",
      "lat.": "24.9888687",
      "time": "12:00-19:00",
      "cuisine_type": "飲料",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fb3dc882756dd3ffeb9049a-%E9%BB%91%E7%A2%97%E8%B1%86%E8%8A%B1"
    },
    {
      "id": "673",
      "name": "石川日式食堂",
      "address": "臺北市文山區景華街60號",
      "lng.": "121.5443195",
      "lat.": "24.9949778",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "日本",
      "rating": "4.4",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/595541d12756dd4ec3f45117-%E7%9F%B3%E5%B7%9D%E6%97%A5%E5%BC%8F%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "674",
      "name": "江記水盆羊肉",
      "address": "臺北市文山區指南路二段45巷12號",
      "lng.": "121.574557",
      "lat.": "24.988768",
      "time": "11:30-14:00, 17:00-20:30",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d9e09c03a103ee86c910c-%E6%B1%9F%E8%A8%98%E6%B0%B4%E7%9B%86%E7%BE%8A%E8%82%89"
    },
    {
      "id": "675",
      "name": "Ruins Coffee Roasters",
      "address": "臺北市文山區木柵路三段242號",
      "lng.": "121.5710487",
      "lat.": "24.9907558",
      "time": "13:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/582f43af2756dd2cb59c9ae5-Ruins-Coffee-Roaster"
    },
    {
      "id": "676",
      "name": "墨•山崴-MORE‧shan wei",
      "address": "臺北市文山區羅斯福路五段215號",
      "lng.": "121.539124",
      "lat.": "25.002185",
      "cuisine_type": "台式|日式|歐式",
      "rating": "4.5",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5edf277ad6895d37bdc03ee0-%E5%A2%A8%E2%80%A2%E5%B1%B1%E5%B4%B4-MORE%E2%80%A7shan-wei"
    },
    {
      "id": "677",
      "name": "兩盞燈食試所 X 大毛陶磁器",
      "address": "臺北市文山區羅斯福路六段310號2樓",
      "lng.": "121.539649",
      "lat.": "24.990558",
      "time": "暫時無資訊",
      "cuisine_type": "飲料|日式|美式",
      "rating": "4.7",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bf418c82756dd4b96d3ef3b-%E5%85%A9%E7%9B%9E%E7%87%88%E9%A3%9F%E8%A9%A6%E6%89%80-X-%E5%A4%A7%E6%AF%9B%E9%99%B6%E7%A3%81%E5%99%A8"
    },
    {
      "id": "678",
      "name": "陶媽大餛飩/水餃",
      "address": "臺北市文山區育英街5號",
      "lng.": "121.5394124",
      "lat.": "24.9904532",
      "time": "11:00-20:00",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5faeb21a02935e22d67b09a8-%E9%99%B6%E5%AA%BD%E5%A4%A7%E9%A4%9B%E9%A3%A9%2F%E6%B0%B4%E9%A4%83"
    },
    {
      "id": "679",
      "name": "PATIO46 美式餐廳",
      "address": "臺北市文山區興隆路三段112巷4弄46號1樓號",
      "lng.": "121.5557477",
      "lat.": "24.9993247",
      "time": "11:00-21:00",
      "cuisine_type": "美式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bfb94a5226139568f6491c7-PATIO46-%E7%BE%8E%E5%BC%8F%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "680",
      "name": "5senses cafe",
      "address": "臺北市文山區興隆路三段112巷2弄25號",
      "lng.": "121.5562851",
      "lat.": "24.9993494",
      "time": "12:00-20:30",
      "cuisine_type": "咖啡",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55d76a6f2756dd0b3b8dbb1f-5senses-cafe"
    },
    {
      "id": "681",
      "name": "巷仔內傳統碳燒豆花專賣店",
      "address": "臺北市文山區興隆路三段304巷11號",
      "lng.": "121.5584137",
      "lat.": "24.9934827",
      "time": "15:00-21:00",
      "cuisine_type": "飲料",
      "rating": "4.3",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f9c217a2756dd2d99d34a1a-%E5%B7%B7%E4%BB%94%E5%85%A7%E5%82%B3%E7%B5%B1%E7%A2%B3%E7%87%92%E8%B1%86%E8%8A%B1%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "682",
      "name": "滕老私廚",
      "address": "臺北市文山區木新路三段403號",
      "lng.": "121.554528",
      "lat.": "24.979967",
      "time": "12:00-21:00",
      "cuisine_type": "中式",
      "rating": "3.7",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56568491699b6e098414dc10-%E6%BB%95%E8%80%81%E7%A7%81%E5%BB%9A"
    },
    {
      "id": "683",
      "name": "富貴饅頭",
      "address": "臺北市文山區辛亥路五段15號",
      "lng.": "121.5544345",
      "lat.": "25.0001795",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f8ce2062261394a508ab012-%E5%AF%8C%E8%B2%B4%E9%A5%85%E9%A0%AD"
    },
    {
      "id": "684",
      "name": "鼎豐鴛鴦麻辣火鍋",
      "address": "臺北市文山區羅斯福路四段200號",
      "lng.": "121.5365841",
      "lat.": "25.0106968",
      "time": "11:30-23:45",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5caeaf8bf5246874dd81196b-%E9%BC%8E%E8%B1%90%E9%B4%9B%E9%B4%A6%E9%BA%BB%E8%BE%A3%E7%81%AB%E9%8D%8B"
    },
    {
      "id": "685",
      "name": "雞老闆 桶仔雞 萬隆店",
      "address": "臺北市文山區羅斯福路五段69號",
      "lng.": "121.539205",
      "lat.": "25.006343",
      "time": "00:00-02:30, 17:00-00:00",
      "cuisine_type": "台式|日式|餐酒館/酒吧",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d35194ad6895d079b93976c-%E9%9B%9E%E8%80%81%E9%97%86-%E6%A1%B6%E4%BB%94%E9%9B%9E-%E8%90%AC%E9%9A%86%E5%BA%97"
    },
    {
      "id": "686",
      "name": "麥味登文山饗食大亨店(羅斯福饗食大亨)",
      "address": "臺北市文山區羅斯福路五段218巷25號一樓",
      "lng.": "121.5375974",
      "lat.": "25.0020335",
      "time": "06:00-20:00",
      "cuisine_type": "日式|台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f5e3f072261393d9cee0b08-%E9%BA%A5%E5%91%B3%E7%99%BB%E6%96%87%E5%B1%B1%E9%A5%97%E9%A3%9F%E5%A4%A7%E4%BA%A8%E5%BA%97(%E7%BE%85%E6%96%AF%E7%A6%8F%E9%A5%97%E9%A3%9F%E5%A4%A7%E4%BA%A8)"
    },
    {
      "id": "687",
      "name": "富察號",
      "address": "臺北市文山區忠順街一段26巷11弄2號",
      "lng.": "121.559622",
      "lat.": "24.982927",
      "time": "14:00-21:00",
      "cuisine_type": "飲料",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ed270102756dd5139e6a039-%E5%AF%8C%E5%AF%9F%E8%99%9F"
    },
    {
      "id": "688",
      "name": "龍哥食堂",
      "address": "臺北市文山區萬慶街17號",
      "lng.": "121.5397623",
      "lat.": "24.9923824",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "日本",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f534dc902935e289d74c9bd-%E9%BE%8D%E5%93%A5%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "689",
      "name": "雪敲 Ice Climber",
      "address": "臺北市文山區指南路三段38巷33之2號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "11:00-18:00",
      "cuisine_type": "飲料",
      "rating": "4.6",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f4f6674d6895d52294fa3d2-%E9%9B%AA%E6%95%B2-Ice-Climber"
    },
    {
      "id": "690",
      "name": "TDH 貓茶町 下午茶",
      "address": "臺北市文山區保儀路115號",
      "lng.": "121.5676709",
      "lat.": "24.985714",
      "time": "10:00-20:00",
      "cuisine_type": "飲料",
      "rating": "4.1",
      "inout": "內用|",
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a537cfc03a10241de652c4-TDH-%E8%B2%93%E8%8C%B6%E7%94%BA-%E4%B8%8B%E5%8D%88%E8%8C%B6"
    },
    {
      "id": "691",
      "name": "CAFE巷",
      "address": "臺北市文山區指南路三段38巷33之5號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "10:00-19:30",
      "cuisine_type": "咖啡",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5936ef1d2756dd5f7e556a8f-CAFE%E5%B7%B7"
    },
    {
      "id": "692",
      "name": "開源社雞排 木新店",
      "address": "臺北市文山區木新路三段269號",
      "lng.": "121.5581456",
      "lat.": "24.9809189",
      "time": "00:00-01:00, 15:00-00:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ea5bcb12261393a0e7c2932-%E9%96%8B%E6%BA%90%E7%A4%BE%E9%9B%9E%E6%8E%92-%E6%9C%A8%E6%96%B0%E5%BA%97"
    },
    {
      "id": "693",
      "name": "景美祖傳牛肉麵",
      "address": "臺北市文山區景文街133號",
      "lng.": "121.541162",
      "lat.": "24.990145",
      "time": "11:00-20:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5fead93402935e5673b7eb83-%E6%99%AF%E7%BE%8E%E7%A5%96%E5%82%B3%E7%89%9B%E8%82%89%E9%BA%B5"
    },
    {
      "id": "694",
      "name": "紅木屋休閒茶館",
      "address": "臺北市文山區指南路三段38巷33號",
      "lng.": "121.590704",
      "lat.": "24.9671039",
      "time": "10:30-21:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d77a4c03a103ee86c7c2b-%E7%B4%85%E6%9C%A8%E5%B1%8B%E4%BC%91%E9%96%92%E8%8C%B6%E9%A4%A8"
    },
    {
      "id": "695",
      "name": "食旅光廚房",
      "address": "臺北市文山區萬美街一段19巷5號後棟",
      "lng.": "121.5691763",
      "lat.": "25.0015902",
      "time": "00:00-06:00, 08:30-18:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f310f6dd6895d2d616528c8-%E9%A3%9F%E6%97%85%E5%85%89%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "696",
      "name": "黑牛穆場牛排館",
      "address": "臺北市文山區興隆路三段112巷2弄10號1",
      "lng.": "121.5569279",
      "lat.": "24.9992523",
      "time": "11:00-14:30, 17:00-21:00",
      "cuisine_type": "美式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5cebf2b62756dd3eeb8ff130-%E9%BB%91%E7%89%9B%E7%A9%86%E5%A0%B4%E7%89%9B%E6%8E%92%E9%A4%A8"
    },
    {
      "id": "697",
      "name": "辣椒多一點-麻辣鍋物",
      "address": "臺北市文山區興隆路二段245號",
      "lng.": "121.5514581",
      "lat.": "25.0019909",
      "time": "17:00-23:00",
      "cuisine_type": "中式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5dc2111d8c906d1860bd3fef-%E8%BE%A3%E6%A4%92%E5%A4%9A%E4%B8%80%E9%BB%9E-%E9%BA%BB%E8%BE%A3%E9%8D%8B%E7%89%A9"
    },
    {
      "id": "698",
      "name": "Portafiltro Coffee。撥啡",
      "address": "臺北市文山區興隆路三段290號",
      "lng.": "121.5596705",
      "lat.": "24.9956412",
      "time": "07:30-17:00",
      "cuisine_type": "咖啡",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f2380dd8c906d6cd91a5ce9-Portafiltro-Coffee%E3%80%82%E6%92%A5"
    },
    {
      "id": "699",
      "name": "棋盤角法式甜點",
      "address": "臺北市文山區興隆路三段192巷2弄3號1樓",
      "lng.": "121.558209",
      "lat.": "24.997929",
      "time": "13:00-19:00",
      "cuisine_type": "歐式|日式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f2183ad8c906d42d14f92da-%E6%A3%8B%E7%9B%A4%E8%A7%92%E6%B3%95%E5%BC%8F%E7%94%9C%E9%BB%9E"
    },
    {
      "id": "700",
      "name": "邀月茶坊",
      "address": "臺北市文山區指南路三段40巷6號",
      "lng.": "121.597309",
      "lat.": "24.96743",
      "time": "24小時營業",
      "cuisine_type": "飲料|台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/55a67c1ec03a104df53ca5ef-%E9%82%80%E6%9C%88%E8%8C%B6%E5%9D%8A"
    },
    {
      "id": "701",
      "name": "老娘米粉湯",
      "address": "臺北市文山區木柵路一段227號",
      "lng.": "121.5519778",
      "lat.": "24.9879111",
      "time": "17:00-00:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5e65ac03a102ec14155ed-%E8%80%81%E5%A8%98%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "702",
      "name": "聰明油飯",
      "address": "臺北市文山區景美街45號",
      "lng.": "121.5421518",
      "lat.": "24.9913326",
      "time": "15:30-23:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f0b36ed22613969e552ed04-%E8%81%B0%E6%98%8E%E6%B2%B9%E9%A3%AF"
    },
    {
      "id": "703",
      "name": "肉匠爺漢堡專賣店",
      "address": "臺北市文山區興隆路三段36巷15弄12號滷味旁",
      "lng.": "121.5555386",
      "lat.": "24.9995663",
      "time": "11:50-22:30",
      "cuisine_type": "美式",
      "rating": "4.6",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f09d3b52261393c665397e5-%E8%82%89%E5%8C%A0%E7%88%BA%E6%BC%A2%E5%A0%A1%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "704",
      "name": "獨特花生湯",
      "address": "臺北市文山區興隆路一段293號",
      "lng.": "121.544759",
      "lat.": "24.9988299",
      "time": "00:00-10:30, 21:00-00:00",
      "cuisine_type": "飲料",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a53025c03a10241de64fe3-%E7%8D%A8%E7%89%B9%E8%8A%B1%E7%94%9F%E6%B9%AF"
    },
    {
      "id": "705",
      "name": "CelloBakery 千樂手作",
      "address": "臺北市文山區木柵路一段269號",
      "lng.": "121.5534212",
      "lat.": "24.9881645",
      "time": "16:00-19:00",
      "cuisine_type": "飲料|日式|歐式|美式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/564cbe5f2756dd71d63f5cd6-CelloBakery-%E5%8D%83%E6%A8%82%E6%89%8B%E4%BD%9C"
    },
    {
      "id": "706",
      "name": "印尼小吃",
      "address": "臺北市文山區辛亥路五段25巷1號",
      "lng.": "121.5544497",
      "lat.": "24.9999092",
      "time": "08:00-19:00",
      "cuisine_type": "東南亞",
      "rating": "4.1",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a67f35c03a104df53ca6c9-%E5%8D%B0%E5%B0%BC%E5%B0%8F%E5%90%83"
    },
    {
      "id": "707",
      "name": "獨特牛排館",
      "address": "臺北市文山區景美街92號",
      "lng.": "121.5412896",
      "lat.": "24.9896134",
      "time": "12:00-13:30, 17:00-21:30",
      "cuisine_type": "美式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57112de32756dd37a7fda759-%E7%8D%A8%E7%89%B9%E7%89%9B%E6%8E%92%E9%A4%A8"
    },
    {
      "id": "708",
      "name": "景美豆花",
      "address": "臺北市文山區景美街",
      "lng.": "121.5416403",
      "lat.": "24.9916431",
      "time": "00:00-00:30, 16:00-00:00",
      "cuisine_type": "飲料",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a50a36c03a10241de642e4-%E6%99%AF%E7%BE%8E%E8%B1%86%E8%8A%B1"
    },
    {
      "id": "709",
      "name": "邱家碳烤鹽酥雞",
      "address": "臺北市文山區興隆路二段220巷18號",
      "lng.": "121.5522475",
      "lat.": "25.0006501",
      "time": "15:00-23:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f9a343002935e023a3d59e2-%E9%82%B1%E5%AE%B6%E7%A2%B3%E7%83%A4%E9%B9%BD%E9%85%A5%E9%9B%9E"
    },
    {
      "id": "710",
      "name": "112巷牛排",
      "address": "臺北市文山區興隆路三段112巷2弄26號",
      "lng.": "121.5564663",
      "lat.": "24.9995319",
      "time": "11:00-21:00",
      "cuisine_type": "美式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5baa123723679c6c9d9a8185-112%E5%B7%B7%E7%89%9B%E6%8E%92"
    },
    {
      "id": "711",
      "name": "咖啡這件小事Coffee Little Things",
      "address": "臺北市文山區試院路58號之5號",
      "lng.": "121.549349",
      "lat.": "24.989552",
      "time": "10:45-19:45",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5edf9b3d2756dd46d0f26489-%E5%92%96%E5%95%A1%E9%80%99%E4%BB%B6%E5%B0%8F%E4%BA%8BCoffee-Little-"
    },
    {
      "id": "712",
      "name": "三三活力早餐店",
      "address": "臺北市文山區木新路三段122號",
      "lng.": "121.5620886",
      "lat.": "24.9821411",
      "time": "06:30-12:30",
      "cuisine_type": "台式|日式",
      "rating": "4.2",
      "inout": ['內用','外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d7ea1c03a103ee86c8046-%E4%B8%89%E4%B8%89%E6%B4%BB%E5%8A%9B%E6%97%A9%E9%A4%90%E5%BA%97"
    },
    {
      "id": "713",
      "name": "Old Ginger Cafe & Vintage 老薑咖啡",
      "address": "臺北市文山區指南路三段6號",
      "lng.": "121.5798858",
      "lat.": "24.98519",
      "time": "13:00-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5eda0b932261393a633198b5-Old-Ginger-Cafe-%26-Vi"
    },
    {
      "id": "714",
      "name": "阿義師的大茶壺茶餐廳",
      "address": "臺北市文山區指南路三段38巷37之1號",
      "lng.": "121.5918065",
      "lat.": "24.9686888",
      "time": "10:00-22:00",
      "cuisine_type": "港式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a53a8dc03a10241de653c1-%E9%98%BF%E7%BE%A9%E5%B8%AB%E7%9A%84%E5%A4%A7%E8%8C%B6%E5%A3%BA%E8%8C%B6%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "715",
      "name": "A Mini Bistro。小館",
      "address": "臺北市文山區辛亥路四段101巷13弄2號",
      "lng.": "121.560122",
      "lat.": "25.006532",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "義式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57efc820699b6e36353e9477-A-Mini-Bistro%E3%80%82%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "716",
      "name": "佳香點心大王",
      "address": "臺北市文山區羅斯福路六段142巷255號",
      "lng.": "121.5410762",
      "lat.": "24.9959645",
      "time": "04:00-11:15",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b2d3b5f2756dd6d1c978ed9-%E4%BD%B3%E9%A6%99%E9%BB%9E%E5%BF%83%E5%A4%A7%E7%8E%8B"
    },
    {
      "id": "717",
      "name": "景美無名米粉湯",
      "address": "臺北市文山區興隆路二段130巷2號",
      "lng.": "121.5503945",
      "lat.": "25.0003444",
      "time": "06:30-13:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ebab1202756dd5ff25cbca2-%E6%99%AF%E7%BE%8E%E7%84%A1%E5%90%8D%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "718",
      "name": "徐老爹涼麵專賣",
      "address": "臺北市文山區景文街69號",
      "lng.": "121.5415163",
      "lat.": "24.9914521",
      "time": "暫時無資訊",
      "cuisine_type": "台式|日式",
      "rating": "4.6",
      "inout": ['內用','外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe9abe802935e2d1f75b374-%E5%BE%90%E8%80%81%E7%88%B9%E6%B6%BC%E9%BA%B5%E5%B0%88%E8%B3%A3"
    },
    {
      "id": "719",
      "name": "張媽媽香大雞排",
      "address": "臺北市文山區景後街83號",
      "lng.": "121.5431171",
      "lat.": "24.9922915",
      "time": "15:00-21:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5eb80ded2756dd7fef6a3680-%E5%BC%B5%E5%AA%BD%E5%AA%BD%E9%A6%99%E5%A4%A7%E9%9B%9E%E6%8E%92"
    },
    {
      "id": "720",
      "name": "雪球咖啡 景美店",
      "address": "臺北市文山區景文街13之2號",
      "lng.": "121.5415407",
      "lat.": "24.9933776",
      "time": "07:00-14:00",
      "cuisine_type": "咖啡",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ec1486a2756dd19cbdacf4f-%E9%9B%AA%E7%90%83%E5%92%96%E5%95%A1-%E6%99%AF%E7%BE%8E%E5%BA%97"
    },
    {
      "id": "721",
      "name": "啾啾哥",
      "address": "臺北市文山區樟新街11號1樓",
      "lng.": "121.5553486",
      "lat.": "24.9793562",
      "time": "06:30-13:30",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/579f91502756dd715c15efd8-%E5%95%BE%E5%95%BE%E5%93%A5"
    },
    {
      "id": "722",
      "name": "巧味豬腳12 號",
      "address": "臺北市文山區木新路三段310巷4號",
      "lng.": "121.5569807",
      "lat.": "24.9817726",
      "time": "07:00-13:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e9f017b2756dd7d216b2871-%E5%B7%A7%E5%91%B3%E8%B1%AC%E8%85%B312-%E8%99%9F"
    },
    {
      "id": "723",
      "name": "MEOW House喵好時早餐號",
      "address": "臺北市文山區木新路三段74巷8弄15號",
      "lng.": "121.5639371",
      "lat.": "24.983109",
      "time": "07:00-13:00",
      "cuisine_type": "台式|日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57dd44be23679c13db46dc0c-MEOW-House%E5%96%B5%E5%A5%BD%E6%99%82%E6%97%A9%E9%A4%90%E8%99%9F"
    },
    {
      "id": "724",
      "name": "潮飯",
      "address": "臺北市文山區木柵路三段115號",
      "lng.": "121.568236",
      "lat.": "24.988949",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ae0c38e2756dd33f62951ae-%E6%BD%AE%E9%A3%AF"
    },
    {
      "id": "725",
      "name": "陽城燒臘店",
      "address": "臺北市文山區木新路二段244號",
      "lng.": "121.5665447",
      "lat.": "24.9833628",
      "time": "11:00-14:30, 16:30-20:00",
      "cuisine_type": "港式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d8358c03a103ee86c8259-%E9%99%BD%E5%9F%8E%E7%87%92%E8%87%98%E5%BA%97"
    },
    {
      "id": "726",
      "name": "米澤製麵(臺北萬芳店)-讚岐烏龍麵",
      "address": "臺北市文山區興隆路三段117號",
      "lng.": "121.558128",
      "lat.": "24.9990486",
      "time": "11:30-21:00",
      "cuisine_type": "日本",
      "rating": "3.7",
      "inout": ['內用','外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e35a2c88c906d5a5911ac6b-%E7%B1%B3%E6%BE%A4%E8%A3%BD%E9%BA%B5(%E5%8F%B0%E5%8C%97%E8%90%AC%E8%8A%B3%E5%BA%97)-%E8%AE%9A%E5%B2%90%E7%83%8F%E9%BE%8D%E9%BA%B5"
    },
    {
      "id": "727",
      "name": "米粒活力早餐",
      "address": "臺北市文山區興隆路三段112巷2弄7號",
      "lng.": "121.5568683",
      "lat.": "24.9989758",
      "time": "06:30-13:30",
      "cuisine_type": "台式|日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57643c922756dd1d439e4a3b-%E7%B1%B3%E7%B2%92%E6%B4%BB%E5%8A%9B%E6%97%A9%E9%A4%90"
    },
    {
      "id": "728",
      "name": "黑貓工作室Cafe Chat Noir",
      "address": "臺北市文山區景華街52巷2號",
      "lng.": "121.5437286",
      "lat.": "24.9946103",
      "time": "13:30-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b65eb7d2756dd2dc3e2af8f-%E9%BB%91%E8%B2%93%E5%B7%A5%E4%BD%9C%E5%AE%A4Cafe-Chat-Noir"
    },
    {
      "id": "729",
      "name": "CorkyBear呆呆熊早午餐",
      "address": "臺北市文山區木新路三段74巷1弄20號1F",
      "lng.": "121.562712",
      "lat.": "24.9826599",
      "time": "07:00-15:00",
      "cuisine_type": "日式|歐式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e70dd142756dd355d213ca2-CorkyBear%E5%91%86%E5%91%86%E7%86%8A%E6%97%A9%E5%8D%88%E9%A4%90"
    },
    {
      "id": "730",
      "name": "師大分部臭豆腐",
      "address": "臺北市文山區Unnamed Road",
      "lng.": "121.5810358",
      "lat.": "24.9983469",
      "time": "22:30-23:59",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e80aeef2756dd6032d6855e-%E5%B8%AB%E5%A4%A7%E5%88%86%E9%83%A8%E8%87%AD%E8%B1%86%E8%85%90"
    },
    {
      "id": "731",
      "name": "A.B.D. Coffee&Life",
      "address": "臺北市文山區羅斯福路五段269巷32號",
      "lng.": "121.5409281",
      "lat.": "25.0013471",
      "time": "暫時無資訊",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b9e8f5ff5246841da609a02-A.B.D.-Coffee%26Life"
    },
    {
      "id": "732",
      "name": "景美上海生煎包",
      "address": "臺北市文山區景文街55號",
      "lng.": "121.5413998",
      "lat.": "24.9917036",
      "time": "07:30-11:30, 15:30-23:30",
      "cuisine_type": "中式",
      "rating": "3.6",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559de3dcc03a103ee86cbb9f-%E6%99%AF%E7%BE%8E%E4%B8%8A%E6%B5%B7%E7%94%9F%E7%85%8E%E5%8C%85"
    },
    {
      "id": "733",
      "name": "韓月半飯",
      "address": "臺北市文山區興隆路二段323號",
      "lng.": "121.55392",
      "lat.": "25.001229",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "韓式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59a30a952756dd5445be4d72-%E9%9F%93%E6%9C%88%E5%8D%8A%E9%A3%AF"
    },
    {
      "id": "734",
      "name": "Trattoria al Sole 豔陽下義大利小餐館",
      "address": "臺北市文山區新光路一段44號",
      "lng.": "121.573614",
      "lat.": "24.9897689",
      "time": "11:30-14:00, 17:30-21:30",
      "cuisine_type": "義式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5ceb95b8226139300d743c2c-Trattoria-al-Sole-%E8%B1%94%E9%99%BD"
    },
    {
      "id": "735",
      "name": "Purrson 呼嚕小酒館",
      "address": "臺北市文山區指南路二段106號",
      "lng.": "121.5794662",
      "lat.": "24.986129",
      "time": "11:30-22:30",
      "cuisine_type": "餐酒館/酒吧",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e67a2782756dd355917d3a9-Purrson-%E5%91%BC%E5%9A%95%E5%B0%8F%E9%85%92%E9%A4%A8"
    },
    {
      "id": "736",
      "name": "真好味烤鴨莊",
      "address": "臺北市文山區木新路三段108號",
      "lng.": "121.5626941",
      "lat.": "24.9822903",
      "time": "10:30-20:00",
      "cuisine_type": "中式",
      "rating": "4.5",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4f4f7c03a10241de63b80-%E7%9C%9F%E5%A5%BD%E5%91%B3%E7%83%A4%E9%B4%A8%E8%8E%8A"
    },
    {
      "id": "737",
      "name": "土角厝懷舊小吃店",
      "address": "臺北市文山區三福街2之1號",
      "lng.": "121.5417588",
      "lat.": "24.9960498",
      "time": "00:00-00:30, 17:00-00:00",
      "cuisine_type": "中式|台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d580d3d2756dd2f11198396-%E5%9C%9F%E8%A7%92%E5%8E%9D%E6%87%B7%E8%88%8A%E5%B0%8F%E5%90%83%E5%BA%97"
    },
    {
      "id": "738",
      "name": "松町和風小舖",
      "address": "臺北市文山區木新路二段60號",
      "lng.": "121.570516",
      "lat.": "24.986033",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "日本",
      "rating": "4",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559ddebfc03a103ee86cb789-%E6%9D%BE%E7%94%BA%E5%92%8C%E9%A2%A8%E5%B0%8F%E8%88%96"
    },
    {
      "id": "739",
      "name": "你後面咖啡廳",
      "address": "臺北市文山區木柵路三段48巷1弄2號1樓",
      "lng.": "121.5653413",
      "lat.": "24.9879705",
      "time": "11:00-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a219a9f2756dd68a7f09391-%E4%BD%A0%E5%BE%8C%E9%9D%A2%E5%92%96%E5%95%A1%E5%BB%B3"
    },
    {
      "id": "740",
      "name": "廟口臭豆腐",
      "address": "臺北市文山區景美街45號",
      "lng.": "121.5421518",
      "lat.": "24.9913326",
      "time": "15:00-21:30",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['內用','外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe9abf802935e2d1f75b37d-%E5%BB%9F%E5%8F%A3%E8%87%AD%E8%B1%86%E8%85%90"
    },
    {
      "id": "741",
      "name": "濟鴻火鍋",
      "address": "臺北市文山區景興路202巷10號",
      "lng.": "121.543261",
      "lat.": "24.992032",
      "time": "11:30-23:00",
      "cuisine_type": "台式|日式",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/590cbf0f2756dd17cd7fa7eb-%E6%BF%9F%E9%B4%BB%E7%81%AB%E9%8D%8B"
    },
    {
      "id": "742",
      "name": "秘徑咖啡Alley's cafe",
      "address": "臺北市文山區羅斯福路五段218巷9弄3號",
      "lng.": "121.5384752",
      "lat.": "25.0016877",
      "time": "11:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5e4e95f02756dd63a431e2c5-%E7%A7%98%E5%BE%91%E5%92%96%E5%95%A1Alley's-cafe"
    },
    {
      "id": "743",
      "name": "古早味蛋餅飯糰",
      "address": "臺北市文山區萬壽路14號",
      "lng.": "121.5762952",
      "lat.": "24.9881403",
      "time": "06:00-11:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5f506c03a102ec1415a7c-%E5%8F%A4%E6%97%A9%E5%91%B3%E8%9B%8B%E9%A4%85%E9%A3%AF%E7%B3%B0"
    },
    {
      "id": "744",
      "name": "石二鍋 / 臺北興隆店",
      "address": "臺北市文山區興隆路四段149號",
      "lng.": "121.5617507",
      "lat.": "24.9848357",
      "time": "11:30-22:30",
      "cuisine_type": "中式|日式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57546aad2756dd0896fa0a22-%E7%9F%B3%E4%BA%8C%E9%8D%8B-%2F-%E5%8F%B0%E5%8C%97%E8%88%88%E9%9A%86%E5%BA%97"
    },
    {
      "id": "745",
      "name": "寶島麵線站木新店",
      "address": "臺北市文山區木新路三段296號",
      "lng.": "121.5575691",
      "lat.": "24.9809509",
      "time": "11:00-19:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5e80bf8ad6895d702f7cc5c3-%E5%AF%B6%E5%B3%B6%E9%BA%B5%E7%B7%9A%E7%AB%99%E6%9C%A8%E6%96%B0%E5%BA%97"
    },
    {
      "id": "746",
      "name": "蕃薯の店生猛活海鮮",
      "address": "臺北市文山區景文街181號舊橋旁",
      "lng.": "121.5409208",
      "lat.": "24.9887762",
      "time": "11:00-14:00, 17:00-23:00",
      "cuisine_type": "台式|中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5e32e69f2756dd184aac478e-%E8%95%83%E8%96%AF%E3%81%AE%E5%BA%97%E7%94%9F%E7%8C%9B%E6%B4%BB%E6%B5%B7%E9%AE%AE"
    },
    {
      "id": "747",
      "name": "三老村",
      "address": "臺北市文山區木柵路三段5號",
      "lng.": "121.564694",
      "lat.": "24.988576",
      "time": "11:30-21:00",
      "cuisine_type": "韓式|中式|台式",
      "rating": "3.8",
      "inout": ['內用','外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a67f9fc03a104df53ca6e5-%E4%B8%89%E8%80%81%E6%9D%91"
    },
    {
      "id": "748",
      "name": "真的咖啡 ZHEN DE Cafe",
      "address": "臺北市文山區萬隆街19巷1號",
      "lng.": "121.5383447",
      "lat.": "25.0001025",
      "time": "09:00-22:00",
      "cuisine_type": "咖啡",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/597b7e352756dd22a9bd2957-%E7%9C%9F%E7%9A%84%E5%92%96%E5%95%A1-ZHEN-DE-Cafe"
    },
    {
      "id": "749",
      "name": "遇見",
      "address": "臺北市文山區羅斯福路六段18號",
      "lng.": "121.539451",
      "lat.": "25.000084",
      "time": "12:00-23:00",
      "cuisine_type": "飲料",
      "rating": "4.3",
      "inout": ['內用','外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5967b7742756dd3b1c41aa6f-%E9%81%87%E8%A6%8B"
    },
    {
      "id": "750",
      "name": "火鍋哥涮涮屋",
      "address": "臺北市文山區羅斯福路五段218巷1號",
      "lng.": "121.538518",
      "lat.": "25.0020686",
      "time": "11:00-15:00, 17:00-22:00",
      "cuisine_type": "日式|台式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58557edc2756dd7579b8ee5a-%E7%81%AB%E9%8D%8B%E5%93%A5%E6%B6%AE%E6%B6%AE%E5%B1%8B"
    },
    {
      "id": "751",
      "name": "TAIGA 針葉林",
      "address": "臺北市文山區木柵路三段125之1號",
      "lng.": "121.5684242",
      "lat.": "24.9889765",
      "time": "09:00-17:00",
      "cuisine_type": "歐式|日式|美式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bd08bcbf524683fcb6a3aa0-TAIGA-%E9%87%9D%E8%91%89%E6%9E%97"
    },
    {
      "id": "752",
      "name": "壽喜燒一丁 景美店",
      "address": "臺北市文山區景興路188號B2",
      "lng.": "121.543815",
      "lat.": "24.9923",
      "time": "11:00-21:30",
      "cuisine_type": "日式",
      "rating": "3.9",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d6791c03a103ee86c7167-%E5%A3%BD%E5%96%9C%E7%87%92%E4%B8%80%E4%B8%81-%E6%99%AF%E7%BE%8E%E5%BA%97"
    },
    {
      "id": "753",
      "name": "小黑菓長崎蛋糕",
      "address": "臺北市文山區景美街5巷1號",
      "lng.": "121.541765",
      "lat.": "24.9934439",
      "time": "11:00-17:30",
      "cuisine_type": "美式|日式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b894ffa2756dd37ce912e8e-%E5%B0%8F%E9%BB%91%E8%8F%93%E9%95%B7%E5%B4%8E%E8%9B%8B%E7%B3%95"
    },
    {
      "id": "754",
      "name": "龍門客棧",
      "address": "臺北市文山區指南路三段38巷22之2號",
      "lng.": "121.5868023",
      "lat.": "24.9671038",
      "time": "00:00-01:00, 11:00-00:00",
      "cuisine_type": "中式|台式",
      "rating": "3.9",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d1e40c03a103ee86c4109-%E9%BE%8D%E9%96%80%E5%AE%A2%E6%A3%A7"
    },
    {
      "id": "755",
      "name": "tnt美式碳烤牛排",
      "address": "臺北市文山區景興路168號",
      "lng.": "121.5441712",
      "lat.": "24.9930756",
      "time": "11:30-14:30, 17:30-22:00",
      "cuisine_type": "美式",
      "rating": "4.4",
      "inout": ['內用','外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58ac820a2756dd1e62effd50-tnt%E7%BE%8E%E5%BC%8F%E7%A2%B3%E7%83%A4%E7%89%9B%E6%8E%92"
    },
    {
      "id": "756",
      "name": "滷獲人心養生加熱滷味",
      "address": "臺北市文山區景美街2號",
      "lng.": "121.5415861",
      "lat.": "24.9942973",
      "time": "17:00-00:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5af5992723679c52659b1f9b-%E6%BB%B7%E7%8D%B2%E4%BA%BA%E5%BF%83%E9%A4%8A%E7%94%9F%E5%8A%A0%E7%86%B1%E6%BB%B7%E5%91%B3"
    },
    {
      "id": "757",
      "name": "辣椒先生-川味麻辣燙",
      "address": "臺北市文山區景華街78號",
      "lng.": "121.5452105",
      "lat.": "24.9950493",
      "time": "12:00-14:00, 16:00-00:00",
      "cuisine_type": "中式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c41402123679c26d55cec8c-%E8%BE%A3%E6%A4%92%E5%85%88%E7%94%9F-%E5%B7%9D%E5%91%B3%E9%BA%BB%E8%BE%A3%E7%87%99"
    },
    {
      "id": "758",
      "name": "賴桑香腸",
      "address": "臺北市文山區木柵路五段18號",
      "lng.": "121.581806",
      "lat.": "25.0024419",
      "time": "17:00-20:30",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559da69ac03a103ee86c9516-%E8%B3%B4%E6%A1%91%E9%A6%99%E8%85%B8"
    },
    {
      "id": "759",
      "name": "焱鬼鍋燒專門店",
      "address": "臺北市文山區木新路二段252號",
      "lng.": "121.5662939",
      "lat.": "24.983258",
      "time": "11:00-14:00, 16:30-20:30",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用','外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5602ebd82756dd161930ba2f-%E7%84%B1%E9%AC%BC%E9%8D%8B%E7%87%92%E5%B0%88%E9%96%80%E5%BA%97"
    },
    {
      "id": "760",
      "name": "木柵水煎包",
      "address": "臺北市文山區指南路一段25號",
      "lng.": "121.5693555",
      "lat.": "24.9877215",
      "time": "06:20-12:00",
      "cuisine_type": "中式",
      "rating": "4.4",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56aa58402756dd600d5e5920-%E6%9C%A8%E6%9F%B5%E6%B0%B4%E7%85%8E%E5%8C%85"
    },
    {
      "id": "761",
      "name": "有雞可乘(炸物專賣店)",
      "address": "臺北市文山區木新路三段289號",
      "lng.": "121.5575112",
      "lat.": "24.9807562",
      "time": "15:30-00:00",
      "cuisine_type": "日式|台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5dc5103cd6895d2fd9e09b32-%E6%9C%89%E9%9B%9E%E5%8F%AF%E4%B9%98(%E7%82%B8%E7%89%A9%E5%B0%88%E8%B3%A3%E5%BA%97)"
    },
    {
      "id": "762",
      "name": "等一個人咖啡(景美本店)",
      "address": "臺北市文山區一壽街44巷1號",
      "lng.": "121.5566568",
      "lat.": "24.9793218",
      "time": "11:00-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d3b00c03a103ee86c540d-%E7%AD%89%E4%B8%80%E5%80%8B%E4%BA%BA%E5%92%96%E5%95%A1(%E6%99%AF%E7%BE%8E%E6%9C%AC%E5%BA%97)"
    },
    {
      "id": "763",
      "name": "老元香雞湯專賣",
      "address": "臺北市文山區木柵路一段278號",
      "lng.": "121.5548445",
      "lat.": "24.9879753",
      "time": "暫時無資訊",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5dbd90c52756dd48e20a77fc-%E8%80%81%E5%85%83%E9%A6%99%E9%9B%9E%E6%B9%AF%E5%B0%88%E8%B3%A3"
    },
    {
      "id": "764",
      "name": "阿郎鹹酥雞",
      "address": "臺北市文山區興隆路三段36巷15弄12號",
      "lng.": "121.5555386",
      "lat.": "24.9995663",
      "cuisine_type": "台式",
      "rating": "2.5",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59c15d8b2756dd528db72d1d-%E9%98%BF%E9%83%8E%E9%B9%B9%E9%85%A5%E9%9B%9E"
    },
    {
      "id": "765",
      "name": "御神四季食藝料理",
      "address": "臺北市文山區木柵路三段48巷1弄9號",
      "lng.": "121.5648665",
      "lat.": "24.9878",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5d6147cf2756dd2f151a5d30-%E5%BE%A1%E7%A5%9E%E5%9B%9B%E5%AD%A3%E9%A3%9F%E8%97%9D%E6%96%99%E7%90%86"
    },
    {
      "id": "766",
      "name": "德國農夫廚房",
      "address": "臺北市文山區興隆路2段220巷35號1樓",
      "lng.": "121.552251",
      "lat.": "25.0003473",
      "time": "13:30-22:00",
      "cuisine_type": "德式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/55a53ae9c03a10241de653e2-%E5%BE%B7%E5%9C%8B%E8%BE%B2%E5%A4%AB%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "767",
      "name": "老爹鵝肉專賣店",
      "address": "臺北市文山區木新路三段9號",
      "lng.": "121.5649913",
      "lat.": "24.9825664",
      "time": "11:30-20:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a6830cc03a104df53ca7bb-%E8%80%81%E7%88%B9%E9%B5%9D%E8%82%89%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "768",
      "name": "阿二麻辣食堂-景美堂",
      "address": "臺北市文山區景文街71號",
      "lng.": "121.5415005",
      "lat.": "24.9914587",
      "time": "11:30-23:00",
      "cuisine_type": "中式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a7ab2f62756dd7bff171e80-%E9%98%BF%E4%BA%8C%E9%BA%BB%E8%BE%A3%E9%A3%9F%E5%A0%82-%E6%99%AF%E7%BE%8E%E5%A0%82"
    },
    {
      "id": "769",
      "name": "ConfitRémi",
      "address": "臺北市文山區羅斯福路五段269巷16號",
      "lng.": "121.5399713",
      "lat.": "25.001109",
      "time": "12:00-14:00, 17:30-22:00",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b9e8e59f5246841b6311f22-ConfitR%C3%A9mi"
    },
    {
      "id": "770",
      "name": "8鍋臭臭鍋",
      "address": "臺北市文山區興隆路三段36巷9弄5號",
      "lng.": "121.5556795",
      "lat.": "24.9998304",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d94310a8c906d0342c04084-8%E9%8D%8B%E8%87%AD%E8%87%AD%E9%8D%8B"
    },
    {
      "id": "771",
      "name": "麵疙瘩‧烤肉飯",
      "address": "臺北市文山區木柵路三段102巷3號",
      "lng.": "121.567616",
      "lat.": "24.9883949",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "台式|韓式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56bf705c2756dd1775878153-%E9%BA%B5%E7%96%99%E7%98%A9%E2%80%A7%E7%83%A4%E8%82%89%E9%A3%AF"
    },
    {
      "id": "772",
      "name": "小旺仔宜蘭蛋餅",
      "address": "臺北市文山區景美街83號",
      "lng.": "121.5417941",
      "lat.": "24.9905549",
      "time": "16:30-22:00",
      "cuisine_type": "台式",
      "rating": "4.6",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c3b49a62756dd69e67f411d-%E5%B0%8F%E6%97%BA%E4%BB%94%E5%AE%9C%E8%98%AD%E8%9B%8B%E9%A4%85"
    },
    {
      "id": "773",
      "name": "兄弟麵館",
      "address": "臺北市文山區興隆路三段36巷16弄2號",
      "lng.": "121.5550125",
      "lat.": "24.9996762",
      "time": "11:30-14:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/581636082756dd4cef4eaae4-%E5%85%84%E5%BC%9F%E9%BA%B5%E9%A4%A8"
    },
    {
      "id": "774",
      "name": "小尚品精制鍋物",
      "address": "臺北市文山區木柵路一段325之3號",
      "lng.": "121.556227",
      "lat.": "24.9885628",
      "time": "11:00-22:00",
      "cuisine_type": "義式|中式|韓式",
      "rating": "4.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bd8288e2261394a8bd7dd2a-%E5%B0%8F%E5%B0%9A%E5%93%81%E7%B2%BE%E5%88%B6%E9%8D%8B%E7%89%A9"
    },
    {
      "id": "775",
      "name": "松包子Os桑的包子(景美分店)",
      "address": "臺北市文山區興隆路三段35號",
      "lng.": "121.5556348",
      "lat.": "25.0005708",
      "time": "12:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d6356248c906d155e98cbd8-%E6%9D%BE%E5%8C%85%E5%AD%90Os%E6%A1%91%E7%9A%84%E5%8C%85%E5%AD%90(%E6%99%AF%E7%BE%8E%E5%88%86%E5%BA%97)"
    },
    {
      "id": "776",
      "name": "小公寓",
      "address": "臺北市文山區指南路二段56號2樓號",
      "lng.": "121.5754459",
      "lat.": "24.9876087",
      "time": "11:00-21:00",
      "cuisine_type": "咖啡|日式|美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c1d035ef524687c09e2db3e-%E5%B0%8F%E5%85%AC%E5%AF%93"
    },
    {
      "id": "777",
      "name": "轉角冰",
      "address": "臺北市文山區景興路42巷8弄1號1樓",
      "lng.": "121.5426777",
      "lat.": "24.9971513",
      "time": "12:00-21:00",
      "cuisine_type": "飲料",
      "rating": "4.6",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5af9d1432756dd5e0a5dc7a8-%E8%BD%89%E8%A7%92%E5%86%B0"
    },
    {
      "id": "778",
      "name": "瀚星百貨 edoraPARK",
      "address": "臺北市文山區景興路188號",
      "lng.": "121.543815",
      "lat.": "24.9923",
      "time": "11:00-21:30",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d6299722756dd2f1027cec8-%E7%80%9A%E6%98%9F%E7%99%BE%E8%B2%A8-edoraPARK"
    },
    {
      "id": "779",
      "name": "誠鵝肉專賣",
      "address": "臺北市文山區木柵路二段191號",
      "lng.": "121.5637789",
      "lat.": "24.988915",
      "time": "11:00-20:00",
      "cuisine_type": "台式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d3a33c03a103ee86c53a9-%E8%AA%A0%E9%B5%9D%E8%82%89%E5%B0%88%E8%B3%A3"
    },
    {
      "id": "780",
      "name": "波波恰恰大馬風味餐",
      "address": "臺北市文山區指南路二段48號",
      "lng.": "121.5752569",
      "lat.": "24.9877122",
      "time": "11:00-20:00",
      "cuisine_type": "東南亞",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a6824dc03a104df53ca78e-%E6%B3%A2%E6%B3%A2%E6%81%B0%E6%81%B0%E5%A4%A7%E9%A6%AC%E9%A2%A8%E5%91%B3%E9%A4%90"
    },
    {
      "id": "781",
      "name": "鬼頭鍋物食堂",
      "address": "臺北市文山區木新路二段258號",
      "lng.": "121.5661529",
      "lat.": "24.9832119",
      "time": "11:30-21:00",
      "cuisine_type": "日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b15804e2756dd3d0f88958a-%E9%AC%BC%E9%A0%AD%E9%8D%8B%E7%89%A9%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "782",
      "name": "Boulangerie Shan Wei 山崴 - 未來廚房",
      "address": "臺北市文山區木柵路一段270號",
      "lng.": "121.554661",
      "lat.": "24.987968",
      "time": "10:00-21:30",
      "cuisine_type": "義式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59fe01052756dd6f07e9b4c4-Boulangerie-Shan-Wei"
    },
    {
      "id": "783",
      "name": "Mars Coffee",
      "address": "臺北市文山區辛亥路四段235號",
      "lng.": "121.5550973",
      "lat.": "25.0013548",
      "time": "09:00-18:00",
      "cuisine_type": "咖啡",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d4a6efa22613915657dca81-Mars-Coffee"
    },
    {
      "id": "784",
      "name": "偵軒廚房",
      "address": "臺北市文山區羅斯福路六段28號",
      "lng.": "121.539595",
      "lat.": "24.9997899",
      "time": "11:30-23:00",
      "cuisine_type": "日式|台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d4131c03a103ee86c583f-%E5%81%B5%E8%BB%92%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "785",
      "name": "景美鄭家碳烤",
      "address": "臺北市文山區景文街51號",
      "lng.": "121.5414055",
      "lat.": "24.9917198",
      "time": "18:15-00:00",
      "cuisine_type": "日式|台式",
      "rating": "3.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4aae4c03a1002ad8ad583-%E6%99%AF%E7%BE%8E%E9%84%AD%E5%AE%B6%E7%A2%B3%E7%83%A4"
    },
    {
      "id": "786",
      "name": "越南順化米線",
      "address": "臺北市文山區興隆路四段145巷20號1樓",
      "lng.": "121.5626113",
      "lat.": "24.9850226",
      "time": "11:00-20:00",
      "cuisine_type": "東南亞",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d76ee9f2261395501e09cbe-%E8%B6%8A%E5%8D%97%E9%A0%86%E5%8C%96%E7%B1%B3%E7%B7%9A"
    },
    {
      "id": "787",
      "name": "BÁNH MÌ 越式法國麵包",
      "address": "臺北市文山區興隆路四段134之1號",
      "lng.": "121.562278",
      "lat.": "24.9823584",
      "time": "07:00-14:00",
      "cuisine_type": "東南亞",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5dce1a9a226139571a9e49f3-B%C3%81NH-M%C3%8C-%E8%B6%8A%E5%BC%8F%E6%B3%95%E5%9C%8B%E9%BA%B5%E5%8C%85"
    },
    {
      "id": "788",
      "name": "ÎLE 島嶼法式海鮮",
      "address": "臺北市文山區一壽街16號",
      "lng.": "121.5564306",
      "lat.": "24.9799939",
      "time": "11:30-14:00, 18:00-22:00",
      "cuisine_type": "法式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5d23515e2756dd7622eedeba-%C3%8ELE-%E5%B3%B6%E5%B6%BC%E6%B3%95%E5%BC%8F%E6%B5%B7%E9%AE%AE"
    },
    {
      "id": "789",
      "name": "晨食早餐",
      "address": "臺北市文山區羅斯福路五段192巷8號",
      "lng.": "121.5375969",
      "lat.": "25.0036113",
      "time": "06:00-13:30",
      "cuisine_type": "台式|美式|日式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a60c99c03a102ec14161cf-%E6%99%A8%E9%A3%9F%E6%97%A9%E9%A4%90"
    },
    {
      "id": "790",
      "name": "尋常生活小坊",
      "address": "臺北市文山區公館街54號",
      "lng.": "121.537401",
      "lat.": "25.00572",
      "time": "10:00-18:00",
      "cuisine_type": "咖啡",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57cb10842756dd6aad99bd1b-%E5%B0%8B%E5%B8%B8%E7%94%9F%E6%B4%BB%E5%B0%8F%E5%9D%8A"
    },
    {
      "id": "791",
      "name": "怡客咖啡 文山店",
      "address": "臺北市文山區興隆路三段222號",
      "lng.": "121.559673",
      "lat.": "24.9970166",
      "time": "07:00-20:00",
      "cuisine_type": "咖啡",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5d08f3932756dd2c77f1703e-%E6%80%A1%E5%AE%A2%E5%92%96%E5%95%A1-%E6%96%87%E5%B1%B1%E5%BA%97"
    },
    {
      "id": "792",
      "name": "嘎逼。ㄉㄟˊ",
      "address": "臺北市文山區試院路58號",
      "lng.": "121.549335",
      "lat.": "24.989577",
      "time": "00:00-02:00, 09:00-00:00",
      "cuisine_type": "咖啡",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5ce54fa2f524683e6c830dac-%E5%98%8E%E9%80%BC%E3%80%82%E3%84%89%E3%84%9F%CB%8A"
    },
    {
      "id": "793",
      "name": "義興樓",
      "address": "臺北市文山區景文街121號",
      "lng.": "121.541221",
      "lat.": "24.9904119",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/55a66a47c03a104df53ca0f4-%E7%BE%A9%E8%88%88%E6%A8%93"
    },
    {
      "id": "794",
      "name": "63brunch",
      "address": "臺北市文山區景興路63號",
      "lng.": "121.5448585",
      "lat.": "24.9964527",
      "time": "11:00-19:00",
      "cuisine_type": "美式|義式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/5cc4124e22613939a1e02a1c-63brunch"
    },
    {
      "id": "795",
      "name": "珍味海南雞飯",
      "address": "臺北市文山區景後街149巷5號",
      "lng.": "121.5423156",
      "lat.": "24.9901935",
      "time": "11:00-21:30",
      "cuisine_type": "東南亞",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a51112f2756dd4707619359-%E7%8F%8D%E5%91%B3%E6%B5%B7%E5%8D%97%E9%9B%9E%E9%A3%AF"
    },
    {
      "id": "796",
      "name": "三角冰",
      "address": "臺北市文山區羅斯福路五段170巷10號",
      "lng.": "121.5380329",
      "lat.": "25.004741",
      "time": "12:00-21:30",
      "cuisine_type": "飲料",
      "rating": "4.4",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/576ad37f2756dd134634d15f-%E4%B8%89%E8%A7%92%E5%86%B0"
    },
    {
      "id": "797",
      "name": "貓空小木屋茶坊",
      "address": "臺北市文山區指南路三段38巷28號",
      "lng.": "121.5866545",
      "lat.": "24.9668591",
      "time": "10:00-22:00",
      "cuisine_type": "飲料|台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a683d3c03a104df53ca7f4-%E8%B2%93%E7%A9%BA%E5%B0%8F%E6%9C%A8%E5%B1%8B%E8%8C%B6%E5%9D%8A"
    },
    {
      "id": "798",
      "name": "怡源麵粥之屋",
      "address": "臺北市文山區忠順街一段34號",
      "lng.": "121.5595484",
      "lat.": "24.9840663",
      "time": "10:30-21:30",
      "cuisine_type": "台式|中式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58f700cbf5246815d0a75ef9-%E6%80%A1%E6%BA%90%E9%BA%B5%E7%B2%A5%E4%B9%8B%E5%B1%8B"
    },
    {
      "id": "799",
      "name": "風箏人咖啡",
      "address": "臺北市文山區景豐街48巷1號",
      "lng.": "121.5461509",
      "lat.": "25.0002076",
      "time": "07:30-18:00",
      "cuisine_type": "咖啡",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a6b6e6a2756dd652a8e0c70-%E9%A2%A8%E7%AE%8F%E4%BA%BA%E5%92%96%E5%95%A1"
    },
    {
      "id": "800",
      "name": "MINT PASTA (世新店)",
      "address": "臺北市文山區景興路274之2號",
      "lng.": "121.5424561",
      "lat.": "24.9897431",
      "time": "11:00-21:00",
      "cuisine_type": "義式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d33a6c03a103ee86c4f8f-MINT-PASTA-(%E4%B8%96%E6%96%B0%E5%BA%97)"
    },
    {
      "id": "801",
      "name": "楊家手工水餃",
      "address": "臺北市文山區景後街178號",
      "lng.": "121.5420583",
      "lat.": "24.9904912",
      "time": "17:00-23:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b11714423679c51883fc998-%E6%A5%8A%E5%AE%B6%E6%89%8B%E5%B7%A5%E6%B0%B4%E9%A4%83"
    },
    {
      "id": "802",
      "name": "老饒牛肉麵",
      "address": "臺北市文山區木新路二段263號",
      "lng.": "121.5663873",
      "lat.": "24.9829912",
      "time": "暫時無資訊",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d8128c03a103ee86c816f-%E8%80%81%E9%A5%92%E7%89%9B%E8%82%89%E9%BA%B5"
    },
    {
      "id": "803",
      "name": "三一活力早餐 (原三三早餐二店)",
      "address": "臺北市文山區木新路二段103號",
      "lng.": "121.570101",
      "lat.": "24.984411",
      "time": "06:00-13:00",
      "cuisine_type": "台式|日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559dbf57c03a103ee86ca480-%E4%B8%89%E4%B8%80%E6%B4%BB%E5%8A%9B%E6%97%A9%E9%A4%90-(%E5%8E%9F%E4%B8%89%E4%B8%89%E6%97%A9%E9%A4%90%E4%BA%8C%E5%BA%97)"
    },
    {
      "id": "804",
      "name": "滾吧 Qunba 鍋物 萬隆店",
      "address": "臺北市文山區羅斯福路五段247號",
      "lng.": "121.5393464",
      "lat.": "25.0015575",
      "time": "11:30-22:00",
      "cuisine_type": "日式|台式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5afd1a0bf524687e344652d5-%E6%BB%BE%E5%90%A7-Qunba-%E9%8D%8B%E7%89%A9-%E8%90%AC%E9%9A%86%E5%BA%97"
    },
    {
      "id": "805",
      "name": "敏忠餐廳",
      "address": "臺北市文山區指南路二段57號1樓",
      "lng.": "121.574567",
      "lat.": "24.9879813",
      "time": "11:45-14:00, 17:15-20:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a4f5ccc03a10241de63bcb-%E6%95%8F%E5%BF%A0%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "806",
      "name": "呷麵騎士",
      "address": "臺北市文山區指南路二段45巷2弄1之1號",
      "lng.": "121.57443",
      "lat.": "24.9882559",
      "time": "11:30-14:30, 17:30-20:30",
      "cuisine_type": "泰式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58043a3f23679c7cef928863-%E5%91%B7%E9%BA%B5%E9%A8%8E%E5%A3%AB"
    },
    {
      "id": "807",
      "name": "渣男 Taiwan Bistro",
      "address": "臺北市文山區萬芳路9之1號",
      "lng.": "121.5705899",
      "lat.": "24.99848",
      "time": "00:00-01:30, 17:30-00:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5849a0bb2756dd614fb5136a-%E6%B8%A3%E7%94%B7-Taiwan-Bistro"
    },
    {
      "id": "808",
      "name": "芮比特",
      "address": "臺北市文山區木新路三段128號",
      "lng.": "121.5618484",
      "lat.": "24.9821146",
      "time": "14:00-22:00",
      "cuisine_type": "飲料",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c9e261ff5246847f70af2fd-%E8%8A%AE%E6%AF%94%E7%89%B9"
    },
    {
      "id": "809",
      "name": "好口樂傳統美食",
      "address": "臺北市文山區景美街35號",
      "lng.": "121.5417747",
      "lat.": "24.9918617",
      "time": "05:30-14:00",
      "cuisine_type": "台式",
      "rating": "3.6",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe9ac088c906d47f19b474d-%E5%A5%BD%E5%8F%A3%E6%A8%82%E5%82%B3%E7%B5%B1%E7%BE%8E%E9%A3%9F"
    },
    {
      "id": "810",
      "name": "阿葉米粉湯",
      "address": "臺北市文山區保儀路26巷4號",
      "lng.": "121.568126",
      "lat.": "24.98817",
      "time": "05:30-20:30",
      "cuisine_type": "台式",
      "rating": "3.7",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56aa58922756dd600d5e5939-%E9%98%BF%E8%91%89%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "811",
      "name": "自由51",
      "address": "臺北市文山區羅斯福路五段150巷59號",
      "lng.": "121.5378133",
      "lat.": "25.0073894",
      "time": "11:30-23:00",
      "cuisine_type": "咖啡",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bf7ac56f524687ff1d98239-%E8%87%AA%E7%94%B151"
    },
    {
      "id": "812",
      "name": "火鍋 海 精緻涮涮鍋",
      "address": "臺北市文山區木新路三段68號",
      "lng.": "121.5636895",
      "lat.": "24.9825222",
      "time": "11:30-14:00, 17:30-21:30",
      "cuisine_type": "日式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5bf2353f23679c0bbffc0afb-%E7%81%AB%E9%8D%8B-%E6%B5%B7-%E7%B2%BE%E7%B7%BB%E6%B6%AE%E6%B6%AE%E9%8D%8B"
    },
    {
      "id": "813",
      "name": "舒曼六號 Schumann's Bistro No. 6",
      "address": "臺北市文山區萬壽路6號",
      "lng.": "121.5761855",
      "lat.": "24.98807",
      "time": "11:00-22:00",
      "cuisine_type": "歐式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57effb0e2756dd0d0ff56524-%E8%88%92%E6%9B%BC%E5%85%AD%E8%99%9F-Schumann's-Bist"
    },
    {
      "id": "814",
      "name": "三媽臭臭鍋（新光店）",
      "address": "臺北市文山區新光路一段117號",
      "lng.": "121.573818",
      "lat.": "24.991361",
      "time": "11:00-23:00",
      "cuisine_type": "台式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bf2352723679c0bc0c228a6-%E4%B8%89%E5%AA%BD%E8%87%AD%E8%87%AD%E9%8D%8B%EF%BC%88%E6%96%B0%E5%85%89%E5%BA%97%EF%BC%89"
    },
    {
      "id": "815",
      "name": "西紅柿麵店",
      "address": "臺北市文山區興隆路三段112巷2弄2號",
      "lng.": "121.5571585",
      "lat.": "24.9990949",
      "time": "11:00-22:00",
      "cuisine_type": "日式|台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a68158c03a104df53ca757-%E8%A5%BF%E7%B4%85%E6%9F%BF%E9%BA%B5%E5%BA%97"
    },
    {
      "id": "816",
      "name": "吃香喝辣牛肉麵",
      "address": "臺北市文山區忠順街二段42號",
      "lng.": "121.5640757",
      "lat.": "24.9848023",
      "time": "11:00-20:30",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5beab6cf2261392c4fc178e8-%E5%90%83%E9%A6%99%E5%96%9D%E8%BE%A3%E7%89%9B%E8%82%89%E9%BA%B5"
    },
    {
      "id": "817",
      "name": "孫東寶牛排 文山興隆店",
      "address": "臺北市文山區興隆路三段138號",
      "lng.": "121.5580141",
      "lat.": "24.9987532",
      "time": "11:30-21:00",
      "cuisine_type": "台式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59f0d32c2756dd291cc670ab-%E5%AD%AB%E6%9D%B1%E5%AF%B6%E7%89%9B%E6%8E%92-%E6%96%87%E5%B1%B1%E8%88%88%E9%9A%86%E5%BA%97"
    },
    {
      "id": "818",
      "name": "魚玄雞小館",
      "address": "臺北市文山區興隆路三段231號",
      "lng.": "121.5592252",
      "lat.": "24.9933762",
      "time": "11:30-14:00, 17:30-21:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5ed03c03a102ec1415812-%E9%AD%9A%E7%8E%84%E9%9B%9E%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "819",
      "name": "好棒棒食堂",
      "address": "臺北市文山區木柵路二段113號",
      "lng.": "121.561872",
      "lat.": "24.9889945",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5be2a30e226139265b847166-%E5%A5%BD%E6%A3%92%E6%A3%92%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "820",
      "name": "阿枝米粉湯",
      "address": "臺北市文山區景美街113號",
      "lng.": "121.5414046",
      "lat.": "24.9901044",
      "time": "暫時無資訊",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a301a722756dd68d8793267-%E9%98%BF%E6%9E%9D%E7%B1%B3%E7%B2%89%E6%B9%AF"
    },
    {
      "id": "821",
      "name": "雨。聲。咖。啡",
      "address": "臺北市文山區景華街28號",
      "lng.": "121.54266",
      "lat.": "24.9949513",
      "time": "08:30-22:00",
      "cuisine_type": "咖啡",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57e6c0312756dd606f45b8f2-%E9%9B%A8%E3%80%82%E8%81%B2%E3%80%82%E5%92%96%E3%80%82%E5%95%A1"
    },
    {
      "id": "822",
      "name": "寶島肉圓店",
      "address": "臺北市文山區羅斯福路五段136號",
      "lng.": "121.538799",
      "lat.": "25.005884",
      "time": "11:30-20:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5feabc03a102ec1415d77-%E5%AF%B6%E5%B3%B6%E8%82%89%E5%9C%93%E5%BA%97"
    },
    {
      "id": "823",
      "name": "興記燒腊",
      "address": "臺北市文山區景文街17號",
      "lng.": "121.54143",
      "lat.": "24.992661",
      "time": "11:00-13:30, 15:30-18:00",
      "cuisine_type": "港式|台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a4faf3c03a10241de63db8-%E8%88%88%E8%A8%98%E7%87%92%E8%85%8A"
    },
    {
      "id": "824",
      "name": "川國麵館麻瘋麵",
      "address": "臺北市文山區興隆路四段116號",
      "lng.": "121.559638",
      "lat.": "24.989451",
      "time": "12:00-14:00, 17:30-20:30",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5be2a34d226139265c665db8-%E5%B7%9D%E5%9C%8B%E9%BA%B5%E9%A4%A8%E9%BA%BB%E7%98%8B%E9%BA%B5"
    },
    {
      "id": "825",
      "name": "飛驒涮涮鍋",
      "address": "臺北市文山區興隆路四段59號",
      "lng.": "121.5599699",
      "lat.": "24.9894784",
      "time": "12:00-14:30, 17:00-22:00",
      "cuisine_type": "日式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b8167312756dd4701921cb0-%E9%A3%9B%E9%A9%92%E6%B6%AE%E6%B6%AE%E9%8D%8B"
    },
    {
      "id": "826",
      "name": "山的另 一邊",
      "address": "臺北市文山區木新路二段264號1樓號",
      "lng.": "121.566041",
      "lat.": "24.983152",
      "time": "06:00-14:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b65eb592756dd2dc3e2af8a-%E5%B1%B1%E7%9A%84%E5%8F%A6-%E4%B8%80%E9%82%8A"
    },
    {
      "id": "827",
      "name": "驢爸爸凉麵",
      "address": "臺北市文山區景後街190號",
      "lng.": "121.5417271",
      "lat.": "24.990172",
      "time": "06:00-14:30",
      "cuisine_type": "台式|日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d6ba9c03a103ee86c742e-%E9%A9%A2%E7%88%B8%E7%88%B8%E5%87%89%E9%BA%B5"
    },
    {
      "id": "828",
      "name": "飽飽食府",
      "address": "臺北市文山區指南路二段119巷117號",
      "lng.": "121.576551",
      "lat.": "24.9876569",
      "time": "11:20-19:30",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b6f26d52756dd51613cf3f5-%E9%A3%BD%E9%A3%BD%E9%A3%9F%E5%BA%9C"
    },
    {
      "id": "829",
      "name": "Fun山豬香腸",
      "address": "臺北市文山區景美街37之33號",
      "lng.": "121.5418094",
      "lat.": "24.9915751",
      "time": "15:00-23:00",
      "cuisine_type": "台式",
      "rating": "4.6",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5fe9abd68c906d47f19b4728-Fun%E5%B1%B1%E8%B1%AC%E9%A6%99%E8%85%B8"
    },
    {
      "id": "830",
      "name": "景美好吃豆花",
      "address": "臺北市文山區景文街133號",
      "lng.": "121.541162",
      "lat.": "24.990145",
      "time": "16:00-00:00",
      "cuisine_type": "飲料",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5bdbfc03a10241de67f2a-%E6%99%AF%E7%BE%8E%E5%A5%BD%E5%90%83%E8%B1%86%E8%8A%B1"
    },
    {
      "id": "831",
      "name": "龐家肉羹",
      "address": "臺北市文山區新光路一段193號",
      "lng.": "121.5740014",
      "lat.": "24.9934971",
      "time": "06:00-13:30",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b69e2772756dd2dc3e32b86-%E9%BE%90%E5%AE%B6%E8%82%89%E7%BE%B9"
    },
    {
      "id": "832",
      "name": "清泉廣場",
      "address": "臺北市文山區指南路三段38巷33之1號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "11:00-21:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d01c7c03a103ee86c32b6-%E6%B8%85%E6%B3%89%E5%BB%A3%E5%A0%B4"
    },
    {
      "id": "833",
      "name": "鬼匠拉麵-木柵店",
      "address": "臺北市文山區指南路二段28號",
      "lng.": "121.5746506",
      "lat.": "24.9877794",
      "time": "11:00-14:00, 17:00-20:30",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c2c72b1f5246818d4cd8cbe-%E9%AC%BC%E5%8C%A0%E6%8B%89%E9%BA%B5-%E6%9C%A8%E6%9F%B5%E5%BA%97"
    },
    {
      "id": "834",
      "name": "MY麵屋",
      "address": "臺北市文山區指南路二段45巷7號",
      "lng.": "121.574246",
      "lat.": "24.9883459",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "台式|中式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5c2c72a622613958b26e1aab-MY%E9%BA%B5%E5%B1%8B"
    },
    {
      "id": "835",
      "name": "永和豆漿大王(木新店)",
      "address": "臺北市文山區木新路二段293號",
      "lng.": "121.5655409",
      "lat.": "24.9827027",
      "time": "00:00-10:30, 19:00-00:00",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b28701e23679c19b35d4a09-%E6%B0%B8%E5%92%8C%E8%B1%86%E6%BC%BF%E5%A4%A7%E7%8E%8B(%E6%9C%A8%E6%96%B0%E5%BA%97)"
    },
    {
      "id": "836",
      "name": "老大房食品",
      "address": "臺北市文山區羅斯福路六段30之1號",
      "lng.": "121.539611",
      "lat.": "24.999752",
      "time": "07:00-22:30",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5b12dce52756dd3d0c883604-%E8%80%81%E5%A4%A7%E6%88%BF%E9%A3%9F%E5%93%81"
    },
    {
      "id": "837",
      "name": "潘鵝肉專賣店",
      "address": "臺北市文山區木新路二段283號",
      "lng.": "121.565796",
      "lat.": "24.9828002",
      "time": "11:30-20:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5b103bd52756dd5361ca1658-%E6%BD%98%E9%B5%9D%E8%82%89%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "838",
      "name": "咖啡大亨",
      "address": "臺北市文山區指南路二段45巷1號",
      "lng.": "121.574199",
      "lat.": "24.98818",
      "time": "08:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5655df9e2756dd1d7a1aff63-%E5%92%96%E5%95%A1%E5%A4%A7%E4%BA%A8"
    },
    {
      "id": "839",
      "name": "京華小館",
      "address": "臺北市文山區新光路一段13號",
      "lng.": "121.573815",
      "lat.": "24.9885999",
      "time": "11:00-19:50",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5fc6fc03a102ec1415cc8-%E4%BA%AC%E8%8F%AF%E5%B0%8F%E9%A4%A8"
    },
    {
      "id": "840",
      "name": "trouble maker搗蛋鬼手工鬆餅",
      "address": "臺北市文山區羅斯福路六段455巷12號",
      "lng.": "121.5405293",
      "lat.": "24.9900273",
      "time": "10:30-18:00",
      "cuisine_type": "美式",
      "rating": "4.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/592085492756dd5484ad9390-trouble-maker%E6%90%97%E8%9B%8B%E9%AC%BC%E6%89%8B%E5%B7%A5%E9%AC%86%E9%A4%85"
    },
    {
      "id": "841",
      "name": "屏東清蒸肉圓",
      "address": "臺北市文山區景美街",
      "lng.": "121.5416403",
      "lat.": "24.9916431",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5accfe552756dd7b4e1324f3-%E5%B1%8F%E6%9D%B1%E6%B8%85%E8%92%B8%E8%82%89%E5%9C%93"
    },
    {
      "id": "842",
      "name": "加賀日式料理",
      "address": "臺北市文山區指南路二段17號",
      "lng.": "121.573499",
      "lat.": "24.988308",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a718c3bf5246808fa6e5d21-%E5%8A%A0%E8%B3%80%E6%97%A5%E5%BC%8F%E6%96%99%E7%90%86"
    },
    {
      "id": "843",
      "name": "廟邊阿珠芋圓",
      "address": "臺北市文山區深坑老街",
      "lng.": "121.6147377",
      "lat.": "25.0016916",
      "cuisine_type": "飲料",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a58cffc03a10241de66ff1-%E5%BB%9F%E9%82%8A%E9%98%BF%E7%8F%A0%E8%8A%8B%E5%9C%93"
    },
    {
      "id": "844",
      "name": "阿里郎韓國小吃",
      "address": "臺北市文山區指南路二段31號",
      "lng.": "121.573879",
      "lat.": "24.9881579",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "韓式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c2c7298f5246818b0ea0106-%E9%98%BF%E9%87%8C%E9%83%8E%E9%9F%93%E5%9C%8B%E5%B0%8F%E5%90%83"
    },
    {
      "id": "845",
      "name": "Tenshima 天島咖啡",
      "address": "臺北市文山區羅斯福路六段311號",
      "lng.": "121.541397",
      "lat.": "24.9940195",
      "time": "11:30-19:00",
      "cuisine_type": "咖啡",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5bab5101f524687094f6eae9-Tenshima-%E5%A4%A9%E5%B3%B6%E5%92%96%E5%95%A1"
    },
    {
      "id": "846",
      "name": "小白ㄔ麵館",
      "address": "臺北市文山區興隆路二段220巷29號",
      "lng.": "121.5524083",
      "lat.": "25.0005949",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56df14c92756dd19d835e7db-%E5%B0%8F%E7%99%BD%E3%84%94%E9%BA%B5%E9%A4%A8"
    },
    {
      "id": "847",
      "name": "阿昌麵線臭豆腐",
      "address": "臺北市文山區景美街45號",
      "lng.": "121.5421518",
      "lat.": "24.9913326",
      "time": "15:30-23:30",
      "cuisine_type": "台式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559dbf6ec03a103ee86ca498-%E9%98%BF%E6%98%8C%E9%BA%B5%E7%B7%9A%E8%87%AD%E8%B1%86%E8%85%90"
    },
    {
      "id": "848",
      "name": "高雙管四神湯",
      "address": "臺北市文山區景美街139號",
      "lng.": "121.5415143",
      "lat.": "24.9895567",
      "time": "15:00-22:30",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5d137f742756dd4ea96f963c-%E9%AB%98%E9%9B%99%E7%AE%A1%E5%9B%9B%E7%A5%9E%E6%B9%AF"
    },
    {
      "id": "849",
      "name": "老溫大餛飩麵店",
      "address": "臺北市文山區興隆路三段112巷1號",
      "lng.": "121.557318",
      "lat.": "24.9988925",
      "time": "11:00-22:30",
      "cuisine_type": "台式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a7ab11d2756dd7bff171daf-%E8%80%81%E6%BA%AB%E5%A4%A7%E9%A4%9B%E9%A3%A9%E9%BA%B5%E5%BA%97"
    },
    {
      "id": "850",
      "name": "越南小吃",
      "address": "臺北市文山區景美街9之11號",
      "lng.": "121.5417644",
      "lat.": "24.9940988",
      "time": "16:30-23:00",
      "cuisine_type": "東南亞",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a7aae9a2756dd7bff171cbe-%E8%B6%8A%E5%8D%97%E5%B0%8F%E5%90%83"
    },
    {
      "id": "851",
      "name": "越南河內小吃",
      "address": "臺北市文山區景美街6號",
      "lng.": "121.5418351",
      "lat.": "24.992583",
      "time": "11:00-22:00",
      "cuisine_type": "東南亞",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a6cc0762756dd65298e3176-%E8%B6%8A%E5%8D%97%E6%B2%B3%E5%85%A7%E5%B0%8F%E5%90%83"
    },
    {
      "id": "852",
      "name": "Lecker里克德義廚房",
      "address": "臺北市文山區新光路一段22之1號",
      "lng.": "121.573465",
      "lat.": "24.98884",
      "time": "11:30-15:00, 17:00-21:00",
      "cuisine_type": "義式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dbe11c03a103ee86ca3b1-Lecker%E9%87%8C%E5%85%8B%E5%BE%B7%E7%BE%A9%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "853",
      "name": "揉道Nubun不老麵糰",
      "address": "臺北市文山區新光路一段143號",
      "lng.": "121.573884",
      "lat.": "24.991961",
      "time": "12:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a68cc2a2756dd35cfc67b68-%E6%8F%89%E9%81%93Nubun%E4%B8%8D%E8%80%81%E9%BA%B5%E7%B3%B0"
    },
    {
      "id": "854",
      "name": "欣帝堡活力早午餐",
      "address": "臺北市文山區保儀路171號，1樓",
      "lng.": "121.5659988",
      "lat.": "24.9835287",
      "time": "06:00-13:00",
      "cuisine_type": "美式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a4ef7c3f524683d3ce70466-%E6%AC%A3%E5%B8%9D%E5%A0%A1%E6%B4%BB%E5%8A%9B%E6%97%A9%E5%8D%88%E9%A4%90"
    },
    {
      "id": "855",
      "name": "德利香雞排",
      "address": "臺北市文山區景美街6之1號",
      "lng.": "121.5417685",
      "lat.": "24.9940027",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a5111432756dd470761935e-%E5%BE%B7%E5%88%A9%E9%A6%99%E9%9B%9E%E6%8E%92"
    },
    {
      "id": "856",
      "name": "Creative Pasta 創義麵",
      "address": "臺北市文山區興隆路三段67號2樓",
      "lng.": "121.5563129",
      "lat.": "25.0002018",
      "time": "11:00-21:30",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5a4bcab92756dd4707613075-Creative-Pasta-%E5%89%B5%E7%BE%A9%E9%BA%B5"
    },
    {
      "id": "857",
      "name": "小法國早餐坊",
      "address": "臺北市文山區景興路28號",
      "lng.": "121.544521",
      "lat.": "24.997458",
      "time": "06:30-14:00",
      "cuisine_type": "法式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a5c0f8c03a10241de68043-%E5%B0%8F%E6%B3%95%E5%9C%8B%E6%97%A9%E9%A4%90%E5%9D%8A"
    },
    {
      "id": "858",
      "name": "米塔義式廚房",
      "address": "臺北市文山區萬壽路2號1樓",
      "lng.": "121.5757922",
      "lat.": "24.9878909",
      "time": "11:00-22:00",
      "cuisine_type": "義式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5f0f9c03a102ec1415951-%E7%B1%B3%E5%A1%94%E7%BE%A9%E5%BC%8F%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "859",
      "name": "No. 8+9 一起冰沙吧",
      "address": "臺北市文山區新光路一段19號",
      "lng.": "121.5737677",
      "lat.": "24.9886958",
      "time": "10:30-21:30",
      "cuisine_type": "飲料",
      "rating": "4.3",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5af87f122756dd17962859f4-No.-8%2B9-%E4%B8%80%E8%B5%B7%E5%86%B0%E6%B2%99%E5%90%A7"
    },
    {
      "id": "860",
      "name": "王德福滷担麵館",
      "address": "臺北市文山區木新路三段357號",
      "lng.": "121.5556084",
      "lat.": "24.9802443",
      "time": "11:00-14:00, 16:45-20:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5f572a312756dd155d8e58ec-%E7%8E%8B%E5%BE%B7%E7%A6%8F%E6%BB%B7%E6%8B%85%E9%BA%B5%E9%A4%A8"
    },
    {
      "id": "861",
      "name": "餐一咖",
      "address": "臺北市文山區萬慶街14號",
      "lng.": "121.5400305",
      "lat.": "24.9924415",
      "time": "11:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59e4f6052756dd59ca88e577-%E9%A4%90%E4%B8%80%E5%92%96"
    },
    {
      "id": "862",
      "name": "荷理固 麵館",
      "address": "臺北市文山區木新路三段75號",
      "lng.": "121.5634269",
      "lat.": "24.9821693",
      "time": "11:30-14:30, 17:30-20:30",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/590e0fef2756dd73705009c4-%E8%8D%B7%E7%90%86%E5%9B%BA-%E9%BA%B5%E9%A4%A8"
    },
    {
      "id": "863",
      "name": "人从众厚切牛排 (景美店)",
      "address": "臺北市文山區景文街137號",
      "lng.": "121.541122",
      "lat.": "24.9899846",
      "time": "11:00-22:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58fb9b3e2756dd27448b4ddc-%E4%BA%BA%E4%BB%8E%E4%BC%97%E5%8E%9A%E5%88%87%E7%89%9B%E6%8E%92-(%E6%99%AF%E7%BE%8E%E5%BA%97)"
    },
    {
      "id": "864",
      "name": "池上吾家木盒便當",
      "address": "臺北市文山區興隆路一段67號",
      "lng.": "121.5411853",
      "lat.": "25.0036763",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59af718ef5246859c43a7324-%E6%B1%A0%E4%B8%8A%E5%90%BE%E5%AE%B6%E6%9C%A8%E7%9B%92%E4%BE%BF%E7%95%B6"
    },
    {
      "id": "865",
      "name": "LIRA里拉義大利廚房",
      "address": "臺北市文山區木新路三段67號",
      "lng.": "121.5637081",
      "lat.": "24.982222",
      "time": "11:30-14:30, 17:00-21:30",
      "cuisine_type": "義式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57e963752756dd606545ba81-LIRA%E9%87%8C%E6%8B%89%E7%BE%A9%E5%A4%A7%E5%88%A9%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "866",
      "name": "老凃食堂 Tu's Meal House",
      "address": "臺北市文山區羅斯福路六段202巷1號",
      "lng.": "121.5405644",
      "lat.": "24.9937824",
      "time": "11:30-14:00, 17:30-20:30",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/59875b352756dd22a8bd293b-%E8%80%81%E5%87%83%E9%A3%9F%E5%A0%82-Tu's-Meal-House"
    },
    {
      "id": "867",
      "name": "豐滿/總匯三明治",
      "address": "臺北市文山區景華街127號",
      "lng.": "121.547247",
      "lat.": "24.9962139",
      "time": "08:00-17:00",
      "cuisine_type": "美式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5a407e3423679c4a791264d3-%E8%B1%90%E6%BB%BF%2F%E7%B8%BD%E5%8C%AF%E4%B8%89%E6%98%8E%E6%B2%BB"
    },
    {
      "id": "868",
      "name": "頂鼎食堂",
      "address": "臺北市文山區興隆路三段112巷3號",
      "lng.": "121.5572241",
      "lat.": "24.9988506",
      "time": "11:00-21:30",
      "cuisine_type": "台式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58600b1f2756dd757bb8f277-%E9%A0%82%E9%BC%8E%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "869",
      "name": "Creative Pasta 創義麵",
      "address": "臺北市文山區景文街155號",
      "lng.": "121.5410131",
      "lat.": "24.9893974",
      "time": "11:00-22:00",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5655fdf92756dd1d7a1b0189-Creative-Pasta-%E5%89%B5%E7%BE%A9%E9%BA%B5"
    },
    {
      "id": "870",
      "name": "義蘿蒂義大利麵",
      "address": "臺北市文山區景興路202巷8號",
      "lng.": "121.54331",
      "lat.": "24.992006",
      "time": "11:00-14:30, 17:00-21:00",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/595bd95c2756dd27dfff135a-%E7%BE%A9%E8%98%BF%E8%92%82%E7%BE%A9%E5%A4%A7%E5%88%A9%E9%BA%B5"
    },
    {
      "id": "871",
      "name": "FunCafe親子餐廳",
      "address": "臺北市文山區羅斯福路五段236巷3之2號3弄號",
      "lng.": "121.53829",
      "lat.": "25.0014493",
      "time": "11:30-20:30",
      "cuisine_type": "咖啡",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/5665ca6e2756dd1228aa7d72-FunCafe%E8%A6%AA%E5%AD%90%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "872",
      "name": "龍角咖啡Dragon horn coffee",
      "address": "臺北市文山區指南路二段33號",
      "lng.": "121.573936",
      "lat.": "24.988132",
      "time": "11:00-21:00",
      "cuisine_type": "飲料|咖啡",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58372b482756dd4994cca22a-%E9%BE%8D%E8%A7%92%E5%92%96%E5%95%A1Dragon-horn-coff"
    },
    {
      "id": "873",
      "name": "巴東蜀味",
      "address": "臺北市文山區新光路一段40號",
      "lng.": "121.5736685",
      "lat.": "24.9896584",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a68259c03a104df53ca792-%E5%B7%B4%E6%9D%B1%E8%9C%80%E5%91%B3"
    },
    {
      "id": "874",
      "name": "海味豐",
      "address": "臺北市文山區景美街81號",
      "lng.": "121.5417928",
      "lat.": "24.9905717",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "日式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/594812af2756dd524dd0909d-%E6%B5%B7%E5%91%B3%E8%B1%90"
    },
    {
      "id": "875",
      "name": "小丼作食堂",
      "address": "臺北市文山區木新路三段13號",
      "lng.": "121.564914",
      "lat.": "24.9825458",
      "time": "12:00-14:00, 17:30-20:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5915a433699b6e035c137823-%E5%B0%8F%E4%B8%BC%E4%BD%9C%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "876",
      "name": "Hunger",
      "address": "臺北市文山區忠順街二段51號",
      "lng.": "121.5641941",
      "lat.": "24.9850187",
      "time": "06:30-15:30",
      "cuisine_type": "美式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info": "https://ifoodie.tw/restaurant/56744bba2756dd3d5352acb3-Hunger"
    },
    {
      "id": "877",
      "name": "菁串蔬食燒烤bar",
      "address": "臺北市文山區忠順街一段35號",
      "lng.": "121.558149",
      "lat.": "24.984042",
      "time": "17:00-23:00",
      "cuisine_type": "台式",
      "rating": "4.7",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/593d1106699b6e2a61dc00c9-%E8%8F%81%E4%B8%B2%E8%94%AC%E9%A3%9F%E7%87%92%E7%83%A4bar"
    },
    {
      "id": "878",
      "name": "偵軒精緻鍋物(總店)",
      "address": "臺北市文山區景福街1號",
      "lng.": "121.539383",
      "lat.": "24.999398",
      "time": "11:30-14:30, 17:00-23:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/57716b962756dd5159c80772-%E5%81%B5%E8%BB%92%E7%B2%BE%E7%B7%BB%E9%8D%8B%E7%89%A9(%E7%B8%BD%E5%BA%97)"
    },
    {
      "id": "879",
      "name": "一口壽司",
      "address": "臺北市文山區興隆路三段146號",
      "lng.": "121.5581103",
      "lat.": "24.9986932",
      "time": "10:00-20:20",
      "cuisine_type": "日式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58275a162756dd1998ef6bad-%E4%B8%80%E5%8F%A3%E5%A3%BD%E5%8F%B8"
    },
    {
      "id": "880",
      "name": "Juicy Bun Burger 就是棒 美式餐廳",
      "address": "臺北市文山區萬壽路19號",
      "lng.": "121.5760434",
      "lat.": "24.9882457",
      "time": "11:30-22:00",
      "cuisine_type": "美式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5e489c03a102ec1415553-Juicy-Bun-Burger-%E5%B0%B1%E6%98%AF%E6%A3%92"
    },
    {
      "id": "881",
      "name": "木新蚵仔麵線",
      "address": "臺北市文山區木新路三段183巷",
      "lng.": "121.5603807",
      "lat.": "24.9812356",
      "time": "11:30-19:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/592048cef5246847927ff2c9-%E6%9C%A8%E6%96%B0%E8%9A%B5%E4%BB%94%E9%BA%B5%E7%B7%9A"
    },
    {
      "id": "882",
      "name": "福鼎湯包店二店",
      "address": "臺北市文山區興隆路三段31號",
      "lng.": "121.5555773",
      "lat.": "25.0006348",
      "time": "06:30-22:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/59bb781e23679c4ecb5b88c1-%E7%A6%8F%E9%BC%8E%E6%B9%AF%E5%8C%85%E5%BA%97%E4%BA%8C%E5%BA%97"
    },
    {
      "id": "883",
      "name": "佳香北平烤鴨",
      "address": "臺北市文山區興隆路二段204號",
      "lng.": "121.552081",
      "lat.": "25.001545",
      "time": "10:30-21:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/590fd789699b6e5795dd2892-%E4%BD%B3%E9%A6%99%E5%8C%97%E5%B9%B3%E7%83%A4%E9%B4%A8"
    },
    {
      "id": "884",
      "name": "青島包子專賣店",
      "address": "臺北市文山區興隆路二段220巷18號",
      "lng.": "121.5522475",
      "lat.": "25.0006501",
      "time": "06:30-11:00, 15:30-20:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d7f2bc03a103ee86c8082-%E9%9D%92%E5%B3%B6%E5%8C%85%E5%AD%90%E5%B0%88%E8%B3%A3%E5%BA%97"
    },
    {
      "id": "885",
      "name": "永康街左撇子",
      "address": "臺北市文山區指南路二段119巷10號",
      "lng.": "121.5765219",
      "lat.": "24.9878368",
      "time": "11:30-14:00, 17:00-20:30",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5908cb7c2756dd5ad265daf2-%E6%B0%B8%E5%BA%B7%E8%A1%97%E5%B7%A6%E6%92%87%E5%AD%90"
    },
    {
      "id": "886",
      "name": "佳味自助餐",
      "address": "臺北市文山區指南路二段155號",
      "lng.": "121.5774447",
      "lat.": "24.987466",
      "time": "10:00-14:00, 16:30-20:00",
      "cuisine_type": "台式",
      "rating": "3.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5906a6c823679c5ccf198e9d-%E4%BD%B3%E5%91%B3%E8%87%AA%E5%8A%A9%E9%A4%90"
    },
    {
      "id": "887",
      "name": "九湯屋日式拉麵 景美店",
      "address": "臺北市文山區景美街141號",
      "lng.": "121.5415322",
      "lat.": "24.9895168",
      "time": "11:30-21:30",
      "cuisine_type": "日式",
      "rating": "3.7",
      "inout": ['內用'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5904d5db2756dd5ad565d947-%E4%B9%9D%E6%B9%AF%E5%B1%8B%E6%97%A5%E5%BC%8F%E6%8B%89%E9%BA%B5-%E6%99%AF%E7%BE%8E%E5%BA%97"
    },
    {
      "id": "888",
      "name": "榆小舖",
      "address": "臺北市文山區羅斯福路六段269號後棟",
      "lng.": "121.5415737",
      "lat.": "24.9948236",
      "time": "17:30-22:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4f46dc03a10241de63b4c-%E6%A6%86%E5%B0%8F%E8%88%96"
    },
    {
      "id": "889",
      "name": "景美夜市-油飯.蚵仔麵線",
      "address": "臺北市文山區景美街139號",
      "lng.": "121.5415143",
      "lat.": "24.9895567",
      "time": "17:00-23:00",
      "cuisine_type": "台式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/587e5dc42756dd3ab3f6b585-%E6%99%AF%E7%BE%8E%E5%A4%9C%E5%B8%82-%E6%B2%B9%E9%A3%AF.%E8%9A%B5%E4%BB%94%E9%BA%B5%E7%B7%9A"
    },
    {
      "id": "890",
      "name": "磨豆花棧",
      "address": "臺北市文山區保儀路73號",
      "lng.": "121.568596",
      "lat.": "24.9870019",
      "time": "14:00-22:30",
      "cuisine_type": "飲料",
      "rating": "4.6",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d6387c03a103ee86c6de7-%E7%A3%A8%E8%B1%86%E8%8A%B1%E6%A3%A7"
    },
    {
      "id": "891",
      "name": "白師父熱炒",
      "address": "臺北市文山區興隆路三段15號",
      "lng.": "121.555062",
      "lat.": "25.000876",
      "time": "17:00-00:00",
      "cuisine_type": "台式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a530b4c03a10241de65016-%E7%99%BD%E5%B8%AB%E7%88%B6%E7%86%B1%E7%82%92"
    },
    {
      "id": "892",
      "name": "Jim's Burger",
      "address": "臺北市文山區景興路282巷1號",
      "lng.": "121.54202",
      "lat.": "24.989523",
      "time": "06:30-18:00",
      "cuisine_type": "美式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/564387462756dd40eaa05fbe-Jim's-Burger"
    },
    {
      "id": "893",
      "name": "景美夜市詹氏燒肉刈包",
      "address": "臺北市文山區景美街75號",
      "lng.": "121.541812",
      "lat.": "24.990672",
      "time": "16:30-22:30",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58ed1a402756dd328d6c4f6d-%E6%99%AF%E7%BE%8E%E5%A4%9C%E5%B8%82%E8%A9%B9%E6%B0%8F%E7%87%92%E8%82%89%E5%88%88%E5%8C%85"
    },
    {
      "id": "894",
      "name": "韓國首爾小吃",
      "address": "臺北市文山區木柵路二段147號",
      "lng.": "121.5627449",
      "lat.": "24.9891092",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "韓式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a5eb75c03a102ec1415794-%E9%9F%93%E5%9C%8B%E9%A6%96%E7%88%BE%E5%B0%8F%E5%90%83"
    },
    {
      "id": "895",
      "name": "葉記鴨肉飯",
      "address": "臺北市文山區指南路一段60號",
      "lng.": "121.570419",
      "lat.": "24.98767",
      "time": "11:30-14:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/58edbca823679c103482baff-%E8%91%89%E8%A8%98%E9%B4%A8%E8%82%89%E9%A3%AF"
    },
    {
      "id": "896",
      "name": "老頭家客家菜",
      "address": "臺北市文山區忠順街一段159號",
      "lng.": "121.5612903",
      "lat.": "24.9845227",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/58de9b552756dd7a7c2b3bb7-%E8%80%81%E9%A0%AD%E5%AE%B6%E5%AE%A2%E5%AE%B6%E8%8F%9C"
    },
    {
      "id": "897",
      "name": "福圓號真功夫養生饅頭",
      "address": "臺北市文山區興隆路三段298號",
      "lng.": "121.5588256",
      "lat.": "24.9932123",
      "time": "12:00-20:00",
      "cuisine_type": "中式",
      "rating": "4.2",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559d96b1c03a103ee86c8d69-%E7%A6%8F%E5%9C%93%E8%99%9F%E7%9C%9F%E5%8A%9F%E5%A4%AB%E9%A4%8A%E7%94%9F%E9%A5%85%E9%A0%AD"
    },
    {
      "id": "898",
      "name": "景明蚵仔麵線",
      "address": "臺北市文山區羅斯福路五段269巷景明街",
      "lng.": "121.5409502",
      "lat.": "25.0015103",
      "time": "暫時無資訊",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/577aa4bf2756dd3ca9069804-%E6%99%AF%E6%98%8E%E8%9A%B5%E4%BB%94%E9%BA%B5%E7%B7%9A"
    },
    {
      "id": "899",
      "name": "韓大佬韓式精緻料理",
      "address": "臺北市文山區新光路一段27號",
      "lng.": "121.573903",
      "lat.": "24.9892959",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "韓式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/58b1c75a2756dd4b2e792050-%E9%9F%93%E5%A4%A7%E4%BD%AC%E9%9F%93%E5%BC%8F%E7%B2%BE%E7%B7%BB%E6%96%99%E7%90%86"
    },
    {
      "id": "900",
      "name": "Arty Burger(政大店)",
      "address": "臺北市文山區指南路二段45巷12號",
      "lng.": "121.574557",
      "lat.": "24.988768",
      "time": "07:00-15:00",
      "cuisine_type": "美式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/576983122756dd134b34d02f-Arty-Burger(%E6%94%BF%E5%A4%A7%E5%BA%97)"
    },
    {
      "id": "901",
      "name": "貓空咖啡巷",
      "address": "臺北市文山區指南路三段38巷33之5號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "10:00-21:00",
      "cuisine_type": "咖啡",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56744bb72756dd3d5352acad-%E8%B2%93%E7%A9%BA%E5%92%96%E5%95%A1%E5%B7%B7"
    },
    {
      "id": "902",
      "name": "Iceパン霜淇淋堡",
      "address": "臺北市文山區興隆路二段220巷31弄28號",
      "lng.": "121.552975",
      "lat.": "25.000159",
      "time": "11:00-22:00",
      "cuisine_type": "飲料",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5859734a2756dd757bb8f0d2-Ice%E3%83%91%E3%83%B3%E9%9C%9C%E6%B7%87%E6%B7%8B%E5%A0%A1"
    },
    {
      "id": "903",
      "name": "Louisa Coffee 路易．莎咖啡(木新店)",
      "address": "臺北市文山區木新路三段177號",
      "lng.": "121.5605018",
      "lat.": "24.9815344",
      "time": "07:00-20:00",
      "cuisine_type": "飲料",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/581b2c572756dd14161a0158-Louisa-Coffee-%E8%B7%AF%E6%98%93%EF%BC%8E%E8%8E%8E%E5%92%96%E5%95%A1"
    },
    {
      "id": "904",
      "name": "Go! Cafe 早午餐",
      "address": "臺北市文山區新光路一段34之1號",
      "lng.": "121.5736",
      "lat.": "24.9893179",
      "time": "06:30-14:30",
      "cuisine_type": "美式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/5812a7b823679c3507dad40e-Go!-Cafe-%E6%97%A9%E5%8D%88%E9%A4%90"
    },
    {
      "id": "905",
      "name": "四哥的店",
      "address": "臺北市文山區指南路三段38巷33之1號",
      "lng.": "121.5911684",
      "lat.": "24.9667809",
      "time": "11:30-22:00",
      "cuisine_type": "港式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d01c9c03a103ee86c32ba-%E5%9B%9B%E5%93%A5%E7%9A%84%E5%BA%97"
    },
    {
      "id": "906",
      "name": "let's italy 出發義大利廚房",
      "address": "臺北市文山區木柵路一段137號",
      "lng.": "121.5502165",
      "lat.": "24.9876051",
      "time": "11:30-14:30, 17:00-20:30",
      "cuisine_type": "義式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/579ed470699b6e62dfa4183c-let's-italy-%E5%87%BA%E7%99%BC%E7%BE%A9%E5%A4%A7%E5%88%A9%E5%BB%9A%E6%88%BF"
    },
    {
      "id": "907",
      "name": "大家素食",
      "address": "臺北市文山區車前路3號",
      "lng.": "121.541107",
      "lat.": "24.9912299",
      "time": "11:00-14:00, 17:00-20:30",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/57b2073a2756dd37bbd6ed9e-%E5%A4%A7%E5%AE%B6%E7%B4%A0%E9%A3%9F"
    },
    {
      "id": "908",
      "name": "小張小吃店",
      "address": "臺北市文山區景文街49號",
      "lng.": "121.5414047",
      "lat.": "24.9917802",
      "time": "暫時無資訊",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/576c25d52756dd05fa6ca50a-%E5%B0%8F%E5%BC%B5%E5%B0%8F%E5%90%83%E5%BA%97"
    },
    {
      "id": "909",
      "name": "樂山食堂",
      "address": "臺北市文山區新光路一段26號",
      "lng.": "121.573557",
      "lat.": "24.989007",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d0160c03a103ee86c328b-%E6%A8%82%E5%B1%B1%E9%A3%9F%E5%A0%82"
    },
    {
      "id": "910",
      "name": "緣聚成家蔬食料理",
      "address": "臺北市文山區木新路三段152號",
      "lng.": "121.5613715",
      "lat.": "24.9819767",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5c74e5e22261395854b93685-%E7%B7%A3%E8%81%9A%E6%88%90%E5%AE%B6%E8%94%AC%E9%A3%9F%E6%96%99%E7%90%86"
    },
    {
      "id": "911",
      "name": "味自慢 居酒屋",
      "address": "臺北市文山區景興路118號",
      "lng.": "121.5443145",
      "lat.": "24.9935417",
      "time": "17:30-22:00",
      "cuisine_type": "日式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/55a5041dc03a10241de640ff-%E5%91%B3%E8%87%AA%E6%85%A2-%E5%B1%85%E9%85%92%E5%B1%8B"
    },
    {
      "id": "912",
      "name": "羅馬蕃茄義大利麵蔬食",
      "address": "臺北市文山區木新路三段139號",
      "lng.": "121.5616563",
      "lat.": "24.9818032",
      "time": "11:30-14:30, 17:30-21:00",
      "cuisine_type": "義式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56d094602756dd66e76a5d41-%E7%BE%85%E9%A6%AC%E8%95%83%E8%8C%84%E7%BE%A9%E5%A4%A7%E5%88%A9%E9%BA%B5%E8%94%AC%E9%A3%9F"
    },
    {
      "id": "913",
      "name": "大家素食",
      "address": "臺北市文山區興隆路三段112巷2弄23號",
      "lng.": "121.5563548",
      "lat.": "24.9993013",
      "time": "11:30-14:00, 17:00-20:00",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56c4b6f72756dd75130ce443-%E5%A4%A7%E5%AE%B6%E7%B4%A0%E9%A3%9F"
    },
    {
      "id": "914",
      "name": "永旺水餃",
      "address": "臺北市文山區保儀路163號",
      "lng.": "121.5662736",
      "lat.": "24.9839672",
      "time": "暫時無資訊",
      "cuisine_type": "台式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/56b2412b2756dd3609e2ff67-%E6%B0%B8%E6%97%BA%E6%B0%B4%E9%A4%83"
    },
    {
      "id": "915",
      "name": "天恩至德素食糕餅",
      "address": "臺北市文山區指南路三段38巷37之2號",
      "lng.": "121.5918065",
      "lat.": "24.9686888",
      "time": "08:00-18:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/56aa58882756dd600d5e592d-%E5%A4%A9%E6%81%A9%E8%87%B3%E5%BE%B7%E7%B4%A0%E9%A3%9F%E7%B3%95%E9%A4%85"
    },
    {
      "id": "916",
      "name": "小曼谷滇泰料理",
      "address": "臺北市文山區指南路二段19號",
      "lng.": "121.573542",
      "lat.": "24.988301",
      "time": "11:30-14:00, 17:00-21:00",
      "cuisine_type": "泰式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a67909c03a104df53ca4f2-%E5%B0%8F%E6%9B%BC%E8%B0%B7%E6%BB%87%E6%B3%B0%E6%96%99%E7%90%86"
    },
    {
      "id": "917",
      "name": "Hot 7新鐵板料理",
      "address": "臺北市文山區景中街1號",
      "lng.": "121.541543",
      "lat.": "24.993062",
      "time": "11:30-14:30, 17:30-22:00",
      "cuisine_type": "日式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5af3043223679c29aa040ccf-Hot-7%E6%96%B0%E9%90%B5%E6%9D%BF%E6%96%99%E7%90%86"
    },
    {
      "id": "918",
      "name": "榮記點心",
      "address": "臺北市文山區景文街27號",
      "lng.": "121.5414106",
      "lat.": "24.9924998",
      "time": "07:30-19:30",
      "cuisine_type": "中式",
      "rating": "3.7",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55e0a4852756dd647bd686d1-%E6%A6%AE%E8%A8%98%E9%BB%9E%E5%BF%83"
    },
    {
      "id": "919",
      "name": "竹壽司",
      "address": "臺北市文山區羅斯福路六段9號",
      "lng.": "121.539863",
      "lat.": "25.000299",
      "time": "12:00-14:30, 17:30-21:30",
      "cuisine_type": "日式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d97e4c03a103ee86c8dfb-%E7%AB%B9%E5%A3%BD%E5%8F%B8"
    },
    {
      "id": "920",
      "name": "順園美食",
      "address": "臺北市文山區木柵路三段1號",
      "lng.": "121.5644101",
      "lat.": "24.9886737",
      "time": "11:00-21:00",
      "cuisine_type": "台式",
      "rating": "4.2",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d80c5c03a103ee86c8136-%E9%A0%86%E5%9C%92%E7%BE%8E%E9%A3%9F"
    },
    {
      "id": "921",
      "name": "微笑碳烤",
      "address": "臺北市文山區景美街",
      "lng.": "121.5416403",
      "lat.": "24.9916431",
      "time": "00:00-01:00, 17:30-00:00",
      "cuisine_type": "台式",
      "rating": "3",
      "inout": ['外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55b9390f40b5e303a1d56637-%E5%BE%AE%E7%AC%91%E7%A2%B3%E7%83%A4"
    },
    {
      "id": "922",
      "name": "寒舍茶坊",
      "address": "臺北市文山區指南路三段40巷6號",
      "lng.": "121.597309",
      "lat.": "24.96743",
      "time": "09:00-22:00",
      "cuisine_type": "台式",
      "rating": "4.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55b935da40b5e303a1d5658f-%E5%AF%92%E8%88%8D%E8%8C%B6%E5%9D%8A"
    },
    {
      "id": "923",
      "name": "新味珍海產店",
      "address": "臺北市文山區興隆路三段27號旁邊",
      "lng.": "121.5554642",
      "lat.": "25.0007207",
      "time": "00:00-00:45, 17:30-00:00",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a582e8c03a10241de66c93-%E6%96%B0%E5%91%B3%E7%8F%8D%E6%B5%B7%E7%94%A2%E5%BA%97"
    },
    {
      "id": "924",
      "name": "金鮨日式料理",
      "address": "臺北市文山區指南路二段205號",
      "lng.": "121.578674",
      "lat.": "24.9869622",
      "time": "11:00-15:00, 17:00-20:30",
      "cuisine_type": "日式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d2cfbc03a103ee86c4ac4-%E9%87%91%E9%AE%A8%E6%97%A5%E5%BC%8F%E6%96%99%E7%90%86"
    },
    {
      "id": "925",
      "name": "四川飯館",
      "address": "臺北市文山區指南路二段65號2樓",
      "lng.": "121.5747597",
      "lat.": "24.9879209",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4f747c03a10241de63c39-%E5%9B%9B%E5%B7%9D%E9%A3%AF%E9%A4%A8"
    },
    {
      "id": "926",
      "name": "王記手工水餃",
      "address": "臺北市文山區興隆路二段97號",
      "lng.": "121.5474476",
      "lat.": "24.9997246",
      "time": "10:00-18:00",
      "cuisine_type": "台式",
      "rating": "4.4",
      "inout": ['外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/55a6693ec03a104df53ca09f-%E7%8E%8B%E8%A8%98%E6%89%8B%E5%B7%A5%E6%B0%B4%E9%A4%83"
    },
    {
      "id": "927",
      "name": "東京小城",
      "address": "臺北市文山區指南路二段207號",
      "lng.": "121.5786804",
      "lat.": "24.9869282",
      "time": "11:00-14:00, 17:00-20:30",
      "cuisine_type": "日式",
      "rating": "3.5",
      "inout": ['內用', '外帶'],
      "price_segment": "ppp",
      "info":
          "https://ifoodie.tw/restaurant/559d01a7c03a103ee86c32a8-%E6%9D%B1%E4%BA%AC%E5%B0%8F%E5%9F%8E"
    },
    {
      "id": "928",
      "name": "私房麵",
      "address": "臺北市文山區指南路二段2號",
      "lng.": "121.574073",
      "lat.": "24.987844",
      "time": "11:00-14:30, 17:00-20:30",
      "cuisine_type": "中式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a68201c03a104df53ca77b-%E7%A7%81%E6%88%BF%E9%BA%B5"
    },
    {
      "id": "929",
      "name": "越南大食館",
      "address": "臺北市文山區保儀路86號",
      "lng.": "121.568308",
      "lat.": "24.9871",
      "time": "09:00-20:00",
      "cuisine_type": "東南亞",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "p",
      "info":
          "https://ifoodie.tw/restaurant/559de39bc03a103ee86cbb57-%E8%B6%8A%E5%8D%97%E5%A4%A7%E9%A3%9F%E9%A4%A8"
    },
    {
      "id": "930",
      "name": "宣德炭燒羊肉爐",
      "address": "臺北市文山區景隆街40號",
      "lng.": "121.543845",
      "lat.": "24.998626",
      "time": "16:00-00:00",
      "cuisine_type": "中式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55b9495940b5e303a1d56982-%E5%AE%A3%E5%BE%B7%E7%82%AD%E7%87%92%E7%BE%8A%E8%82%89%E7%88%90"
    },
    {
      "id": "931",
      "name": "鳳臨食養天地",
      "address": "臺北市文山區老泉街26巷27號",
      "lng.": "121.5678809",
      "lat.": "24.9711676",
      "time": "11:30-14:30, 17:30-20:30",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": "內用|",
      "price_segment": "pppp",
      "info":
          "https://ifoodie.tw/restaurant/559d1b03c03a103ee86c3f20-%E9%B3%B3%E8%87%A8%E9%A3%9F%E9%A4%8A%E5%A4%A9%E5%9C%B0"
    },
    {
      "id": "932",
      "name": "shabu鮮涮涮鍋",
      "address": "臺北市文山區萬壽路23號",
      "lng.": "121.5761296",
      "lat.": "24.9882596",
      "cuisine_type": "日式",
      "rating": "3.5",
      "inout": ['內用'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f572a8d2756dd155d8e599e-shabu%E9%AE%AE%E6%B6%AE%E6%B6%AE%E9%8D%8B"
    },
    {
      "id": "933",
      "name": "齊味餃子館",
      "address": "臺北市文山區景華街178號",
      "lng.": "121.5480155",
      "lat.": "24.9973242",
      "time": "11:30-14:00, 17:30-20:30",
      "cuisine_type": "台式",
      "rating": "3.9",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559d5919c03a103ee86c678f-%E9%BD%8A%E5%91%B3%E9%A4%83%E5%AD%90%E9%A4%A8"
    },
    {
      "id": "934",
      "name": "福利餐廳",
      "address": "臺北市文山區興隆路一段167號",
      "lng.": "121.5427523",
      "lat.": "25.0014613",
      "time": "11:00-14:00, 17:00-21:00",
      "cuisine_type": "中式",
      "rating": "4.1",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4f78bc03a10241de63c51-%E7%A6%8F%E5%88%A9%E9%A4%90%E5%BB%B3"
    },
    {
      "id": "935",
      "name": "迺妙茶廬",
      "address": "臺北市文山區指南路三段34巷53號",
      "lng.": "121.5832996",
      "lat.": "24.9657734",
      "time": "09:00-22:00",
      "cuisine_type": "中式",
      "rating": "4.3",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/559dbe51c03a103ee86ca3d6-%E8%BF%BA%E5%A6%99%E8%8C%B6%E5%BB%AC"
    },
    {
      "id": "936",
      "name": "錢都涮涮鍋",
      "address": "臺北市文山區羅斯福路六段26號",
      "lng.": "121.539486",
      "lat.": "24.999876",
      "time": "11:00-22:30",
      "cuisine_type": "日式",
      "rating": "3.8",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/565624882756dd1d7a1b04e8-%E9%8C%A2%E9%83%BD%E6%B6%AE%E6%B6%AE%E9%8D%8B"
    },
    {
      "id": "937",
      "name": "吉野家",
      "address": "臺北市文山區景文街99號",
      "lng.": "121.541355",
      "lat.": "24.9908479",
      "time": "00:00-04:00, 05:00-00:00",
      "cuisine_type": "日式",
      "rating": "3.4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a4f528c03a10241de63b90-%E5%90%89%E9%87%8E%E5%AE%B6"
    },
    {
      "id": "938",
      "name": "西貢越南美食",
      "address": "臺北市文山區興隆路三段36巷14弄2號",
      "lng.": "121.5551436",
      "lat.": "24.999905",
      "time": "11:00-14:00, 17:00-20:00",
      "cuisine_type": "東南亞",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/55a684f6c03a104df53ca844-%E8%A5%BF%E8%B2%A2%E8%B6%8A%E5%8D%97%E7%BE%8E%E9%A3%9F"
    },
    {
      "id": "939",
      "name": "好菜場生猛海鮮",
      "address": "臺北市文山區興隆路一段225號",
      "lng.": "121.543797",
      "lat.": "25.00017",
      "time": "00:00-02:00, 16:00-00:00",
      "cuisine_type": "台式",
      "rating": "4",
      "inout": ['內用', '外帶'],
      "price_segment": "pp",
      "info":
          "https://ifoodie.tw/restaurant/5f5f6a7fd6895d2531ea2b24-%E5%A5%BD%E8%8F%9C%E5%A0%B4%E7%94%9F%E7%8C%9B%E6%B5%B7%E9%AE%AE"
    }
  ];
*/
  Widget buildContainer(
      BuildContext context, String title, String description) {
    return Container(
      child: Text(
        '$title： $description',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      padding: EdgeInsets.all(10),
    );
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  Future<void> addRestaurant(Map resData) {
    CollectionReference restaurants =
        FirebaseFirestore.instance.collection('restaurants');
    return restaurants.doc(resData['id']).set({
      "id": resData['id'],
      "name": resData['name'],
      "address": resData['address'],
      "lng": double.parse(resData['lng.']),
      "lat": double.parse(resData['lat.']),
      "rating": double.parse(resData['rating']),
      "price_segment": resData['price_segment'],
      "info": resData['info'],
      "cuisine_type": resData['cuisine_type'],
      "inout": resData['inout'],
    }).catchError((error) => print("Failed to add user: $error"));
  }

  var _user_data = [
    {
      'userEmail': '001@gmail.com',
      'userGroup': 'user-initiated',
      'userName': '001',
      'userPreference': [
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        1,
        0,
        1,
        1
      ],
      'userIntentionFactorSets': [
        {
          'userIntentionFactorSetContext': 'goodweekdayday',
          'userIntentionFactorSetName': 'set1',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekdaynight',
          'userIntentionFactorSetName': 'set2',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekendday',
          'userIntentionFactorSetName': 'set3',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekendnight',
          'userIntentionFactorSetName': 'set4',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekdayday',
          'userIntentionFactorSetName': 'set5',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekdaynight',
          'userIntentionFactorSetName': 'set6',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekendday',
          'userIntentionFactorSetName': 'set7',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekendnight',
          'userIntentionFactorSetName': 'set8',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
      ],
    },
    {
      'userEmail': '002@gmail.com',
      'userGroup': 'system-initiated',
      'userName': '002',
      'userPreference': [
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        1,
        0,
        0,
        1
      ],
      'userIntentionFactorSets': [
        {
          'userIntentionFactorSetContext': 'goodweekdayday',
          'userIntentionFactorSetName': 'set1',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekdaynight',
          'userIntentionFactorSetName': 'set2',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekendday',
          'userIntentionFactorSetName': 'set3',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekendnight',
          'userIntentionFactorSetName': 'set4',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekdayday',
          'userIntentionFactorSetName': 'set5',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekdaynight',
          'userIntentionFactorSetName': 'set6',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekendday',
          'userIntentionFactorSetName': 'set7',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekendnight',
          'userIntentionFactorSetName': 'set8',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
      ],
    },
    {
      'userEmail': '003@gmail.com',
      'userGroup': 'mix-initiated',
      'userName': '003',
      'userPreference': [
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        1,
        0
      ],
      'userIntentionFactorSets': [
        {
          'userIntentionFactorSetContext': 'goodweekdayday',
          'userIntentionFactorSetName': 'set1',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekdaynight',
          'userIntentionFactorSetName': 'set2',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekendday',
          'userIntentionFactorSetName': 'set3',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekendnight',
          'userIntentionFactorSetName': 'set4',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekdayday',
          'userIntentionFactorSetName': 'set5',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekdaynight',
          'userIntentionFactorSetName': 'set6',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekendday',
          'userIntentionFactorSetName': 'set7',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekendnight',
          'userIntentionFactorSetName': 'set8',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
      ],
    },
    {
      'userEmail': '004@gmail.com',
      'userGroup': 'no-personalization',
      'userName': '004',
      'userPreference': [
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ],
      'userIntentionFactorSets': [
        {
          'userIntentionFactorSetContext': 'goodweekdayday',
          'userIntentionFactorSetName': 'set1',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekdaynight',
          'userIntentionFactorSetName': 'set2',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekendday',
          'userIntentionFactorSetName': 'set3',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'goodweekendnight',
          'userIntentionFactorSetName': 'set4',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekdayday',
          'userIntentionFactorSetName': 'set5',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekdaynight',
          'userIntentionFactorSetName': 'set6',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekendday',
          'userIntentionFactorSetName': 'set7',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
        {
          'userIntentionFactorSetContext': 'badweekendnight',
          'userIntentionFactorSetName': 'set8',
          'intentionFactors': [
            {
              'intentionFactorName': '服務',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '均消',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '時間',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '距離',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
            {
              'intentionFactorName': '評分',
              'intentionFactorStatus': true,
              'intentionFactorSelectedOption': '不考慮',
            },
          ]
        },
      ],
    },
  ];

  Future<void> addUsers(Map userData) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.doc(userData['userEmail']).set({
      'userEmail': userData['userEmail'],
      'userGroup': userData['userGroup'],
      'userName': userData['userName'],
      'userPreference': userData['userPreference'],
      'userIntentionFactorSets': [
        {
          'userIntentionFactorSetContext': userData['userIntentionFactorSets']
              [0]['userIntentionFactorSetContext'],
          'userIntentionFactorSetName': userData['userIntentionFactorSets'][0]
              ['userIntentionFactorSetName'],
          'intentionFactors': [
            {
              'intentionFactorName': userData['userIntentionFactorSets'][0]
                  ['intentionFactors'][0]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][0]
                  ['intentionFactors'][0]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][0]['intentionFactors'][0]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][0]
                  ['intentionFactors'][1]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][0]
                  ['intentionFactors'][1]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][0]['intentionFactors'][1]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][0]
                  ['intentionFactors'][2]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][0]
                  ['intentionFactors'][2]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][0]['intentionFactors'][2]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][0]
                  ['intentionFactors'][3]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][0]
                  ['intentionFactors'][3]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][0]['intentionFactors'][3]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][0]
                  ['intentionFactors'][4]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][0]
                  ['intentionFactors'][4]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][0]['intentionFactors'][4]
                      ['intentionFactorSelectedOption'],
            }
          ],
        },
        {
          'userIntentionFactorSetContext': userData['userIntentionFactorSets']
              [1]['userIntentionFactorSetContext'],
          'userIntentionFactorSetName': userData['userIntentionFactorSets'][1]
              ['userIntentionFactorSetName'],
          'intentionFactors': [
            {
              'intentionFactorName': userData['userIntentionFactorSets'][1]
                  ['intentionFactors'][0]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][1]
                  ['intentionFactors'][0]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][1]['intentionFactors'][0]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][1]
                  ['intentionFactors'][1]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][1]
                  ['intentionFactors'][1]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][1]['intentionFactors'][1]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][1]
                  ['intentionFactors'][2]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][1]
                  ['intentionFactors'][2]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][1]['intentionFactors'][2]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][1]
                  ['intentionFactors'][3]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][1]
                  ['intentionFactors'][3]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][1]['intentionFactors'][3]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][1]
                  ['intentionFactors'][4]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][1]
                  ['intentionFactors'][4]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][1]['intentionFactors'][4]
                      ['intentionFactorSelectedOption'],
            }
          ],
        },
        {
          'userIntentionFactorSetContext': userData['userIntentionFactorSets']
              [2]['userIntentionFactorSetContext'],
          'userIntentionFactorSetName': userData['userIntentionFactorSets'][2]
              ['userIntentionFactorSetName'],
          'intentionFactors': [
            {
              'intentionFactorName': userData['userIntentionFactorSets'][2]
                  ['intentionFactors'][0]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][2]
                  ['intentionFactors'][0]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][2]['intentionFactors'][0]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][2]
                  ['intentionFactors'][1]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][2]
                  ['intentionFactors'][1]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][2]['intentionFactors'][1]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][2]
                  ['intentionFactors'][2]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][2]
                  ['intentionFactors'][2]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][2]['intentionFactors'][2]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][2]
                  ['intentionFactors'][3]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][2]
                  ['intentionFactors'][3]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][2]['intentionFactors'][3]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][2]
                  ['intentionFactors'][4]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][2]
                  ['intentionFactors'][4]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][2]['intentionFactors'][4]
                      ['intentionFactorSelectedOption'],
            }
          ],
        },
        {
          'userIntentionFactorSetContext': userData['userIntentionFactorSets']
              [3]['userIntentionFactorSetContext'],
          'userIntentionFactorSetName': userData['userIntentionFactorSets'][3]
              ['userIntentionFactorSetName'],
          'intentionFactors': [
            {
              'intentionFactorName': userData['userIntentionFactorSets'][3]
                  ['intentionFactors'][0]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][3]
                  ['intentionFactors'][0]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][3]['intentionFactors'][0]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][3]
                  ['intentionFactors'][1]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][3]
                  ['intentionFactors'][1]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][3]['intentionFactors'][1]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][3]
                  ['intentionFactors'][2]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][3]
                  ['intentionFactors'][2]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][3]['intentionFactors'][2]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][3]
                  ['intentionFactors'][3]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][3]
                  ['intentionFactors'][3]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][3]['intentionFactors'][3]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][3]
                  ['intentionFactors'][4]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][3]
                  ['intentionFactors'][4]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][3]['intentionFactors'][4]
                      ['intentionFactorSelectedOption'],
            }
          ],
        },
        {
          'userIntentionFactorSetContext': userData['userIntentionFactorSets']
              [4]['userIntentionFactorSetContext'],
          'userIntentionFactorSetName': userData['userIntentionFactorSets'][4]
              ['userIntentionFactorSetName'],
          'intentionFactors': [
            {
              'intentionFactorName': userData['userIntentionFactorSets'][4]
                  ['intentionFactors'][0]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][4]
                  ['intentionFactors'][0]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][4]['intentionFactors'][0]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][4]
                  ['intentionFactors'][1]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][4]
                  ['intentionFactors'][1]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][4]['intentionFactors'][1]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][4]
                  ['intentionFactors'][2]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][4]
                  ['intentionFactors'][2]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][4]['intentionFactors'][2]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][4]
                  ['intentionFactors'][3]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][4]
                  ['intentionFactors'][3]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][4]['intentionFactors'][3]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][4]
                  ['intentionFactors'][4]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][4]
                  ['intentionFactors'][4]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][4]['intentionFactors'][4]
                      ['intentionFactorSelectedOption'],
            }
          ],
        },
        {
          'userIntentionFactorSetContext': userData['userIntentionFactorSets']
              [5]['userIntentionFactorSetContext'],
          'userIntentionFactorSetName': userData['userIntentionFactorSets'][5]
              ['userIntentionFactorSetName'],
          'intentionFactors': [
            {
              'intentionFactorName': userData['userIntentionFactorSets'][5]
                  ['intentionFactors'][0]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][5]
                  ['intentionFactors'][0]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][5]['intentionFactors'][0]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][5]
                  ['intentionFactors'][1]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][5]
                  ['intentionFactors'][1]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][5]['intentionFactors'][1]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][5]
                  ['intentionFactors'][2]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][5]
                  ['intentionFactors'][2]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][5]['intentionFactors'][2]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][5]
                  ['intentionFactors'][3]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][5]
                  ['intentionFactors'][3]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][5]['intentionFactors'][3]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][5]
                  ['intentionFactors'][4]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][5]
                  ['intentionFactors'][4]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][5]['intentionFactors'][4]
                      ['intentionFactorSelectedOption'],
            }
          ],
        },
        {
          'userIntentionFactorSetContext': userData['userIntentionFactorSets']
              [6]['userIntentionFactorSetContext'],
          'userIntentionFactorSetName': userData['userIntentionFactorSets'][6]
              ['userIntentionFactorSetName'],
          'intentionFactors': [
            {
              'intentionFactorName': userData['userIntentionFactorSets'][6]
                  ['intentionFactors'][0]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][6]
                  ['intentionFactors'][0]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][6]['intentionFactors'][0]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][6]
                  ['intentionFactors'][1]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][6]
                  ['intentionFactors'][1]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][6]['intentionFactors'][1]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][6]
                  ['intentionFactors'][2]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][6]
                  ['intentionFactors'][2]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][6]['intentionFactors'][2]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][6]
                  ['intentionFactors'][3]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][6]
                  ['intentionFactors'][3]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][6]['intentionFactors'][3]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][6]
                  ['intentionFactors'][4]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][6]
                  ['intentionFactors'][4]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][6]['intentionFactors'][4]
                      ['intentionFactorSelectedOption'],
            }
          ],
        },
        {
          'userIntentionFactorSetContext': userData['userIntentionFactorSets']
              [7]['userIntentionFactorSetContext'],
          'userIntentionFactorSetName': userData['userIntentionFactorSets'][7]
              ['userIntentionFactorSetName'],
          'intentionFactors': [
            {
              'intentionFactorName': userData['userIntentionFactorSets'][7]
                  ['intentionFactors'][0]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][7]
                  ['intentionFactors'][0]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][7]['intentionFactors'][0]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][7]
                  ['intentionFactors'][1]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][7]
                  ['intentionFactors'][1]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][7]['intentionFactors'][1]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][7]
                  ['intentionFactors'][2]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][7]
                  ['intentionFactors'][2]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][7]['intentionFactors'][2]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][7]
                  ['intentionFactors'][3]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][7]
                  ['intentionFactors'][3]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][7]['intentionFactors'][3]
                      ['intentionFactorSelectedOption'],
            },
            {
              'intentionFactorName': userData['userIntentionFactorSets'][7]
                  ['intentionFactors'][4]['intentionFactorName'],
              'intentionFactorStatus': userData['userIntentionFactorSets'][7]
                  ['intentionFactors'][4]['intentionFactorStatus'],
              'intentionFactorSelectedOption':
                  userData['userIntentionFactorSets'][7]['intentionFactors'][4]
                      ['intentionFactorSelectedOption'],
            }
          ],
        },
      ]
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Login>(
      builder: (context, login, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildContainer(
                context,
                '使用者intention factor set name',
                login.userData['userIntentionFactorSets'][0]
                    ['userIntentionFactorSetName']),
            buildContainer(
              context,
              '使用者intention factor set context',
              login.currentContext,
            ),
            buildContainer(context, '使用者姓名', login.userData['userName']),
            buildContainer(context, '使用者電子郵件', login.userData['userEmail']),
            buildContainer(context, '使用者組別', login.userData['userGroup']),
            TextButton(
              onPressed: () {
                logout();
              },
              child: Text('logout'),
            ),
            // TextButton(
            //   onPressed: () {
            //     if (mounted) {
            //       // await Firebase.initializeApp();
            //       // for (var i = 0; i < 650; i++) {
            //       //   addRestaurant(_restaurants_data1[i]);
            //       //   print(_restaurants_data1[i]['name']);
            //       // }
            //       var restaurantCount = (_restaurants_data1 == null)
            //           ? 0
            //           : _restaurants_data1.length;
            //       // setState(() {
            //       for (int i = 0; i < restaurantCount; i++) {
            //         addRestaurant(_restaurants_data1[i]);
            //         print(_restaurants_data1[i]['name']);
            //       }
            //       // });
            //     }
            //   },
            //   child: Text('upload data'),
            // ),
            // TextButton(
            //   onPressed: () async {
            //     await Firebase.initializeApp();
            //     for (var i = 0; i <= _user_data.length; i++) {
            //       addUsers(_user_data[i]);
            //       print(_user_data[i]['userEmail']);
            //     }
            //   },
            //   child: Text('upload fake user data'),
            // ),
          ],
        );
      },
    );
  }
}
