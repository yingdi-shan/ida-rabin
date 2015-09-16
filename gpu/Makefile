CUDA_FLAG =-gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -O3  
CC_FLAG = $(CUDA_FLAG) -dc

cuda : ec-method.o test.o ec-gf.o  
	nvcc ec-method.o test.o ec-gf.o -o cuda $(CUDA_FLAG) 

test.o: test.cu
	nvcc -c test.cu $(CC_FLAG)

ec-method.o : ec-method.cu ec-method.h ec-gf.h
	nvcc -c ec-method.cu $(CC_FLAG)

ec-gf.o : ec-gf.cu ec-gf.h
	nvcc -c ec-gf.cu $(CC_FLAG)

clean :
	rm ec-method.o ec-gf.o test.o cuda



