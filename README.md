# LDPC-codes

@Yuanyuan Tang

Understood LDPC codes and decoding codewords over a Gaussian channel

Reference: 
        
       a) https://www.itsoc.org/conferences/schools/past-schools/na-school-2009/lecture-files/Costello-3.pdf
       
       b) Willian E. Ryan, An Introduction to LDPC codes, http://tuk88.free.fr/LDPC/ldpcchap.pdf
       
       c) LDPC codes: Achieving the Capacity of the Binary Erasure Channel, https://community.wvu.edu/~mcvalenti/documents/LDPC2009.pdf
       
       d) 5G NR LDPC, https://www.cambridge.org/core/services/aop-cambridge-core/content/view/CF52C26874AF5E00883E00B6E1F907C7/S2048770319000106a.pdf/an_overview_of_channel_coding_for_5g_nr_cellular_communications.pdf


The LDPC decoder is achieved by transmitting likelihood message over the tanner graph and simulated by MATLAB. 


I have achieved the decoding algorithms by transmitting both the likelihood probability and the log-ratio of probability. 


Please test the example by running main.m and main_log_LDPC over MATLAB
   
       a) main--test LDPC decoding by passing likelihood probability
   
       b) main_log_LDPC--test LDPC decoding by passing the log-ratio probability


