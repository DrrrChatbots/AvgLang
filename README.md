# AvgLang

Markdown liked language compiled to html embedded with js.

Share your script by pasting the output to your Blog !

Syntax :
```
<script> ::= <sence> | <sence><script>

<sence> ::= #<space><name>\n
          | #<space><name>\n<content>
          | <sence><subSence>

<content> ::= <sentence> | <options> | <content>\n<content>

<options> ::= <tagName> : <subSentence> | <options>\n<options>

<subSence> ::= ##<space><tagName>\n
             | ##<space><name>\n<content>

<name> ::= <non-blank-string>

<tagName> :: <non-blank-string>

<sentence> ::= <string> | <string>@

<string> ::= <non-blank-string>
           | <non-blank-string><blank><non-blank-string>

<non-blank-string> ::= <fullwidth-words>
                     | <en-letters>
                     | <punctuations>
                     | <digits>
                     | <non-blank-string><non-blank-string>

<blank>  ::= <space> | \n | \t | <blank><blank>

<punctuations> ::= ~ | ! | $ | % | ^ | & | * | ( | )
                 | _ | + | = | - | { | } | | | [ | ] | \
                 | ; | ' | " | , | . | / | < | > | ? | ~
                 | <punctuations><punctuations>

<digits> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
           | <digits><digits>

<en-letters> ::= a | b | c | d | e | f | g | h | i | j | k
               | l | m | n | o | p | q | r | s | t | u | v
               | w | x | y | z
               | A | B | C | D | E | F | G | H | I | J | K
               | L | M | N | O | P | Q | R | S | T | U | V
               | W | X | Y | Z
               | <en-letters><en-letters>
```

