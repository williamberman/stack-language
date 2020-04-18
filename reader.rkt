#lang racket

(require "datum.rkt")

(provide (rename-out [x-read-syntax read-syntax])
         (rename-out [x-read read]))

(define (x-read-syntax path port)
  (define the-arguments (format-datums '~a (port->lines port)))
  (define the-module `(module stacker-module "expander.rkt" (stack-program ,@the-arguments)))
  (define the-syntax (datum->syntax #f the-module))
  the-syntax)

(define (x-read in)
  (x-read-syntax #f in))
