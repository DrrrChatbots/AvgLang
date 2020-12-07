# AvgLang

---

The newer version is under rewriting by [pureScript](https://github.com/purescript/documentation/blob/master/language/README.md),
I will use the [parsing](https://github.com/purescript-contrib/purescript-parsing) library to re-design the language, and it would be ported to [drrr chatbot extension](https://chrome.google.com/webstore/detail/drrr-chatbot-extension/fkmpnkcjocenkliehpdhlfbmdmdnokgm) to support some TRPG game.

---

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

