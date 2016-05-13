gulp = require 'gulp'
concat = require 'gulp-concat'
insert = require 'gulp-insert'
uglify = require 'gulp-uglify'
insert = require 'gulp-insert'
require './clean.coffee'
jf = require 'jsonfile'


pkgFn = () ->
  jf.readFileSync 'package.json' #always get latest!

header = () ->
  ourPackage = pkgFn()
  """
  /**
   *  #{ourPackage.name}
   *
   * @version: #{ourPackage.version}
   * @author: #{ourPackage.author}
   * @contributors: #{ourPackage.contributors.join(',')}
   * @date: #{(new Date()).toString()}
   * @license: #{ourPackage.license}
   */\n
  """

build = ({src, out}) ->
  gulp.src src
  .pipe insert.prepend(header())
  .pipe concat "#{out}.js"
  .pipe gulp.dest 'dist'
  .pipe uglify()
  .pipe insert.prepend(header())
  .pipe concat "#{out}.min.js"
  .pipe gulp.dest 'dist'

gulp.task 'build', () ->
  build
    src: 'src/*.js'
    out: pkgFn().main.replace(/\.\/dist\//, '').replace(/\.js/, '')
