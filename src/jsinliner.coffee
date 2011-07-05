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

transIDENTIFIER = (node) ->
    if node.initializer #var x=5
        node.initializer=(trans node.initializer)[0]
    #else
    #    1
    #    #TODO: otros casos
    [node]

transVAR = (node) ->
    node.children=myMap trans, node.children
    [node]

transDEFAULT = (node) ->
    [node]

transFUNCTION = (node) ->
    [node]

transASSIGN = (node) ->
    [node]

transSCRIPT = (node) ->
    node.children=myMap trans, node.children
    [node]

myMap = (func,list) ->
    newlist=[]
    for child in list
        do (child) -> newlist=newlist.concat(func child)
    newlist

trans = (node) ->
    console.log node.type+' '+tokens[node.type]
    switch tokens[node.type]
        when 'SCRIPT' then transSCRIPT node
        when 'var' then transVAR node #var
        when 'IDENTIFIER' then transIDENTIFIER node #IDENTIFIER
        #when 'function' then transFUNCTION node #function
        #when '=' then transASSIGN node #assign
        #else transDEFAULT # no hago nada
        else [node]

jsinliner.inline = (code) ->
    {children: [statements...]} = node = narcissus.parser.parse code
    narcissus.decompiler.pp (trans node)[0]
    #expression.children[1].children[0].children[1].children
    #print statements[1]
