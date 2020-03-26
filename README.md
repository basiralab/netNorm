# netNorm (Network Normalization)
netNorm (network normalization) framwork for multi-view network integration (or fusion), created by Salma Dhifallah. Please contact salmadhifalah@gmail.com for inquiries. Thanks. 

This work is published in the journal of Medical Image Analysis, 2020.

**netNorm can be used to integrate a population of multi-view network datasets with heterogeneous distributions, given that they have the same size.**

**Application to multi-view brain networks** The brain connectome encodes different facets of the brain construct such as function and structure in a network. Noting that a brain network captures the individual signature of a particular subject, it remains a formidable challenge to extract a shared and representative brain signature across a population of brain networks, let alone multi-view brain networks. In this paper, we propose netNorm, a method that can meet this challenge by normalizing a population of multi-view brain networks, where each brain network represents a particular view of the brain, acquired using a neuroimaging technique. While conventional methods integrate the network views equally at a global scale, we propose a selective technique which unfolds the fusion process at a local scale by first selecting for each local pairwise connectivity between two anatomical regions of interest the most representative cross-view feature vector in the population. By combining the selected cross-view feature vectors, we then estimate a population representative tensor. Such multi-view representation captures the most shared traits across all subjects and thereby occupies a centered location compared to all views. In the final step, netNorm non-linearly fuses the frontal views of the estimated representative population tensor into a single network depicting the final brain connectional template. We demonstrate the broad applicability of our method on four connectomic datasets and we show that netNorm (i) produces the most centered and representative connectional brain template (CBT) that consistently captures the unique and distinctive traits of a population of multi-view brain networks, and (ii) identifies disordered brain connections by comparing templates estimated using disordered and healthy brains, respectively, demonstrating the discriminative power of the estimated CBTs. This allows to rapidly and efficiently spot atypical deviations from the normal brain connectome for comparative studies, circumventing the need to use machine learning techniques for discriminative feature identification.

![netNorm pipeline]( http://basira-lab.com/netnorm2020/)

In this repository, we release the code to train and test netNorm on multi-view networks of same size. We have also added the estimated CBTs (connectional brain templates) for the data used on the paper for ASD population (subjects with autism spectrum disorder) and NC (normal controls) for both left and right hemispheres (RH and LH) from ABIDE preprocessed dataset (http://preprocessed-connectomes-project.org/abide/). 


# Code

This code was implemented using Matlab 2018a on Windows 7. 

**Data Preparation**

We simulate random data sets using the Matlab function simulateData.m. The number of views, the number of subjects and ROIs (must be >20) are fixed by the user. In order to test netNorm on other datasets, upload the data as a cell variable of size n_v (number of views). Each cell stores a view tensor of size m^2*N where m is the number of nodes in the network and N is the number of subjects (samples). Every frontal matrix in the tensor represents a network for a subject j. 

**Install SNF code**
To run netNorm, include SNF code: http://compbio.cs.toronto.edu/SNF/SNF/Software.html.

**Run netNorm**

Use the function netNorm.m to run the demo using simulated data.


# Acknowledgement

# Related references

Similarity Network Fusion (SNF): Wang, B., Mezlini, A.M., Demir, F., Fiume, M., Tu, Z., Brudno, M., HaibeKains, B., Goldenberg, A., 2014. Similarity network fusion for aggregating data types on a genomic scale. [http://www.cogsci.ucsd.edu/media/publications/nmeth.2810.pdf] (2014) [https://github.com/maxconway/SNFtool]. 


# Please cite the following paper when using netNorm:

@article{dhifallah2020,
  title={Estimation of connectional brain templates using selective multi-view network normalization},<br/>
  author={Dhifallah, Salma and Rekik, Islem and Alzheimer's Disease Neuroimaging Initiative and others},<br/>
  journal={Medical Image Analysis},<br/>
  volume={59},<br/>
  pages={101567},<br/>
  year={2020},<br/>
  publisher={Elsevier}<br/>
}<br/>

Paper link on ResearchGate:
https://www.researchgate.net/publication/336211539_Estimation_of_Connectional_Brain_Templates_using_Selective_Multi-View_Network_Normalization

# License
Our code is released under MIT License (see LICENSE file for details).








