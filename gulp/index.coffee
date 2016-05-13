require './tasks/'
gulp = require 'gulp'

gulp.task 'default', gulp.series 'dist'
