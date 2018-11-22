# A simple makefile for OpenGL
# outputs an executable called particles and binary encoding .nv file

CC = /usr/local/opt/llvm/bin/clang++ -fopenmp -w
CFLAGS = -c -I/usr/local/opt/llvm/include
LIBS = -F/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks -framework OpenCL -framework OpenGL -framework GLUT -framework GLUI -L/usr/local/opt/llvm/lib
NUM_PARTICLES = 1048576 # num particles to generate; 1024 * 1024
TESTING = 0

all: particles.o
	$(CC) particles.o $(LIBS) -o particles

particles.o: particles.cpp
	$(CC) $(CFLAGS) -DNUM_PARTICLES=$(NUM_PARTICLES) -DTESTING=$(TESTING) particles.cpp

clean:
	rm -rf *.o particles particles.nv
