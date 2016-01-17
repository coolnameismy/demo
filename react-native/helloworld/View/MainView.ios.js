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

var CellNav = require("./ex-layout.ios.js");
var cellItems = ['ex1','ex2','ex3','ex4'];
var cellItemsClicked = function(){
  alert("hello");
} 
// clicked={cellItemsClicked}


var MainView = React.createClass({
  render: function() {
    return (
        <View style={styles.main} >
          <CellNav title='酒店' items={cellItems} clicked={this.cellNavClicked}> </CellNav>
        </View>
      );
  },
  cellNavClicked:function(msg){
     alert(msg);
    // this.props.navigator.push({
    //   component:exLayoutView,
    //   title:"page1"
    // });
  },
 replace:function(){
    this.props.navigator.replace({
      component:exLayoutView,
      title:"page1"
    });
  }
});

//加载公共样式
const styles =  StyleSheet.create({
  main:{
    flex:1
  }
})

module.exports = MainView;
