https://stackoverflow.com/questions/12896988/passing-an-argument-to-cmake-via-command-prompt

## CMakeLists 다음과 같이

CMakeLists.txt

```cmake
    message("MY_VARIABLE=${MY_VARIABLE}")
    if( MY_VARIABLE ) 
        message("MY_VARIABLE evaluates to True")
    endif()

    (...)
```

```bash
    $ cmake ..
    MY_VARIABLE=
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /path/to/build

    $ cmake .. -DMY_VARIABLE=True
    MY_VARIABLE=True
    MY_VARIABLE evaluates to True
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /path/to/build

    $ cmake .. -DMY_VARIABLE=False
    MY_VARIABLE=False
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /path/to/build

    $ cmake .. -DMY_VARIABLE=1
    MY_VARIABLE=1
    MY_VARIABLE evaluates to True
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /path/to/build

    $ cmake .. -DMY_VARIABLE=0
    MY_VARIABLE=0
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /path/to/build
```

문자열은 다음과 같이

```
    $ cmake .. -DMY_VARIABLE:STRING=option_value2
```