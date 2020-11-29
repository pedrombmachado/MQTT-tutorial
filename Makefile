PROJECT_ROOT = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

NAME = subscriber
# subscriber publisher
OBJS = $(FILE_NAME).o
BUILD_MODE=run

ifeq ($(BUILD_MODE),debug)
	CFLAGS += -g
else ifeq ($(BUILD_MODE),run)
	CFLAGS += -O2 -Wall -Werror
else ifeq ($(BUILD_MODE),linuxtools)
	CFLAGS += -g -pg -fprofile-arcs -ftest-coverage
	LDFLAGS += -pg -fprofile-arcs -ftest-coverage
else
    $(error Build mode $(BUILD_MODE) not supported by this Makefile)
endif

OBJDIR = $(mkfile_dir)obj
BINDIR = $(mkfile_dir)bin
SRCDIR = $(mkfile_dir)src
OBJS = $(OBJDIR)/$(NAME).o

$(shell mkdir -p $(OBJDIR))
$(shell mkdir -p $(BINDIR))

all:	$(BINDIR)/$(NAME)

$(BINDIR)/$(NAME):	$(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $^ -ltbb --std=c++17 -lpaho-mqtt3as -lpaho-mqttpp3
$(OBJS):	$(PROJECT_ROOT)src/$(NAME).cpp
	$(CXX) -c $(CFLAGS) $(CXXFLAGS) $(CPPFLAGS) -o $@ $< -ltbb --std=c++17

clean:
	rm -rf -v $(OBJDIR) $(BINDIR)
