
## 1. 목표

/var/www/bookstack
하위에 자동으로 소스가 설치된 상황

~/workspace/ 하위의 폴더에 폴더가 공유되었으면 하는게 목적


## 2. 작업

https://askubuntu.com/questions/205841/how-do-i-mount-a-folder-from-another-partition

마운트

```bash
    $ cd ~/workspace/
    $ mkdir bookstack-host

    $ mount --bind /var/www/bookstack ~/workspace/bookstack-host
```

https://www.linux.co.kr/bbs/board.php?bo_table=qa_linux&wr_id=40325

마운트 해제

```bash
    $ unmount ~/workspace/bookstack-host
```