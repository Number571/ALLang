CC=gcc
CFLAGS=-Wall -std=c99

FILES=ctall.c readtall.c extclib/extclib.o

.PHONY: default install build trun vrun clean
default: build trun vrun 

install:
	git clone https://github.com/number571/CVM.git || true
	make install -C CVM/
	make build -C CVM/
	cp CVM/cvm .
	git clone https://github.com/number571/extclib.git || true
	make -C extclib/
build: $(FILES)
	$(CC) -o ctall $(CFLAGS) $(FILES) -lcrypto
trun: ctall
	./ctall build main.all -o main.vms
vrun: cvm 
	./cvm build main.vms -o main.vme
	./cvm run main.vme
clean:
	rm -rf extclib/ CVM/
	rm -f cvm ctall main.vms main.vme
