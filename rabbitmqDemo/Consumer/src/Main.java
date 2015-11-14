public class Main {

    public static void main(String[] args) {

        printMsgWithSeparate("main start");

        Consumer consumer = new Consumer();
        printMsgWithSeparate("consumer start listening");
        consumer.recvMsg();

        printMsgWithSeparate("end main");
    }


    public  static  void printMsg(String msg){

    }
    public  static  void printMsgWithSeparate(String msg){
        System.out.println(msg);
        System.out.println("========================================");
    }
}
