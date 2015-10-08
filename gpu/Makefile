CUDA_FLAG =-gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 -gencode arch=compute_37,code=sm_37 -gencode arch=compute_50,code=sm_50 -gencode arch=compute_50,code=compute_50 -O3 -m64 -maxrregcount 32 
CC_FLAG = $(CUDA_FLAG) -dc

cuda : ec-method.o test.o  
	nvcc ec-method.o test.o -o cuda $(CUDA_FLAG) 

test.o: test.cu
	nvcc -c test.cu $(CC_FLAG)

ec-method.o : ec-method.cu ec-method.h
	nvcc -c ec-method.cu $(CC_FLAG)

clean :
	rm ec-method.o test.o cuda



