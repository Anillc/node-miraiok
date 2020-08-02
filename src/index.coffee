{ program } = require 'commander'

update = require './update.coffee'
run = require './run.coffee'

program.command 'update'
  .action update

program.action run

program.parse process.argv
