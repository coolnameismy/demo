/* @flow */
'use strict';

var React = require('react-native');

var {
  StyleSheet,
  View,
  Text,
  TouchableWithoutFeedback,
  TouchableOpacity,
  TouchableHighlight,
  Dimensions,
} = React;

var ComponentLifecycleView = require("./ComponentLifecycleView.ios.js");
var JsxSyntaxView = require("./JsxSyntaxView.js");
var CellNav = require("./ex-layout.ios.js"); 
var CallNativeModuleView = require("./CallNativeModuleView.js"); 

var cellItems = ['组件生命周期','jsx语法','调用原生模块','ex4'];

console.log(Dimensions.get("window"));


var MainView = React.createClass({
  render: function() {
    return (
        <View style={styles.main} >
          <CellNav title='sect1' items={cellItems} clicked={this.cellNavClicked}> </CellNav>
        </View>
      );
  },
  cellNavClicked:function(item){
     // alert(item);
     switch(item){
      case '组件生命周期' :  this.goto(ComponentLifecycleView,item);
      case 'jsx语法' :  this.goto(JsxSyntaxView,item);
      case '调用原生模块' :  this.goto(CallNativeModuleView,item);
      break;
     }
  },
  goto:function(view,title){
    this.props.navigator.push({
      component:view,
      title:title
    });
  },
});

//加载公共样式
const styles =  StyleSheet.create({
  main:{
    flex:1
  }
})

module.exports = MainView;
