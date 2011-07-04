exec = require('child_process').exec

task 'clean', ->
    exec 'rm lib/*.js test/*.js'

task 'build', ->
    exec 'coffee -o lib -c src/*.coffee', (err) ->
        console.log err if err

task 'test', -> 
    exec 'coffee -o test -c test/*.coffee', (err) ->
        console.log err if err
        
        require.paths.push __dirname
        require.paths.push (__dirname + '/deps')
        require.paths.push (__dirname + '/lib')

        testrunner = (require 'nodeunit').reporters.default
        
        process.chdir __dirname
        testrunner.run ['test']
