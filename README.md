Example racket language for personal reference.

```
git clone < url >
cd < directory >
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
This doesn't work, but a repl can be started from a file with the `#lang stack-language` from
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



