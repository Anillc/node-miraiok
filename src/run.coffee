{ spawn } = require 'child_process'
path = require 'path'
os = require 'os'
fs = require 'fs'
update = require './update.coffee'

suffix = if os.platform() == 'windows' then '.exe' else ''

module.exports = ->
  try
    if !fs.existsSync 'miraiok'
      await update()
    miraiok = spawn (path.resolve process.cwd(),
      "miraiok/miraiOK#{suffix}"), [],
        cwd: path.resolve process.cwd(), 'miraiok'
    miraiok.stdout.pipe process.stdout
    miraiok.stderr.pipe process.stderr
    process.stdin.pipe miraiok.stdin
  catch e
    console.log e

