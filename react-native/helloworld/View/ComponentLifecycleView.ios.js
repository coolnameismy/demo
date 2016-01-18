/* @flow */
'use strict';

var React = require('react-native');

var {
  StyleSheet,
  View,
  Text,
} = React;


var ComponentLifecycleView = React.createClass({
  
  //初始化数据
  getDefaultProps:function(){
  	return {
  		
  	}
  },
  //这个阶段用来设置state数据
  getInitialState:function(){
  	return {
        info:'请看: ComponentLifecycleView.ios.js 代码所示例的生命周期 ',
    };
  },

  //render方法之前
  componentWillMount:function(){
  	// this._log('componentWillMount');
  },

  //渲染虚拟dom
  render: function() {
    return (
      <View style={[styles.container,styles.center]}>
      	<Text style={styles.text}>{this.state.info}</Text>
      </View>
    );
  },

   //render方法之后
  componentDidMount:function(){
  	// this._log('componentDidMount');
  },

  //props修改
  componentWillReceiveProps:function(){

  },
  //是否需要更新
  shouldComponentUpdate:function(){
  	return true;
  },
  //将要更新
  componentWillUpdate:function(){

  },
  //更新完毕
  componentDidUpdate:function(){

  },
  //组件销毁
  componentWillUnmount:function(){

  }
});

var styles = StyleSheet.create({
	container:{
		flex:1,
		backgroundColor:'gray',
	},
	center:{
   	 	justifyContent:'center',
    	alignItems:'center',
  	},
  	text:{
  		color:'#fff',
  		fontSize:26,
  	}
});


module.exports = ComponentLifecycleView;
