#-----------------------------------------|
# 1. Choose Debug/Release:                |
BUILD = Debug
#-----------------------------------------|
# 2. Choose x32/x64:                      |
ARCH = x64
#-----------------------------------------|
# 3. Choose platforms Win/Linux/Mac       |
PLATFORM = Win
#-----------------------------------------|
# 4. Choose compile name:                 |
CXX = g++
#-----------------------------------------|
# 5. Choose standard of C++:              |
STD = -std=c++17
#-----------------------------------------|
# 6. Type of optimization and flags:      |
#-----------------------------------------|
# 6.1. For Debug:                         |
OPT_D = -g -O0 -DDEBUG -Wall -Wextra
#-----------------------------------------|
# 6.2. For Release:                       |
OPT_R = -s -O2 -DNDEBUG
#-----------------------------------------|
# 7. Choose name of executable file       |
#-----------------------------------------|
# 7.1. For x32:                           |
EXE_32 = bin
#-----------------------------------------|
# 7.2. For x64:                           |
EXE_64 = bin64
#-----------------------------------------|
# 8. Choose name of directories           |
#------------------------------------------
# 8.1. For source files:                  |
SRC_DIR = src
#-----------------------------------------|
# 8.2. For headers files:                 |
HEADERS_DIR = headers
#-----------------------------------------|
# 8.3. For objective files:               |
OBJ_DIR = obj
#-----------------------------------------|
# 8.4. For exetutable file x32:           |
BIN_32_DIR = bin
#-----------------------------------------|
# 8.5. For executable file x64:           |
BIN_64_DIR = bin64
#-----------------------------------------|
# 8.6. For build settings:                |
BS_DIR = build
#-----------------------------------------|
# 9. Enter third party libs               |
# (leave empty if not):                   |
LIBS =
#-----------------------------------------|
# 10. Enter third party libs includes:    |
# (leave empty if not):                   |
INC = 
#-----------------------------------------|
# 11. Key word for removing all dir:      |
KEY_WORD_REMOVE = Remove_all
#-----------------------------------------|

# Flags for compilation:
CXXFLAGS = $(STD)

# Flags for Debug or Release:
ifeq ($(BUILD), Debug)
    CXXFLAGS += $(OPT_D)
else ifeq ($(BUILD), Release)
    CXXFLAGS += $(OPT_R)
else
    $(error "Error: Invalid build type (Used: $(BUILD), expected: Debug or Release)")
endif

# Flags for x32 or x64
ifeq ($(ARCH), x64)
    EXE = $(EXE_64)
    EXE_NAME = $(EXE_64)
    CXXFLAGS += -m64
    BIN_DIR = $(BIN_64_DIR)
else ifeq ($(ARCH), x32)
    EXE = $(EXE_32)
    EXE_NAME = $(EXE_32)
    CXXFLAGS += -m32
    BIN_DIR = $(BIN_32_DIR)
else
    $(error "Error: invalid architecture bit depth (Used: $(ARCH), expected: x32 or x64)")
endif

# Flags for platforms (Win/Linux/Mac)
ifeq ($(PLATFORM), Win)
    CXXFLAGS += -DWIN
    EXE = $(EXE_NAME).exe
    OBJ_F = obj
else ifeq ($(PLATFORM), Linux)
    CXXFLAGS += -DLINUX
    OBJ_F = o
else ifeq ($(PLATFORM), Mac)
    CXXFLAGS += -DMAC
    OBJ_F = o
    $(error "Unfortunately, comlilation for Mac has'nt ready yet")
else
    $(error "Error: invalid platform (Used: $(PLATFORM), expected: Win, Linux or Mac)")
endif

CXXFLAGS += -I$(HEADERS_DIR) $(INC) $(LIBS)

SRC = $(wildcard $(SRC_DIR)/*.cpp)
OBJ = $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.$(OBJ_F), $(SRC))

# Launching:
RUN = ./$(BIN_DIR)/$(EXE)

# Compilation: create object files from source and linking them to create the executable
comp: $(BIN_DIR)/$(EXE) clean

# Linking: create the executable from object files
$(BIN_DIR)/$(EXE): $(OBJ)
	rm -rf $(BIN_32_DIR)
	rm -rf $(BIN_64_DIR)
	mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^

# Compiling: create object files from source files
$(OBJ_DIR)/%.$(OBJ_F): $(SRC_DIR)/%.cpp
	mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Launching:
run:
	@$(RUN)

# Compile + Run:
all: comp run

# Cleaning:
clean:
	rm -rf $(OBJ_DIR)

# Remove directories with objective and executable file:
delbin:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

# Remove all directories:
remove:
	@read -p "Do you really want to delete all project directories (y/n)?: " answer_remove_dir && \
	if [ "$$answer_remove_dir" = "y" ]; then \
		read -p "Warning! All files will be removed. You will not restore changes (y/n)?: " confirm_remove && \
		if [ "$$confirm_remove" = "y" ]; then \
			read -p "Enter key word ($(KEY_WORD_REMOVE)): " enter_dir && \
			if [ "$$enter_dir" = $(KEY_WORD_REMOVE) ]; then \
				rm -rf $(SRC_DIR) $(HEADERS_DIR) $(BS_DIR) $(OBJ_DIR) $(BIN_DIR); \
				echo "All directories has removed without restoration..."; \
			else \
				echo "Wrong root directory name"; \
			fi; \
		else \
			echo "Deletion aborted by user."; \
		fi; \
	else \
		echo "Operation aborted by user."; \
	fi

# Create all directories:
create:
	mkdir -p $(SRC_DIR) $(HEADERS_DIR) $(BS_DIR)
	@if [ ! -f ./src/main.cpp ]; then \
	    touch $(SRC_DIR)/main.cpp; \
	    echo '#include <iostream>' > $(SRC_DIR)/main.cpp; \
	    echo '' >> $(SRC_DIR)/main.cpp; \
	    echo 'int main ()' >> $(SRC_DIR)/main.cpp; \
	    echo '{' >> $(SRC_DIR)/main.cpp; \
	    echo '    setlocale(LC_ALL, "ru");' >> $(SRC_DIR)/main.cpp; \
	    echo '' >> $(SRC_DIR)/main.cpp; \
	    echo '    std::cout << "Hello, World!" << std::endl;' >> $(SRC_DIR)/main.cpp; \
	    echo '' >> $(SRC_DIR)/main.cpp; \
		echo '    system("pause");' >> $(SRC_DIR)/main.cpp; \
		echo '' >> $(SRC_DIR)/main.cpp; \
	    echo '    return 0;' >> $(SRC_DIR)/main.cpp; \
	    echo '}' >> $(SRC_DIR)/main.cpp; \
	fi

gcreate: create

	@if [ ! -d ./.git ]; then \
		git init; \
		echo '[alias]' >> .git/config; \
		echo '    s = status --short' >> .git/config; \
		echo '    l = log --oneline' >> .git/config; \
		echo '    g = log --graph --abbrev-commit --decorate --all --format=format:'"'"'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C (reset)%n %C(white)%s%C(reset)'"'"'' >> .git/config; \
		echo '    cm = commit -m' >> .git/config; \
		echo '    co = checkout' >> .git/config; \
		echo '    br = branch' >> .git/config; \
	fi

cm:
	@read -p "Enter the names of files and/or directories to send to GitHub: " input_files && \
	git add $$input_files && \
	read -p "Enter commit message: " input_commit && \
	git commit -m "$$input_commit"

push:
	git push