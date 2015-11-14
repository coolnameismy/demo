package com.company;



import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.TimeoutException;

public class Main {

    public static void main(String[] args) {

        printMsgWithSeparate("main start");
        Producer producer = new Producer();
        String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());//设置日期格式
        producer.sendMsg("hello world "+ date);
    }


    public  static  void printMsg(String msg){

    }
    public  static  void printMsgWithSeparate(String msg){
        System.out.println(msg);
        System.out.println("========================================");
    }
}
