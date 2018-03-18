# AvgLang

Markdown liked language translated to html embedded with js.

Share your game by pasting the output to your Blog !

Syntax :
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
