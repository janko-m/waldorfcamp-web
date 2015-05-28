var gulp = require('gulp');
var browserSync = require('browser-sync');

gulp.task('connect', ['views', 'scripts', 'styles'], function (done) {
  browserSync({
    notify: false,
    port: 9000,
    open: false,
    server: {
      baseDir: ['.tmp', 'app']
    }
  }, done);
});

gulp.task('watch', ['connect'], function () {
  gulp.watch([
    'app/images/**/*'
  ]).on('change', browserSync.reload);

  gulp.watch('app/styles/**/*.scss', ['styles']);
  gulp.watch('app/**/*.{html,md}', ['views']);
});

gulp.task('serve', ['connect', 'watch']);
