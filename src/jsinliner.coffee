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

    condition = printChild condition, num+1
    thenPart = printChild thenPart, num+1
    elsePart = printChild elsePart, num+1

    console.log "#{s}if [#{condition}] then [#{thenPart}] else [#{elsePart}]"

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
    console.log num
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
    (printChild i, num+1 for i in children)

jsinliner.inline = (code) ->
    {children: [statements...]} = node = narcissus.parser.parse code
    #console.log node
    #print statements[1]
    print node , 0
