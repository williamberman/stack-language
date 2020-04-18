Example racket language for personal reference.

```
git clone https://github.com/williamberman/stack-language.git
cd stack-language
raco pkg install
```

Run from a file, racket <filename>
```
#lang stack-language
2
3
4
+
*
```
=> '(4)

Run a repl.
The `racket -I` command doesn't work at the moment, but a repl can be started from a file with `#lang stack-language` from
racket-mode or DrRacket.
```
racket -I stack-language
'()
> 2
'(2)
> 3
'(3 2)
> 4
'(4 3 2)
> +
'(7 2)
> *
'(14)
```



