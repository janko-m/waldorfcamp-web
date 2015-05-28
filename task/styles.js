var gulp = require('gulp');
var $ = require('gulp-load-plugins')();

var browserSync = require('browser-sync');
var processors = [
  require('autoprefixer-core')
];

gulp.task('styles', function () {
  return gulp.src('app/styles/**/*.scss')
    .pipe($.sass()).on('error', $.sass.logError)
    .pipe($.postcss(processors))
    .pipe(gulp.dest('.tmp/styles'))
    .pipe(browserSync.reload({stream: true}));
});
