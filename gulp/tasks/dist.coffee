gulp = require 'gulp'

gulp.task 'dist', gulp.series('clean', 'build')
