#lang racket

(provide #%module-begin
         #%app
         #%datum
         (rename-out [#%x-top-interaction #%top-interaction])
         stack-eval
         stack-program
         clear!
         pop!
         +
         -
         *
         /)

(require "utils.rkt")

(define clear! 'clear!)
(define pop! 'pop!)

(define-syntax-rule (#%x-top-interaction . input)
  (stack-eval input the-global-stack))

(define the-global-stack (list))

(define-syntax stack-program
  (syntax-rules ()
    [(stack-program argument)
     (stack-eval argument the-global-stack)]
    [(stack-program rest-arguments ... argument)
     (stack-eval argument (stack-program rest-arguments ...))]))

(define (stack-eval-internal arg the-stack)
  (cond
    [(number? arg) (cons arg the-stack)]
    [(stack-function? arg)
     (begin
       (define arguments (list))
       (for ([_ (in-range (stack-function-number-arguments arg))])
         (set! arguments (cons (car the-stack) arguments))
         (set! the-stack (cdr the-stack)))
       (cons (apply arg arguments) the-stack))]
    [(equal? arg clear!) (list)]
    [(equal? arg pop!) (cdr the-stack)]
    [else (begin
            (displayln (format "~a: Not recognized" arg))
            the-stack)]))

(define (stack-eval . args)
  (define the-next-stack (apply stack-eval-internal args))
  (set! the-global-stack the-next-stack)
  the-next-stack)

(struct stack-function (number-arguments function)
  #:property prop:procedure (struct-field-index function))

(define-syntax +
  (lambda (stx)
    (syntax-case stx ()
      [val
       (identifier? (syntax val))
       (syntax (stack-function 2 add))])))

(define-syntax -
  (lambda (stx)
    (syntax-case stx ()
      [val
       (identifier? (syntax val))
       (syntax (stack-function 2 sub))])))

(define-syntax *
  (lambda (stx)
    (syntax-case stx ()
      [val
       (identifier? (syntax val))
       (syntax (stack-function 2 mult))])))

(define-syntax /
  (lambda (stx)
    (syntax-case stx ()
      [val
       (identifier? (syntax val))
       (syntax (stack-function 2 div))])))
