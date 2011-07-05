narcissus = require 'narcissus'
tokens = narcissus.definitions.tokens

if window?
    jsinliner = window.jsinliner = {}
    coffee = if CoffeeScript? then CoffeeScript else null
else 
    jsinliner = exports
    coffee = require 'coffee-script'

printIf = (node, num) ->
    {condition: condition,
    thenPart: thenPart,
    elsePart: elsePart} = node
    s = spaces num

    console.log "#{s}if ["
    condition = printChild condition, num+1
    console.log "#{s}] then ["
    thenPart = printChild thenPart, num+1
    console.log "#{s}] else ["
    elsePart = printChild elsePart, num+1
    console.log "#{s}]"


spaces = (num) ->
    (' ' for n in [0..num]).join('')

printSpaced = (str, num) ->
    s = spaces num
    console.log "#{s}#{str}"

printNode = (node, num) ->
    {value: name, children: [statements...]} = node
    printSpaced name, num
    printChild n, num+1 for n in statements
    
printAssign = (node, num) ->
    {children: [statements...]} = node
    printSpaced '==', num
    printChild n, num+1 for n in statements
    
printInit = (node, num) ->
    {children: [{name: name, initializer: initializer}] } = node
    printSpaced name, num
    printChild initializer, num + 1

printChild = (node, num) ->
    switch tokens[node.type]
        when "var" then printInit node, num
        when "if" then printIf node, num
        when "==" then printAssign node, num
        else printNode node, num

print = (node, num) ->
    {children: [children...]} = node
    console.log 'parent'
    (printChild child, num+1 for child in children)

jsinliner.inline = (code) ->
    {children: [statements...]} = node = narcissus.parser.parse code
    console.log statements[0]
    #print statements[1]
    #print node , 0

