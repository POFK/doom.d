# My emacs configuration

## track pyim files
```sh
git lfs track pyim/dcache/pyim-*
```

add mirrors:

```
(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                       ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("stable-melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")
			 ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(setq package-archives '(("gnu"    . "http://dev.pangu.datalab:7788/elpa/gnu/")
                         ("nongnu" . "http://dev.pangu.datalab:7788/elpa/nongnu/")
                         ("stable-melpa" . "http://dev.pangu.datalab:7788/elpa/stable-melpa/")
                         ("melpa"  . "http://dev.pangu.datalab:7788/elpa/melpa/")
                         ("org" . "http://dev.pangu.datalab:7788/elpa/org/")))
```
