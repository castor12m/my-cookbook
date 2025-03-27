<center>
<img src="./resource/readme/catplus.png" width="50%" height="50%" title="px(픽셀) 크기 설정" alt="logo" border-radius="90px"></img>
</center>

# NOTE SHELL

<br/>



## 1. 대소문자 관련

https://scriptingosx.com/2019/12/upper-or-lower-casing-strings-in-bash-and-zsh/

### 1.1. bash3 이상 버전

```bash
    name="John Doe"
    # sh
    echo $(echo "$name" |  tr '[:upper:]' '[:lower:]' )
    john doe

    # bash3
    echo $(tr '[:upper:]' '[:lower:]' <<< "$name")
    john doe
```

### 1.2. bash5 이상 버전

```bash
    name="John Doe"
    echo ${name,,}
    john doe
    echo ${name^^}
    JOHN DOE
```

### 1.3. Zsh

In zsh you can use expansion modifiers:

```bash
    % name="John Doe"
    % echo ${name:l}
    john doe
    % echo ${name:u}
    JOHN DOE
```

You can also use expansion flags:

```bash    
    % name="John Doe"    
    % echo ${(L)name}     
    john doe
    % echo ${(U)name}
    JOHN DOE
```

## A. 와우...bash cheat sheet

- link
    - https://github.com/RehanSaeed/Bash-Cheat-Sheet

