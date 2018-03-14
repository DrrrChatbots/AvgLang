# AvgLang

Markdown liked language compiled to html embedded with js.

Share your script by pasting the output to your Blog !

Syntax :
```

<script> ::= <sence> | <sence><script>

<sence> ::= #<space><name>\n
          | #<space><name>\n<content>
          | <sence><subSence>

<content> ::= <sentence> | <option> | <content>\n<content>

<option> ::= <tagName> : <subSentence>

<subSence> ::= ##<space><tagName>\n
             | ##<space><name>\n<content>

<name> ::= <string>
<tagName> :: <string>
<sentence> ::= <string> | <string>@
```

