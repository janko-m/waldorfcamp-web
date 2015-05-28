var gulp = require('gulp');
var $ = require('gulp-load-plugins')();

var browserSync = require('browser-sync');

gulp.task('views', function () {
  return gulp.src('app/views/**/*.{html,md}')
    .pipe($.frontMatter({property: 'data'}))
    .pipe($.if('*.md', $.markdown({smartypants: true})))
    .pipe($.wrap({src: 'app/layouts/default.html'}))
    .pipe($.rename(function (path) {
      if (path.basename !== 'index') {
        path.dirname += '/' + path.basename;
        path.basename = 'index';
      }
    }))
    .pipe(gulp.dest('.tmp'))
    .pipe(browserSync.reload({stream: true, once: true}));
});
