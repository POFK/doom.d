;;; workflow/chatgpt/config.el -*- lexical-binding: t; -*-

(setq pangu-conn (pangu-make-conn "localhost" 29001))

                                        ;(after! 'pangu
                                        ;  (setq pangu-conn (pangu-make-conn "localhost" 29001))
                                        ;  )

(setq atom-conn (atom-make-conn "localhost" 38000))
