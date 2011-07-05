jsinliner = require "../lib/jsinliner"

exports["jscode"] = (test) ->
    code = '''
        var y = 4;
        var x = 3;
        var z = 5;

        if ( z == 5 ) {
            y = x;
        } else {
            x = y;
        }


    '''
    codeNoTested = '''
    var y = 4;
    y + 3;
    if ( y == 10) {
        y++;
    }

    eval('hello world!');

    function a() {
        console.log('hi');
    };
    
    var b = function() {
        console.log('yeah!');
    }'''

    jsinliner.inline(code)

    test.done()

#exports["test some stuff"] = (test) ->
#    test.expect 1
#    test.ok true, "this assertion should pass"
#    test.done()
#
#exports["test some other stuff"] = (test) ->
#    test.ok false, "this assertion should fail"
#    test.done()
