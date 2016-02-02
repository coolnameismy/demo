
var app = require('./Ranger.js')();

//router设置
// router
//   .get('/', function *(next) {
//     this.body = 'Hello World!';
//   })
//   .get('/users', function *(next) {
//     this.body = 'Hello users!';
//   })
//   .post('/users', function *(next) {
//     // ...
//     this.body = 'users';
//   });

// app
//   .use(router.routes())

app.listen(8001);



 