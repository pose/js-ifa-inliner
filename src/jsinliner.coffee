if window?
    jsinliner = window.jsinliner = {}
    coffee = if CoffeeScript? then CoffeeScript else null
else 
    jsinliner = exports
    coffee = require 'coffee-script'

narcissus = require 'narcissus'
narcissus.parse "function () {}"
