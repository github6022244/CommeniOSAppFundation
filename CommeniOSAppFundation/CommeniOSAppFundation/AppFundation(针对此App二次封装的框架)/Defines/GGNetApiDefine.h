//
//  GGNetApiDefine.h
//  CXGLNewStudentApp
//
//  Created by GG on 2023/1/30.
//

#import <Foundation/Foundation.h>

#pragma mark -- 测试服务地址
#ifdef DEBUG

#define DOMAIN_URL          @"http://test01.changxianggu.com/"
#define BASE_URL            @"http://test01.changxianggu.com/app/"
#define REMOTE_URL          @"http://test01.changxianggu.com/cucapp/"
#define STUDENT_APPURL      @"http://test01.changxianggu.com/studentapp/"
#define NEWSTUDENT_APPURL   @"http://test01.changxianggu.com/newstudent/"
#define DIGITALPLATFORM_URL @"http://ebooktest.cxgdxjc.com/"
#define TEACHER_APPURL      @"http://test01.changxianggu.com/teacherapp/"
#define TEACHER_NEWAPPURL   @"http://test01.changxianggu.com/teacher/"
#define WEB_SOCKET_URL      @"ws://pb-test-api.changxianggu.com/v1.0/websocket/inbox/"
#define Infurance_Promote_Url @"http://test01.changxianggu.com/app/insure/activePage"
#define ActivityWebUrl      @"http://test01.changxianggu.com/app/v4.activityIndex/index?activity_id=4"
#define TextbookSelectListWebUrl  @"http://test01.changxianggu.com/app/bookList/getBookHtml"
#define ActivitySecondWebUrl    @"http://test01.changxianggu.com/app/v4.activityIndex/activitySchool?activity_id=5"
#define ActivitySecondMoreTextbokWebUrl   @"http://test01.changxianggu.com/app/v4.activityIndex/moreBook?activity_id=5"
#define ActivitySecondTeachingResultWebUrl @"http://test01.changxianggu.com/app/v4.activityIndex/schoolDetails"
#define ProductExperienceUrl @"http://test01.changxianggu.com/app/webView/recruit"

#else

#pragma mark -- 正式服务地址
#define DOMAIN_URL          @"http://cxgl.changxianggu.com/"
#define BASE_URL            @"http://cxgl.changxianggu.com/app/"
#define REMOTE_URL          @"http://cxgl.changxianggu.com/cucapp/"
#define STUDENT_APPURL      @"http://www.changxianggu.com/studentapp/"
#define NEWSTUDENT_APPURL   @"http://www.changxianggu.com/newstudent/"
#define DIGITALPLATFORM_URL @"https://ebook.changxianggu.com/"
#define TEACHER_APPURL      @"http://www.changxianggu.com/teacherapp/"
#define TEACHER_NEWAPPURL   @"http://www.changxianggu.com/teacher/"
#define WEB_SOCKET_URL      @"ws://pb-api.changxianggu.com/v1.0/websocket/inbox/"
#define Infurance_Promote_Url @"http://cxgl.changxianggu.com/app/insure/activePage"
#define ActivityWebUrl      @"http://cxgl.changxianggu.com/app/v4.activityIndex/index?activity_id=4"
#define TextbookSelectListWebUrl  @"http://cxgl.changxianggu.com/app/bookList/getBookHtml"
#define ActivitySecondWebUrl    @"http://cxgl.changxianggu.com/app/v4.activityIndex/activitySchool?activity_id=11"
#define ActivitySecondMoreTextbokWebUrl   @"http://cxgl.changxianggu.com/app/v4.activityIndex/moreBook?activity_id=11"
#define ActivitySecondTeachingResultWebUrl @"http://cxgl.changxianggu.com/app/v4.activityIndex/schoolDetails"
#define ProductExperienceUrl @"http://cxgl.changxianggu.com/app/webView/recruit"

#endif







#ifdef DEBUG
//#define CUSTOM_EVENT_TRACK_URL  @"http://pb-test-api.changxianggu.com"
#define CUSTOM_EVENT_TRACK_URL  @"https://pb-api.changxianggu.com"
#else
#define CUSTOM_EVENT_TRACK_URL  @"https://pb-api.changxianggu.com"
#endif
