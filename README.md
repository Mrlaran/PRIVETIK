# 1. Install make
Input this commands in terminal:

1.1. For Linux distributions

* Ubuntu/Debian 

```
sudo apt-get update | sudo apt install make
```

* Fedora:

```
sudo dnf install make
```

* CentOS/RHEL:

```
sudo yum install make
```

* Arch Linux:

```
sudo pacman -S base-devel

```

1.2. For MacOS:

```
xcode-select --install
```

1.3. For Windows

* Download MSYS2

>https://www.msys2.org/

Download (for example) in directory: "C:\Programs\msys64\" or "C:\msys64\"

* Add in field "Path" in **Environment variables in Windows** your path "C:\Programs\msys64\mingw64\bin" or "C:\msys64\mingw64\bin"

>If you use x32 bitness arhitecture, use folder *mingw32* and terminal *MinGw32*

* Open **Start menu** and launch **MSYS2 MINGW64**

Input command in terminal MINGW64:

```
pacman -Syu
```

Then for x64:

```
pacman -S mingw-w64-x86_64-gcc
```

For x32:

```
pacman -S mingw-w64-i686-gcc
```

Install make in MSYS2 MINGW64:

```
pacman -S make
```

* Add in field "Path" at **Environment variables in Windows** your path for **make** "C:\Programs\msys64\mingw64\usr\bin" or "C:\msys64\mingw64\usr\bin"

>If you use x32 bitness arhitecture, use folder *mingw32* and terminal *MinGw32*

* If you use VS Code, run VS Code as **administrator**, because compilation with g++ requests access to temporary files in the **Temp** folder if you use **make** in GitBush 

>Unfortunately, I haven't added MSVC and cl compiles yet, but I'm working on this function

# 2. Download Git

>https://git-scm.com/

>If you work on Windows, make sure that you pushed checkbox on installation **GitBush** terminal, because it may be useful for you 

# 3. Create working dirеctories
3.1. Create directory, then go to this directoty:

```
cd <some directories>
```

3.2. Input this command in terminal to create "src", "headers" and build" directories and main.cpp file:

```
make create
```

3.3. If you want to create directories with **git** initialization, use this command:

```
make gcreate
```

>Be warned, this command performs commant **git init** and creates hidden folder with **git** configuration file

>You may change name of this directories in Makefile (change points 7.1 - 10)

# 4. Compile your project
In Makefile you can choose some parametrs:

* Type of build:

```
#-----------------------------------------|
# 1. Choose Debug/Release:                |
BUILD = Debug
#-----------------------------------------|
```

* Bitness of architecture:

```
#-----------------------------------------|
# 2. Choose x32/x64:                      |
ARCH = x64
#-----------------------------------------|
```

* Platform:

```
#-----------------------------------------|
# 3. Choose platforms Win/Linux/Mac       |
PLATFORM = Linux
#-----------------------------------------|
```

And differend parametrs by point 10 

4.1. Input this command in terminal to compile your project:

```
make comp
```

# 5. Run your project
4.1. Input this command in terminal:

```
make run
```

5.2. Also, you may compile and run project by command:

```
make all
```

# 6. Create commit at git
6.1. Input this command in terminal:

```
make cm
```

`
Enter the names of files and/or directories to send to GitHub:
`
as you do when using the **git init** command

`
Enter commit message
`
without *" "*

6.2. If you want to send changes at GitHub repository use this command:

```
make push
```

# 7. Remove directories with objective and executable files
Input this commands in terminal to:

7.1. Remove directories with objective and executable files:

```
make delbin
```

7.2. Remove all directories without restoration:

***Warning! Use this command with caution. Srpipt will request confirmation of actions***

```
make remove
```

`
Do you really want to delete all project directories (y/n)?:
`
y

`
Warning! All files will be removed. You will not restore changes (y/n)?:
`
y

`
Enter key word (Remove_all):
`
Remove_all
____

>Edit Makefile for your purpose