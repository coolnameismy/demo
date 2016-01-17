//联系rn中的flex布局，开发一个9宫格布局界面

/* @flow */
'use strict';

var React = require('react-native');

var {
  StyleSheet,
  View,
  Text,
  PixelRatio,
} = React;

var exLayoutView = React.createClass({
  render: function() {
    return (
       <View style={styles.main}>
         <View style={[styles.item,styles.center]}>
            <Text style={styles.font}>酒店</Text>
         </View>
	         
         <View style={[styles.item,styles.lineLeftRight]}>
           <View style={[styles.center,styles.flex,styles.lineCenter]}>
              <Text style={styles.font}>海外酒店</Text>
            </View>
            <View style={[styles.center,styles.flex]}>
               <Text style={styles.font}>特惠酒店</Text>
             </View>
         </View>

         <View style={styles.item}>
           <View style={[styles.center,styles.flex,styles.lineCenter]}>
              <Text style={styles.font}>团购</Text>
            </View>
            <View style={[styles.center,styles.flex]}>
               <Text style={styles.font}>酒店.客栈</Text>
             </View>
         </View>
       </View>

       // <Text style={styles.main} onPress={this.clicked}>
       //      I am page1 点击返回 
       //   </Text>
    );
  },
  clicked:function(){
  	this.props.navigator.pop();
  }

});


//加载公共样式
const styles = StyleSheet.create({
  main:{
    flexDirection:'row',
    marginTop:25,
    marginLeft:5,
    marginRight:5,
    borderRadius:5,
    backgroundColor:'#ff0067',
    height:84,
    padding:2,
  },
  item:{
    flex:1,
    height:80,
  },
  center:{
    justifyContent:'center',
    alignItems:'center',
  },
  flex:{
    flex:1,
  },
  lineLeftRight:{
    borderLeftWidth:1/PixelRatio.get(),
    borderRightWidth:1/PixelRatio.get(),
    borderColor:'#fff',
  },
  lineCenter:{
    borderBottomWidth:1/PixelRatio.get(),
    borderColor:'#fff',
  },
  font:{
    color:'#fff',
    fontSize:16,
    fontWeight:'bold',
  }
});

module.exports = exLayoutView;
