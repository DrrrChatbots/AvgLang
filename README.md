# AvgLang

Markdown liked language translated to html embedded with js.

Share your game by pasting the output to your Blog !

Usage: parse [file=script.md]

```shell
# Makefile :
#  compile parse.hs to executable

# tml.xml  :
#  template contained simple state machine to run script in json

# parse.hs :
#  translate script.md to json and insert it with tml.xml into output.html

# write your script into script.md
vim script.md
# then run make in shell
make
./parse
# -> output.html
# You can start the game in browser directly
google-chrome-stable output.html
# Or paste the html to your blog
```

AvgLang Syntax :
```
<script> ::= <scene> | <scene><script>

<scene> ::= "# "<name>"\n"
          | "# "<name>"\n"<content>
          | <scene><subSences>

<content> ::= <sentence> | <options> | <sentence><content>

<options> ::= <tagName> ":" <string> | <options>"\n"<options>

<subSences> ::= "## "<tagName>"\n"
              | "## "<tagName>"\n"<content>
              | <subSences><subSences>

<name> ::= <non-blank-string>

<tagName> :: <non-blank-string>

<sentence> ::= <string> | <string>"@"

<string> ::= <non-blank-string>
           | <non-blank-string><blank><non-blank-string>

<non-blank-string> ::= <fullwidth-words>
                     | <en-letters>
                     | <punctuations>
                     | <digits>
                     | <non-blank-string><non-blank-string>

<blank>  ::= " " | "\t" | <blank><blank>

<punctuations> ::= "~" | "!" | "$" | "%" | "^" | "&" | "*" | "(" | ")"
                 | "_" | "+" | "=" | "-" | "{" | "}" | "|" | "[" | "]" | "\"
                 | ";" | "'" | '"' | "," | "." | "/" | "<" | ">" | "?" | "~"
                 | <punctuations><punctuations>

<digits> ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
           | <digits><digits>

<en-letters> ::= "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k"
               | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v"
               | "w" | "x" | "y" | "z"
               | "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K"
               | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V"
               | "W" | "X" | "Y" | "Z"
               | <en-letters><en-letters>
```

Example :
```markdown
# At the park

Hi, how are you?@

A:Just fine.
B:Forget it!

## A
Well, unlike me...@

## B
What's wrong?@

```
```javascript
var script = [
   { title: 'At the park',
     pref:
      { sents: [ 'How are you?@' ],
        opts:  [ { tag: 'A', sent: 'Just fine.' },
                 { tag: 'B', sent: 'Forget it!'  } ] },
     subs:
      { A: { sents: ['Well, unlike me...@'], opts: [] } ,
        B: { sents: ['What's wrong?@'], opts: [] } } } ]
```

<div id="avg">
    <meta http-equiv="Content-Type" content="text/html; charset=    utf-8">
<script>
var scs = [{title:"At the park",pref:{sents:["Hi, how are you?@"],opts:[{tag:"A",sent:"Just fine."},{tag:"B",sent:"Forget it!"}]},subs:{"B":{sents:["What's wrong?@"],opts:[]},"A":{sents:["Well, unlike me...@"],opts:[]}}}]
</script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        var optsTag = '<div id="opts" style="text-align:center;background-color:#2d4e84;padding:10px;margin-bottom:5px;" ></div>';
        var scTagOpen = '<div style="display: none;margin-top:10px;margin-bottom:10px;margin-left:5px;"><h2 style="margin: 0;">';
        var scTagClos = '</h2></div>';

        var curSubs = undefined;
        var curSc = undefined;
        var curSents = [];
        var curOpts = [];
        function appendMain(tagStr, cbf){
            if(cbf == undefined){
                cbf = function(){};
            }
            var $new = $(tagStr);
            $('#avgMain').append($new);
            $new.show('slow' , cbf)
            .delay(1000000)
            .queue(cbf);
        }
        function newSc(){
            if(scs.length == 0){
                $('#next').hide();
                return false;
            }
            curSc = scs.pop(); appendMain(scTagOpen + curSc.title + scTagClos);
            curSents = curSc.pref.sents;
            curOpts = curSc.pref.opts;
            curSubs = curSc.subs;
            return true;
        }
        function genOpts(){
            $(optsTag).appendTo($('#avg')).show('slow');
            $('<button '
                + 'class="opt" opt="'
                + curOpts[0].tag
                + '">' + curOpts[0].sent
                + '</button>').appendTo('#opts').show('slow');
            for(var i = 1; i < curOpts.length; i++){
                $('<br><br><button '
                    + 'class="opt" opt="'
                    + curOpts[i].tag
                    + '">' + curOpts[i].sent
                    + '</button>').appendTo('#opts')
                .show('slow');
            }
        }
        function changeSc(name){
            curSents = curSubs[name].sents;
            curOpts = curSubs[name].opts;
        }
        function nextSent(){
            while(curSents.length == 0){
                if(curOpts.length == 0){
                    newSc();
                }
                else{
                    $('#next').hide();
                    genOpts();
                }
                $('html,body').animate({scrollTop: $('#avgMain').prop("scrollHeight")}, 500);
                return;
            }
            var e = undefined;
            var acc = '<div style="display: none;margin-top:10px;margin-bottom:10px;margin-left:20px;">';
                while(curSents.length != 0){
                    e = curSents.pop();
                    if(e.slice(-1) == '@') break;
                    acc += '<p style="margin: 0;">' + e + '</p>';
                    e = undefined;
                }
                if(e != undefined){
                    acc += '<p style="margin: 0;">' + e.substring(0, e.length - 1) + '</p>';
                }
                appendMain(acc + '</div>', function(){
                    if(curSents.length == 0 && curOpts.length == 0) nextSent();
                });

            $('html,body').animate({scrollTop: $('#avgMain').prop("scrollHeight")}, 500);
        }
        $(document).ready(function(){
            nextSent();
            $('#next').click(function(){
                nextSent();
            });
            $(document).on('click', '.opt', function () {
                changeSc(this.getAttribute("opt"));
                $('<p><b>' + this.textContent + '</b></p>')
                .appendTo('#avgMain').show('slow');
                $('#opts').remove();
                $('#next').show();
            });
            $(document).keypress(function(e) {
                if(e.which == 13 || e.width == 32) {
                    if($('#next').is(":visible")){
                        $('#next').click();
                    }
                }
            });
        });
    </script>
    <div id="avgMain">
    </div>

    <style>
        .noselect {
            -webkit-touch-callout: none; /* iOS Safari */
            -webkit-user-select: none; /* Safari */
            -khtml-user-select: none; /* Konqueror HTML */
            -moz-user-select: none; /* Firefox */
            -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently
            supported by Chrome and Opera */
        }
    </style>

    <div id="next" class="noselect" style="text-align:center;background-color:#2d4e84;padding:10px;margin-bottom:5px" >▽</div>

</div>
