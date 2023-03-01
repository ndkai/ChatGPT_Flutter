import 'package:flutter/material.dart';

 String userApi = "https://phuquoc-user-api.bakco.vn";
 String scheduleApi = "https://phuquoc-schedule-api.bakco.vn  ";
 String bookingApi = "https://phuquoc-booking-api.bakco.vn";

const kPrimaryColor = Colors.black87;             
const kPrimaryLightColor = Color(0xFFF1E6FF);
const String SERVER_FAILURE_MESSAGE = 'Có lỗi xảy ra, vui lòng thử lại!';
const String NETWORK_FAILURE_MESSAGE = 'Vui lòng kiểm tra kết nối mạng!';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String LOGIN_SAVE = 'LOGIN_SAVE';
const String TIME_EXPIRE = 'TIME_EXPIRE';
const String CHAT_DATA = 'CHAT_DATA';

const Map<int, String> dayInWeek = {
  1: "Mon",
  2: "Tue",
  3: "Wed",
  4: "Thu",
  5: "Fri",
  6: "Sat",
  7: "Sun",
};

const Map<int, String> dayInWeekVN = {
  1: "Thứ 2",
  2: "Thứ 3",
  3: "Thứ 4",
  4: "Thứ 5",
  5: "Thứ 6",
  6: "Thứ 7",
  7: "Chủ nhật",
};

const Map<int, String> dayInWeekVN2 = {
  1: "T2",
  2: "T3",
  3: "T4",
  4: "T5",
  5: "T6",
  6: "T7",
  7: "CN",
};

