var gulp = require('gulp');
var $ = require('gulp-load-plugins')();

var browserSync = require('browser-sync');
var selenium = require('selenium-standalone');

gulp.task('connect:test', ['scripts', 'styles'], function (done) {
  browserSync({
    logLevel: 'silent',
    notify: false,
    open: false,
    port: 9000,
    server: {
      baseDir: ['test/fixtures', '.tmp', 'app']
    },
    ui: false
  }, done);
});

gulp.task('selenium', function (done) {
  selenium.install({
    drivers: {},
    logger: function () { }
  }, function (err) {
    if (err) return done(err);
    selenium.start({
      drivers: {}
    }, function (err, child) {
      if (err) return done(err);
      if (process.env.TRAVIS) {
        child.stderr.on('data', function(data){
          console.log(data.toString());
        });
      }
      selenium.child = child;
      done();
    });
  });
});

gulp.task('integration', ['connect:test', 'selenium'], function () {
  return gulp.src('test/spec/**/*.js', {read: false})
    .pipe($.mocha({timeout: 10000}))
    .once('error', function () {
      process.env.MOCHA_ERR = 1;
    })
    .once('end', function () {
      if (process.env.MOCHA_ERR) {
        process.exit(1);
      }
    });
});

gulp.task('test', ['integration'], function () {
  require('../test/client').end();
  selenium.child.kill();
  browserSync.exit();
});
