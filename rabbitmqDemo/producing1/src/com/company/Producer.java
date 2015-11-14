package com.company;


import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

import java.io.IOException;
import java.util.concurrent.TimeoutException;


/**
 * Created by zteliuyw on 15/7/6.
 */
public class Producer {

    //队列名称
    private final static String QUEUE_NAME = "hello";

    //生成数据到mq
    public void sendMsg(String msg) {

        /**
         * 创建连接连接到MabbitMQ
         */

        try {
            ConnectionFactory factory = new ConnectionFactory();
            //设置MabbitMQ所在主机ip或者主机名
            factory.setHost("localhost");
            //创建一个连接
            Connection  connection = factory.newConnection();
            //创建一个频道
            Channel  channel = connection.createChannel();
            //指定一个队列
            channel.queueDeclare(QUEUE_NAME, false, false, false, null);

            //往队列中发出一条消息
            channel.basicPublish("", QUEUE_NAME, null, msg.getBytes());
            System.out.println(" [x] Sent '" + msg + "'");
            //关闭频道和连接
            channel.close();
            connection.close();
        } catch (TimeoutException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }
}
