jsinliner = require "../lib/jsinliner"

exports["test some stuff"] = (test) ->
    test.expect 1
    test.ok true, "this assertion should pass"
    test.done()

exports["test some other stuff"] = (test) ->
    test.ok false, "this assertion should fail"
    test.done()
