# LDPC-codes

@Yuanyuan Tang

Understood LDPC code, encoding and decoding codewords over a Gaussian channel

Reference: 
        
 a)  https://www.itsoc.org/conferences/schools/past-schools/na-school-2009/lecture-files/Costello-3.pdf
       
 b)  Willian E. Ryan, An Introduction to LDPC codes,   http://tuk88.free.fr/LDPC/ldpcchap.pdf
       
 c)  LDPC codes: Achieving the Capacity of the Binary Erasure Channel,   https://community.wvu.edu/~mcvalenti/documents/LDPC2009.pdf

 d)  https://blog.csdn.net/qq_37654178/article/details/120458583
       
       
The LDPC decoder is achieved by transmitting likelihood message over the tanner graph and simulated by MATLAB. 


I have achieved encoding and the decoding algorithms by transmitting both the likelihood probability and the log-ratio of probability. 


Please test the example by running main.m and main_log_LDPC over MATLAB
   
  a) main--test LDPC decoding by passing likelihood probability
   
  b) main_log_LDPC--test LDPC decoding by passing the log-ratio probability


