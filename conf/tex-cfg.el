;; -*- lexical-binding: t; -*-
;; get support for many of the LaTEX packages
(setq TeX-auto-save t
      TeX-parse-self t)
;; make AUCTEX aware of the multi-file document structure
(setq-default TeX-master nil)
