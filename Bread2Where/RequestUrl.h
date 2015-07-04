//
//  RequestUrl.h
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#ifndef Bread2Where_RequestUrl_h
#define Bread2Where_RequestUrl_h
#ifdef __OBJC__

#define HOT_URL @"http://api.breadtrip.com/trips/hot/?start=0&count=20&is_ipad=true"

#define TRIP_URL @"http://api.breadtrip.com/trips/hot/?start=%ld&count=20&is_ipad=true"

#define DES_URL @"http://api.breadtrip.com/destination/v3/"

//全部
#define ALL_URL @"http://api.breadtrip.com/place/pois/nearby/?category=0&start=%d&count=20&latitude=%f&longitude=%f"

//目的地景点
#define SCENE_URL @"http://api.breadtrip.com/place/pois/nearby/?category=11&start=%d&count=20&latitude=%f&longitude=%f"
//餐厅
#define RES_URL @"http://api.breadtrip.com/place/pois/nearby/?category=5&start=%d&count=20&latitude=%f&longitude=%f"

//购物
#define SHOP_URL @"http://api.breadtrip.com/place/pois/nearby/?category=6&start=%d&count=20&latitude=%f&longitude=%f"

//hotal 住宿
#define HOTAL_URL @"http://api.breadtrip.com/place/pois/nearby/?category=10&start=%d&count=20&latitude=%f&longitude=%f"

//休闲娱乐
#define ENTER_URL @"http://api.breadtrip.com/place/pois/nearby/?category=21&start=%d&count=20&latitude=%f&longitude=%f"

//特价
#define TP_URL @"http://breadtrip.com/tp/products/?category=&dest=&start=&depart=&page=%d"

//欧洲国家
#define EUROPE_URL @"http://api.breadtrip.com/destination/index_places/3/"

//亚洲国家
#define ASIA_URL @"http://api.breadtrip.com/destination/index_places/6/"

//国内城市
#define CHINA_URL @"http://api.breadtrip.com/destination/index_places/8/"

/**特价*/
#define SPECIALPRICE @"http://breadtrip.com/tp/products/?category=&dest=&start=&depart=&page=%d"

#define SHOUYECELLDETAIL @"http://api.breadtrip.com/trips/%@/waypoints/"
//http://api.breadtrip.com/trips/2386609885/waypoints
#define DES_DETAIL_URL @"http://api.breadtrip.com/destination/place/%@/%@"

/*不可错过*/
#define BKCG_URL @"http://breadtrip.com/mobile/destination/%@/%@/intro/"

/**专题*/
#define THEME_URL @"http://chanyouji.com/api/articles/%d.json"

//主题
#define SUBJECT_URL @"http://chanyouji.com/api/articles.json?page=%d"

//实用须知
#define SHOULD_KNOW @"http://breadtrip.com/mobile/destination/%@/%@/overview/"


#define TRAVEL_DAILY @"http://api.breadtrip.com/destination/place/%@/%@/trips/?start=0&count=%d"
#endif
#endif

