var gulp = require('gulp');
var $ = require('gulp-load-plugins')();

var browserSync = require('browser-sync');

var browserify = require('browserify');
var watchify = require('watchify');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');

var b = browserify({
  entries: ['./app/scripts/app.jsx'],
  extensions: ['.jsx'],
  debug: true
}, watchify.args);

if (process.env.GULP_ENV !== 'prod') {
  var b = watchify(b);
}

var bundle = function () {
  return b.bundle()
    .on('error', $.util.log.bind($.util, 'Browserify Error'))
    .pipe(source('bundle.js'))
    .pipe(buffer())
    .pipe($.sourcemaps.init({loadMaps: true}))
    .pipe($.sourcemaps.write('./'))
    .pipe(gulp.dest('.tmp/scripts'))
    .pipe(browserSync.reload({stream: true, once: true}));
};

gulp.task('scripts', bundle);
b.on('update', bundle);
b.on('log', $.util.log);

gulp.task('jshint', function () {
  return gulp.src('app/scripts/**/*.js')
    .pipe($.jshint())
    .pipe($.jshint.reporter('jshint-stylish'))
    .pipe($.jshint.reporter('fail'));
});
