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
} = React;


var cellItems = ['组件生命周期','jsx语法','ex3','ex4'];
var ComponentLifecycleView = require("./ComponentLifecycleView.ios.js");
var JsxSyntaxView = require("./JsxSyntaxView.js");
var CellNav = require("./ex-layout.ios.js"); 



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
      case '组件生命周期' :  this.goto(ComponentLifecycleView);
      case 'jsx语法' :  this.goto(JsxSyntaxView);
      break;
     }
  },
  goto:function(view){
    this.props.navigator.push({
      component:view,
      title:"page1"
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
